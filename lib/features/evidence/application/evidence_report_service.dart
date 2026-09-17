import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/integrity/integrity_copy.dart';
import '../../../core/integrity/integrity_service.dart';
import '../../../core/files/evidence_photo_asset_repository.dart';
import '../../../core/utils/id_generator.dart';
import '../../meters/domain/meter.dart';
import '../../meters/domain/meter_reading.dart';
import '../../meters/domain/meter_reading_order.dart';
import '../../meters/domain/meter_repositories.dart';
import '../domain/evidence_export.dart';

class GeneratedEvidenceReport {
  const GeneratedEvidenceReport({required this.record, required this.bytes});

  final EvidenceExportRecord record;
  final Uint8List bytes;
}

typedef DocumentsDirectoryProvider = Future<Directory> Function();

class EvidenceReportService {
  EvidenceReportService({
    required this.exports,
    this.integrity = const IntegrityService(),
    DocumentsDirectoryProvider? documentsDirectoryProvider,
    EvidencePhotoAssetRepository? photoAssets,
  }) : _documentsDirectoryProvider =
           documentsDirectoryProvider ?? getApplicationDocumentsDirectory,
       photoAssets = photoAssets ?? LocalEvidencePhotoAssetRepository();

  final EvidenceExportRepository exports;
  final IntegrityService integrity;
  final DocumentsDirectoryProvider _documentsDirectoryProvider;
  final EvidencePhotoAssetRepository photoAssets;

  Future<void> delete(EvidenceExportRecord record) async {
    final file = File(record.filePath);
    if (await file.exists()) {
      await file.delete();
    }
    await exports.delete(record.id);
  }

  Future<GeneratedEvidenceReport> createSingle({
    required MeterReading reading,
    required List<ReadingRevision> revisions,
    EvidencePhotoMode photoMode = EvidencePhotoMode.currentPhotos,
  }) async {
    final reportMeter = reading.meter;
    final manifestSha = await _reportManifestHash(
      [reading],
      {reading.id: revisions},
      reportMeter,
    );
    return _create(
      readings: [reading],
      kind: EvidenceExportKind.singleReading,
      photoMode: photoMode,
      manifestSha256: manifestSha,
      reportMeter: reportMeter,
    );
  }

  Future<GeneratedEvidenceReport> createHistory({
    required Meter meter,
    required List<MeterReading> readings,
    required Map<String, List<ReadingRevision>> revisions,
    EvidencePhotoMode photoMode = EvidencePhotoMode.currentPhotos,
  }) async {
    if (readings.isEmpty) {
      throw StateError('Für dieses Projekt gibt es noch keine Projektstände.');
    }
    final sortedReadings = [...readings]
      ..sort((left, right) => left.capturedAt.compareTo(right.capturedAt));
    if (sortedReadings.any((reading) => reading.meterId != meter.id)) {
      throw StateError('Die Projektstände gehören nicht zu diesem Projekt.');
    }
    final reportMeter = MeterSnapshot.fromMeter(meter);
    final manifestSha = await _reportManifestHash(
      sortedReadings,
      revisions,
      reportMeter,
    );
    // Keep the existing manifest normalization separate from presentation.
    sortedReadings.sort(compareReadingsNewestFirst);
    return _create(
      readings: sortedReadings,
      kind: EvidenceExportKind.meterHistory,
      photoMode: photoMode,
      manifestSha256: manifestSha,
      reportMeter: reportMeter,
    );
  }

  Future<GeneratedEvidenceReport> _create({
    required List<MeterReading> readings,
    required EvidenceExportKind kind,
    required EvidencePhotoMode photoMode,
    required String manifestSha256,
    required MeterSnapshot reportMeter,
  }) async {
    final createdAt = DateTime.now();
    final fonts = await _loadFontBytes();
    // Historical "allPhotos" remains readable on saved export records only.
    if (photoMode == EvidencePhotoMode.allPhotos) {
      photoMode = EvidencePhotoMode.currentPhotos;
    }
    final preparedPhotoPaths = await _preparePhotos(
      readings: readings,
      photoMode: photoMode,
    );
    final buildResult = await compute(_buildPdfInBackground, <String, Object?>{
      'readings': readings.map((reading) => reading.toJson()).toList(),
      'kind': kind.name,
      'photoMode': photoMode.name,
      'preparedPhotoPaths': preparedPhotoPaths,
      'createdAtMicroseconds': createdAt.microsecondsSinceEpoch,
      'manifestSha256': manifestSha256,
      'reportMeter': reportMeter.toJson(),
      'regularFontBytes': fonts.regular,
      'boldFontBytes': fonts.bold,
    }, debugLabel: 'evidence-pdf-builder');
    final bytes = buildResult['bytes']! as Uint8List;
    final manifestSha = buildResult['manifestSha256']! as String;
    final pdfSha = buildResult['pdfSha256']! as String;
    final id = newLocalId('evidence', now: createdAt);
    final safeLabel = _safeFilePart(reportMeter.label);
    final stamp = DateFormat('yyyyMMdd_HHmmss').format(createdAt);
    final uniqueSuffix = id.substring(id.length - 6);
    final variant = switch (photoMode) {
      EvidencePhotoMode.withoutPhotos => 'kompakt',
      EvidencePhotoMode.currentPhotos => 'mit_fotos',
      EvidencePhotoMode.allPhotos => 'alle_fotos',
    };
    final fileName = kind == EvidenceExportKind.singleReading
        ? 'lesestand_${safeLabel}_${variant}_${stamp}_$uniqueSuffix.pdf'
        : 'leseverlauf_${safeLabel}_${variant}_${stamp}_$uniqueSuffix.pdf';
    final directory = Directory(
      p.join((await _documentsDirectoryProvider()).path, 'evidence_reports'),
    );
    await directory.create(recursive: true);
    final file = File(p.join(directory.path, fileName));
    await file.writeAsBytes(bytes, flush: true);
    final record = EvidenceExportRecord(
      id: id,
      meterId: readings.first.meterId,
      kind: kind,
      readingIds: readings.map((reading) => reading.id).toList(),
      createdAt: createdAt.toUtc(),
      fileName: fileName,
      filePath: file.path,
      pdfSha256: pdfSha,
      manifestSha256: manifestSha,
      photoMode: photoMode,
    );
    await exports.save(record);
    return GeneratedEvidenceReport(record: record, bytes: bytes);
  }

  Future<Map<String, String>> _preparePhotos({
    required List<MeterReading> readings,
    required EvidencePhotoMode photoMode,
  }) async {
    if (photoMode == EvidencePhotoMode.withoutPhotos) {
      return const <String, String>{};
    }
    final versions = <ReadingPhotoVersion>[
      for (final reading in readings)
        if (photoMode == EvidencePhotoMode.currentPhotos) ...[
          ...reading.currentPhotos,
        ] else
          ...reading.allPhotoVersions,
    ];
    final versionsByHash = <String, List<ReadingPhotoVersion>>{};
    for (final version in versions) {
      versionsByHash.putIfAbsent(version.sha256, () => []).add(version);
    }
    final prepared = <String, String>{};
    final groups = versionsByHash.entries.toList(growable: false);
    for (var offset = 0; offset < groups.length; offset += 2) {
      final batch = groups.skip(offset).take(2).toList(growable: false);
      final paths = await Future.wait(
        batch.map((group) {
          final representative = group.value.first;
          return photoAssets.prepare(
            path: representative.path,
            sha256: representative.sha256,
          );
        }),
      );
      for (var index = 0; index < batch.length; index++) {
        final path = paths[index];
        if (path == null) continue;
        for (final version in batch[index].value) {
          prepared[version.path] = path;
        }
      }
    }
    return prepared;
  }

  static Future<Map<String, Object?>> _buildPdfInBackground(
    Map<String, Object?> message,
  ) async {
    final readings = (message['readings']! as List)
        .map(
          (json) =>
              MeterReading.fromJson(Map<String, dynamic>.from(json as Map)),
        )
        .toList(growable: false);
    final kind = EvidenceExportKind.values.byName(message['kind']! as String);
    final photoMode = EvidencePhotoMode.values.byName(
      message['photoMode']! as String,
    );
    final photoAssets = _PdfPhotoAssets(
      Map<String, String>.from(message['preparedPhotoPaths']! as Map),
    );
    final reportMeter = MeterSnapshot.fromJson(
      Map<String, dynamic>.from(message['reportMeter']! as Map),
    );
    final createdAt = DateTime.fromMicrosecondsSinceEpoch(
      message['createdAtMicroseconds']! as int,
    );
    final regularFontBytes = message['regularFontBytes']! as Uint8List;
    final boldFontBytes = message['boldFontBytes']! as Uint8List;
    final fonts = _ReportFonts(
      regular: pw.Font.ttf(ByteData.sublistView(regularFontBytes)),
      bold: pw.Font.ttf(ByteData.sublistView(boldFontBytes)),
    );
    final manifestSha = message['manifestSha256']! as String;
    final document = pw.Document(
      title: 'Projektprotokoll',
      author: 'Strick & Häkelbuch',
      subject: 'Private Dokumentation eines Projektstands',
    );
    final date = DateFormat('dd.MM.yyyy, HH:mm');

    document.addPage(
      pw.MultiPage(
        // This debug guard counts pages of one spanning table. Larger text can
        // take a year-long history beyond the default 20; each row still fits
        // on a page, so retain a finite guard based on the number of readings.
        maxPages:
            20 +
            readings.fold<int>(
              0,
              (total, reading) =>
                  total +
                  3 +
                  reading.currentPhotos.length * 2 +
                  (reading.note.length / 500).ceil(),
            ),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(base: fonts.regular, bold: fonts.bold),
        header: (context) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 10),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'STRICK & HÄKELBUCH',
                style: pw.TextStyle(
                  color: PdfColor.fromHex('#526B59'),
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              pw.Text(
                'Seite ${context.pageNumber} von ${context.pagesCount}',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
        ),
        footer: (_) => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 10),
          child: pw.Text(
            pdfPrivateDocumentationText,
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
          ),
        ),
        build: (_) => [
          pw.SizedBox(height: 16),
          pw.Text(
            'Projektprotokoll',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            kind == EvidenceExportKind.singleReading
                ? 'Einzelner Projektstand'
                : 'Projektverlauf',
            style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            'PDF erstellt am ${date.format(createdAt)} · ${photoMode.labelFor(kind)}',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 18),
          ..._bookSection(reportMeter, kind),
          pw.SizedBox(height: 18),
          if (kind == EvidenceExportKind.singleReading)
            ..._readingSection(
              reading: readings.single,
              number: 1,
              date: date,
              photoMode: photoMode,
              photoAssets: photoAssets,
            ),
          if (kind == EvidenceExportKind.meterHistory) ...[
            _historyTable(readings, date),
            for (final (index, reading) in readings.indexed)
              if (_hasReadingDetails(reading, reportMeter, photoMode)) ...[
                ..._readingSection(
                  reading: reading,
                  number: readings.length - index,
                  date: date,
                  photoMode: photoMode,
                  photoAssets: photoAssets,
                  currentMeter: reportMeter,
                ),
              ],
          ],
        ],
      ),
    );

    final bytes = await document.save();
    final pdfSha = await const IntegrityService().sha256Bytes(bytes);
    return <String, Object?>{
      'bytes': bytes,
      'manifestSha256': manifestSha,
      'pdfSha256': pdfSha,
    };
  }

  static Future<String> _reportManifestHash(
    List<MeterReading> readings,
    Map<String, List<ReadingRevision>> revisions,
    MeterSnapshot reportMeter,
  ) async {
    const integrity = IntegrityService();
    final normalizedReadings = readings.map((reading) {
      return integrity.normalizedReadingData(reading);
    }).toList();
    final normalizedRevisions = <String, Object?>{
      for (final reading in readings)
        reading.id: (revisions[reading.id] ?? const [])
            .map((revision) => revision.toJson())
            .toList(),
    };
    return integrity.sha256Text(
      integrity.canonicalJson({
        'schema': 'meter_reading_evidence_v3',
        'reportMeter': reportMeter.toJson(),
        'readings': normalizedReadings,
        'revisions': normalizedRevisions,
      }),
    );
  }

  static List<pw.Widget> _bookSection(
    MeterSnapshot meter,
    EvidenceExportKind kind,
  ) => [
    pw.NewPage(freeSpace: 80),
    pw.Text(
      kind == EvidenceExportKind.meterHistory
          ? 'Aktuelle Projektangaben'
          : 'Projektangaben bei Erfassung',
      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
    ),
    pw.SizedBox(height: 6),
    _dataTable([
      ['Technik', meter.type.label],
      ['Projektname', meter.label],
      if (meter.meterNumber.trim().isNotEmpty) ['Garn', meter.meterNumber],
      if (meter.location.trim().isNotEmpty) ['Nadelstärke', meter.location],
      ['Zählweise', meter.unit],
    ]),
  ];

  static pw.Widget _dataTable(List<List<String>> rows) =>
      pw.TableHelper.fromTextArray(
        headerStyle: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        cellStyle: const pw.TextStyle(fontSize: 12),
        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
        headerAlignment: pw.Alignment.centerLeft,
        cellAlignment: pw.Alignment.centerLeft,
        border: pw.TableBorder.all(color: PdfColors.grey700, width: .5),
        columnWidths: const {0: pw.FlexColumnWidth(), 1: pw.FlexColumnWidth()},
        cellPadding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        data: rows,
      );

  static pw.Widget _historyTable(List<MeterReading> readings, DateFormat date) {
    final rows = historyTableData(readings, date);
    return pw.TableHelper.fromTextArray(
      headers: const ['Nr.', 'Zeitpunkt', 'Projektstand', 'Fortschritt'],
      headerStyle: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
      cellStyle: const pw.TextStyle(fontSize: 12),
      headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('#E4EBDF')),
      headerAlignment: pw.Alignment.centerLeft,
      cellAlignment: pw.Alignment.centerLeft,
      border: pw.TableBorder.all(color: PdfColors.grey700, width: 0.5),
      columnWidths: const {
        0: pw.FixedColumnWidth(30),
        1: pw.FlexColumnWidth(1.35),
        2: pw.FlexColumnWidth(.75),
        3: pw.FlexColumnWidth(1.9),
      },
      cellPadding: const pw.EdgeInsets.all(6),
      // Only presentation differs from ZählerLog: reuse its table values and
      // calculation, then render Strick & Häkelbuch's page-to-page progress wording.
      data: [
        for (var index = 0; index < readings.length; index++)
          [
            // The oldest reading is 1 even though the newest is shown first.
            '${readings.length - index}',
            rows[index][0],
            progressValueLabel(
              readings[index].value.displayText,
              readings[index].meter.unit,
            ),
            index < readings.length - 1 &&
                    readings[index].meter.unit == readings[index + 1].meter.unit
                ? _historyProgress(
                    readings[index],
                    readings[index + 1],
                    rows[index][2],
                  )
                : rows[index][2],
          ],
      ],
    );
  }

  static pw.Widget _historyProgress(
    MeterReading reading,
    MeterReading previous,
    String progress,
  ) {
    final pagePrefix = '${progressUnitSingular(reading.meter.unit)} ';
    return pw.RichText(
      text: pw.TextSpan(
        style: const pw.TextStyle(fontSize: 12),
        children: [
          pw.TextSpan(text: '$pagePrefix${previous.value.displayText} '),
          // The bundled Roboto font has no arrow glyph.
          pw.WidgetSpan(
            baseline: 2,
            child: pw.SvgImage(
              svg:
                  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 12 8"><path d="M0 3h8V0l4 4-4 4V5H0z" fill="#000000"/></svg>',
              width: 12,
              height: 8,
            ),
          ),
          pw.TextSpan(
            text: ' ${reading.value.displayText} = $progress Fortschritt',
          ),
        ],
      ),
    );
  }

  @visibleForTesting
  static List<List<String>> historyTableData(
    List<MeterReading> readings,
    DateFormat date,
  ) => [
    for (var index = 0; index < readings.length; index++)
      [
        readingTimeText(readings[index], date),
        '${readings[index].value.displayText} ${readings[index].meter.unit}',
        index == readings.length - 1
            ? '–'
            : readings[index].meter.unit != readings[index + 1].meter.unit
            ? '– (Einheit gewechselt)'
            : '${readings[index].value.difference(readings[index + 1].value).germanFormatted} ${readings[index].meter.unit}',
      ],
  ];

  @visibleForTesting
  static String readingTimeText(MeterReading reading, DateFormat date) {
    // The saved offset belongs to this reading, not to the exporting device.
    final localAtCapture = reading.capturedAt.toUtc().add(
      Duration(minutes: reading.timezoneOffsetMinutes),
    );
    return '${date.format(localAtCapture)} (${_offset(reading.timezoneOffsetMinutes)})';
  }

  @visibleForTesting
  static List<List<String>> historicalMeterData(
    MeterSnapshot original,
    MeterSnapshot current,
  ) => [
    for (final field in [
      ('Technik', original.type.label, current.type.label),
      ('Projektname', original.label, current.label),
      ('Garn', original.meterNumber, current.meterNumber),
      ('Nadelstärke', original.location, current.location),
      ('Zählweise', original.unit, current.unit),
    ])
      if (field.$2 != field.$3)
        [field.$1, field.$2.isEmpty ? 'Nicht angegeben' : field.$2],
  ];

  static bool _hasReadingDetails(
    MeterReading reading,
    MeterSnapshot currentMeter,
    EvidencePhotoMode photoMode,
  ) =>
      reading.note.trim().isNotEmpty ||
      reading.lowerReadingReason != null ||
      historicalMeterData(reading.meter, currentMeter).isNotEmpty ||
      (photoMode != EvidencePhotoMode.withoutPhotos && reading.hasPhoto) ||
      (photoMode == EvidencePhotoMode.allPhotos &&
          reading.photoHistory.isNotEmpty);

  static List<pw.Widget> _readingSection({
    required MeterReading reading,
    required int number,
    required DateFormat date,
    required EvidencePhotoMode photoMode,
    required _PdfPhotoAssets photoAssets,
    MeterSnapshot? currentMeter,
  }) {
    final historicalData = currentMeter == null
        ? const <List<String>>[]
        : historicalMeterData(reading.meter, currentMeter);
    final showPhoto =
        reading.hasPhoto && photoMode != EvidencePhotoMode.withoutPhotos;
    return [
      pw.NewPage(freeSpace: 100),
      _keepTogether([
        if (currentMeter != null) pw.SizedBox(height: 18),
        pw.Text(
          'Projektstand $number',
          style: pw.TextStyle(
            fontSize: 17,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#526B59'),
          ),
        ),
        pw.SizedBox(height: 8),
        // Keep the heading, confirmed value and time with the first photo row.
        _dataTable([
          [
            currentProgressLabel(reading.meter.unit),
            '${reading.value.displayText} ${reading.meter.unit}',
          ],
          ['Zeitpunkt des Projektstands', readingTimeText(reading, date)],
        ]),
        if (showPhoto) ...[
          pw.SizedBox(height: 10),
          _photoRow(reading, 0, photoAssets),
        ],
      ]),
      if (showPhoto)
        for (var index = 2; index < reading.currentPhotos.length; index += 2)
          _keepTogether([
            pw.SizedBox(height: 12),
            pw.Text(
              'Projektstand $number · ${progressValueLabel(reading.value.displayText, reading.meter.unit)} · ${readingTimeText(reading, date)}',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.SizedBox(height: 6),
            _photoRow(reading, index, photoAssets),
          ]),
      if (historicalData.isNotEmpty) ...[
        pw.NewPage(freeSpace: 80),
        pw.SizedBox(height: 10),
        pw.Text(
          'Projektangaben bei Erfassung',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        _dataTable(historicalData),
      ],
      if (reading.lowerReadingReason case final reason?) ...[
        pw.SizedBox(height: 8),
        _flowingText('Niedrigerer Stand: ${reason.label}'),
      ],
      if (reading.note.trim().isNotEmpty) ...[
        pw.NewPage(freeSpace: 45),
        pw.SizedBox(height: 10),
        pw.Text(
          'Notiz',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        // Keep free text as a direct MultiPage child so long notes can span.
        _flowingText(reading.note),
      ],
      if (photoMode == EvidencePhotoMode.allPhotos)
        for (var index = 0; index < reading.photoHistory.length; index++)
          _keepTogether([
            pw.SizedBox(height: 12),
            pw.Text(
              'Früheres Foto ${index + 1}',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),
            _photo(reading.photoHistory[index].path, photoAssets),
          ]),
    ];
  }

  static pw.Widget _photoRow(
    MeterReading reading,
    int start,
    _PdfPhotoAssets photoAssets,
  ) => pw.LayoutBuilder(
    builder: (context, constraints) {
      const gap = 12.0;
      final width = (constraints!.maxWidth - gap) / 2;
      final photos = reading.currentPhotos;
      return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          for (
            var index = start;
            index < photos.length && index < start + 2;
            index++
          ) ...[
            if (index > start) pw.SizedBox(width: gap),
            pw.SizedBox(
              width: width,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Text(
                    'Foto ${index + 1} von ${photos.length}',
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  _photo(photos[index].path, photoAssets, height: 170),
                ],
              ),
            ),
          ],
        ],
      );
    },
  );

  static pw.Widget _keepTogether(List<pw.Widget> children) => pw.Inseparable(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: children,
    ),
  );

  static pw.Widget _flowingText(
    String text, {
    double fontSize = 12,
    bool bold = false,
  }) => pw.Text(
    text,
    style: pw.TextStyle(
      fontSize: fontSize,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
    ),
    overflow: pw.TextOverflow.span,
  );

  static pw.Widget _photo(
    String path,
    _PdfPhotoAssets photoAssets, {
    double height = 280,
  }) {
    try {
      return pw.Container(
        width: double.infinity,
        height: height,
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey400, width: .5),
        ),
        child: pw.Image(photoAssets.image(path), fit: pw.BoxFit.contain),
      );
    } on Object {
      return pw.Container(
        height: height,
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 12),
        child: pw.Text(
          'Projektstandfoto konnte nicht eingebettet werden.',
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
      );
    }
  }

  Future<_ReportFontBytes> _loadFontBytes() async {
    final regular = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final bold = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    return _ReportFontBytes(
      regular: regular.buffer.asUint8List(
        regular.offsetInBytes,
        regular.lengthInBytes,
      ),
      bold: bold.buffer.asUint8List(bold.offsetInBytes, bold.lengthInBytes),
    );
  }

  String _safeFilePart(String value) {
    final normalized = value
        .toLowerCase()
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue')
        .replaceAll('ß', 'ss')
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
    return normalized.isEmpty ? 'projekt' : normalized;
  }

  static String _offset(int minutes) {
    final sign = minutes < 0 ? '-' : '+';
    final absolute = minutes.abs();
    return 'UTC$sign${(absolute ~/ 60).toString().padLeft(2, '0')}:'
        '${(absolute % 60).toString().padLeft(2, '0')}';
  }
}

class _ReportFonts {
  const _ReportFonts({required this.regular, required this.bold});

  final pw.Font regular;
  final pw.Font bold;
}

class _ReportFontBytes {
  const _ReportFontBytes({required this.regular, required this.bold});

  final Uint8List regular;
  final Uint8List bold;
}

class _PdfPhotoAssets {
  _PdfPhotoAssets(this.preparedPaths);

  final Map<String, String> preparedPaths;
  final Map<String, pw.MemoryImage> _images = {};

  pw.MemoryImage image(String originalPath) {
    return _images.putIfAbsent(originalPath, () {
      final preparedPath = preparedPaths[originalPath];
      if (preparedPath == null) {
        throw StateError('Keine vorbereitete Fotodatei vorhanden.');
      }
      return pw.MemoryImage(File(preparedPath).readAsBytesSync());
    });
  }
}
