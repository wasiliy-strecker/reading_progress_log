import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:strick_haekelbuch/core/files/evidence_photo_asset_repository.dart';
import 'package:strick_haekelbuch/features/evidence/application/evidence_report_service.dart';
import 'package:strick_haekelbuch/features/evidence/domain/evidence_export.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';

import '../../support/fakes.dart';
import '../../support/reading_fixtures.dart';

const _audit = bool.fromEnvironment('PDF_TEXT_AUDIT');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final portrait in [true, false]) {
    test(
      'single report has readable tables and a centered photo, portrait=$portrait',
      () async {
        final temp = await Directory.systemTemp.createTemp('table_layout_');
        addTearDown(() => temp.delete(recursive: true));
        final photo = await _photo(
          temp,
          'page',
          portrait ? 300 : 640,
          portrait ? 600 : 420,
          'SEITE 150',
        );
        final book = sampleBook(label: 'Ein Projekt zum Lesen').copyWith(
          meterNumber: '978-3-1234-5678-9',
          location: 'Erika Beispiel',
        );
        final reading =
            sampleReading(book: book, path: photo.path, value: '150').copyWith(
              capturedAt: DateTime.utc(2100, 1, 1, 12),
              note: 'Ein weiterer Abschnitt ist geschafft.',
            );
        final report =
            await EvidenceReportService(
              exports: MemoryEvidenceExportRepository(),
              documentsDirectoryProvider: () async => temp,
              photoAssets: _Assets(),
            ).createSingle(
              reading: reading,
              revisions: const [],
              photoMode: EvidencePhotoMode.currentPhotos,
            );
        if (_audit) {
          final pages = await _auditPages(
            report,
            'strick_haekelbuch-table-${portrait ? 'portrait' : 'landscape'}',
          );
          expect(pages, hasLength(1));
          final text = pages.single;
          for (final field in [
            'Technik',
            'Projektname',
            'Garn',
            'Nadelstärke',
            'Zählweise',
            'Aktuelle Reihe',
            'Zeitpunkt des Projektstands',
            '150 Reihen',
            '01.01.2100, 14:00 (UTC+02:00)',
            reading.note,
          ]) {
            expect(text, contains(field));
          }
          expect(text, isNot(contains('Zukunft')));
          expect(text, isNot(contains('zukünftig')));
          // Poppler reports positions and text sizes in PDF points at zoom 1.
          final result = await Process.run('pdftohtml', [
            '-xml',
            '-zoom',
            '1',
            '-hidden',
            '-stdout',
            report.record.filePath,
          ], workingDirectory: temp.path);
          expect(result.exitCode, 0, reason: '${result.stderr}');
          final xml = result.stdout as String;
          final page = _attributes(
            RegExp(r'<page\s+([^>]+)>').firstMatch(xml)!.group(1)!,
          );
          final image = _attributes(
            RegExp(r'<image\s+([^>]+)>').firstMatch(xml)!.group(1)!,
          );
          for (final field in [
            'Projektstand 1',
            'Aktuelle Reihe',
            'Zeitpunkt des Projektstands',
          ]) {
            final node = RegExp(r'<text\s+([^>]+)>(.*?)</text>', dotAll: true)
                .allMatches(xml)
                .firstWhere(
                  (match) => match
                      .group(2)!
                      .replaceAll(RegExp(r'<[^>]+>'), '')
                      .contains(field),
                );
            final attributes = _attributes(node.group(1)!);
            expect(
              double.parse(attributes['top']!) +
                  double.parse(attributes['height']!),
              lessThan(double.parse(image['top']!)),
              reason: '$field must precede the first photo',
            );
          }
          final width = double.parse(image['width']!);
          final height = double.parse(image['height']!);
          expect(
            double.parse(image['left']!) + width / 2,
            closeTo(double.parse(page['width']!) / 2, 1),
          );
          expect(height, closeTo(280, 1));
          expect(
            width / height,
            closeTo(portrait ? 300 / 600 : 640 / 420, .01),
          );
          final fonts = {
            for (final match in RegExp(r'<fontspec\s+([^>]+)>').allMatches(xml))
              _attributes(match.group(1)!)['id']: _attributes(
                match.group(1)!,
              )['size'],
          };
          for (final field in [
            'Technik',
            'Projektname',
            'Aktuelle Reihe',
            'Zeitpunkt des Projektstands',
            reading.note,
          ]) {
            final node = RegExp(r'<text\s+([^>]+)>(.*?)</text>', dotAll: true)
                .allMatches(xml)
                .firstWhere(
                  (match) => match
                      .group(2)!
                      .replaceAll(RegExp(r'<[^>]+>'), '')
                      .contains(field),
                );
            expect(
              fonts[_attributes(node.group(1)!)['font']],
              '12',
              reason: field,
            );
          }
        }
      },
    );
  }

  test('future compact history has no warning-only detail section', () async {
    final temp = await Directory.systemTemp.createTemp(
      'future_history_layout_',
    );
    addTearDown(() => temp.delete(recursive: true));
    final reading = sampleReading(
      source: ReadingSource.manual,
    ).copyWith(capturedAt: DateTime.utc(2100, 1, 1, 12));
    final report =
        await EvidenceReportService(
          exports: MemoryEvidenceExportRepository(),
          documentsDirectoryProvider: () async => temp,
        ).createHistory(
          meter: sampleBook(),
          readings: [reading],
          revisions: const {},
          photoMode: EvidencePhotoMode.withoutPhotos,
        );
    if (_audit) {
      final pages = await _auditPages(
        report,
        'strick_haekelbuch-table-future-compact',
      );
      expect(pages, hasLength(1));
      expect('01.01.2100'.allMatches(pages.single), hasLength(1));
      expect(pages.single, isNot(contains('Zukunft')));
      expect(pages.single, isNot(contains('zukünftig')));
      expect(pages.single, isNot(contains('Zeitpunkt des Projektstands')));
      expect(pages.single, isNot(contains('Aktuelles Projektstandfoto')));
    }
  });

  test('short compact history needs only its overview and one page', () async {
    final temp = await Directory.systemTemp.createTemp('compact_layout_');
    addTearDown(() => temp.delete(recursive: true));
    final latest = sampleReading(source: ReadingSource.manual, value: '85');
    final older = sampleReading(
      id: 'older',
      value: '87',
    ).copyWith(capturedAt: latest.capturedAt.subtract(const Duration(days: 1)));
    final report =
        await EvidenceReportService(
          exports: MemoryEvidenceExportRepository(),
          documentsDirectoryProvider: () async => temp,
        ).createHistory(
          meter: sampleBook(),
          readings: [older, latest],
          revisions: const {},
          photoMode: EvidencePhotoMode.withoutPhotos,
        );
    if (_audit) {
      final pages = await _auditPages(
        report,
        'strick_haekelbuch-compact-overview',
      );
      expect(pages, hasLength(1));
      expect(pages.single, contains('= -2 Reihen Fortschritt'));
      expect(pages.single, isNot(contains('Nicht angegeben')));
      expect(pages.single, isNot(contains('Garn')));
      expect('14.09.2026'.allMatches(pages.single), hasLength(1));
      expect('13.09.2026'.allMatches(pages.single), hasLength(1));
    }
  });

  for (final mode in EvidencePhotoMode.values) {
    test('mixed layout keeps photo titles with images in $mode', () async {
      final temp = await Directory.systemTemp.createTemp('photo_layout_');
      addTearDown(() => temp.delete(recursive: true));
      final portrait = await _photo(temp, 'portrait', 300, 600, 'SEITE 150');
      final landscape = await _photo(temp, 'landscape', 640, 420, 'SEITE 85');
      final archive = await _photo(temp, 'archive', 420, 300, 'FRUEHERES FOTO');
      final newest = sampleReading(
        path: portrait.path,
        value: '150',
      ).copyWith(note: 'Ein Kapitel zum Tagesabschluss.');
      final manual =
          sampleReading(
            id: 'manual',
            source: ReadingSource.manual,
            value: '130',
          ).copyWith(
            capturedAt: newest.capturedAt.subtract(const Duration(days: 1)),
            note:
                'NOTIZANFANG ${List.filled(90, 'Ein weiterer Leseabschnitt.').join(' ')} NOTIZENDE',
          );
      final oldest =
          sampleReading(
            id: 'oldest',
            path: landscape.path,
            hash: 'b' * 64,
            value: '85',
          ).copyWith(
            capturedAt: newest.capturedAt.subtract(const Duration(days: 2)),
            photoHistory: [
              ReadingPhotoVersion(
                id: 'archive',
                path: archive.path,
                sha256: 'c' * 64,
                source: ReadingSource.gallery,
                addedAt: DateTime.utc(2026, 9, 1),
                ocrRawText: 'OLD_OCR',
                ocrCandidate: 'OLD_CANDIDATE',
              ),
            ],
          );
      final assets = _Assets();
      final report =
          await EvidenceReportService(
            exports: MemoryEvidenceExportRepository(),
            documentsDirectoryProvider: () async => temp,
            photoAssets: assets,
          ).createHistory(
            meter: sampleBook(),
            readings: [oldest, manual, newest],
            revisions: const {},
            photoMode: mode,
          );
      expect(
        assets.prepared,
        unorderedEquals([
          if (mode != EvidencePhotoMode.withoutPhotos) ...[
            portrait.path,
            landscape.path,
          ],
        ]),
      );
      if (_audit) {
        final pages = await _auditPages(
          report,
          'strick_haekelbuch-layout-${mode.name}',
        );
        final text = pages.join(' ');
        expect(text, contains('NOTIZANFANG'));
        expect(text, contains('NOTIZENDE'));
        for (final word in ['weiterer', 'Leseabschnitt.']) {
          expect(word.allMatches(text), hasLength(90));
        }
        expect(text, isNot(contains('OLD_OCR')));
        expect(text, isNot(contains('OLD_CANDIDATE')));
        expect(text.contains('Früheres Foto 1'), false);
        final result = await Process.run('pdfimages', [
          '-list',
          report.record.filePath,
        ]);
        expect(result.exitCode, 0);
        final images = (result.stdout as String)
            .split('\n')
            .map((line) => line.trim().split(RegExp(r'\s+')))
            .where((row) => row.length > 5 && row[2] == 'image')
            .toList();
        expect(
          images,
          hasLength(mode == EvidencePhotoMode.withoutPhotos ? 0 : 2),
        );
        for (final row in images) {
          final page = pages[int.parse(row[0]) - 1];
          final title = switch (row[3]) {
            '300' => 'Projektstand 1',
            '640' => 'Projektstand 3',
            '420' => 'Früheres Foto 1',
            _ => throw StateError('Unexpected image dimensions: $row'),
          };
          expect(
            page,
            contains(title),
            reason: 'Photo and title must share a page',
          );
        }
      }
    });
  }
}

Future<List<String>> _auditPages(
  GeneratedEvidenceReport report,
  String name,
) async {
  final directory = await Directory(
    'build/verification',
  ).create(recursive: true);
  await File(report.record.filePath).copy('${directory.path}/$name.pdf');
  final result = await Process.run('pdftotext', [
    '-layout',
    report.record.filePath,
    '-',
  ]);
  expect(result.exitCode, 0);
  final pages = (result.stdout as String)
      .split('\f')
      .where((page) => page.trim().isNotEmpty)
      .map((page) => page.replaceAll(RegExp(r'\s+'), ' '))
      .toList();
  for (final page in pages) {
    expect(page, isNot(contains('Dokumentinformationen')));
    expect(page, isNot(contains('Korrekturverlauf')));
    expect(page, isNot(contains('konnte nicht eingebettet werden')));
    expect(page, isNot(contains('Galerieimport')));
    expect(page, isNot(contains('Kameraaufnahme')));
    expect(page, isNot(contains('Manuell erfasst')));
  }
  return pages;
}

Future<File> _photo(
  Directory directory,
  String name,
  int width,
  int height,
  String label,
) async {
  final image = img.Image(width: width, height: height);
  img.fill(image, color: img.ColorRgb8(246, 239, 225));
  img.drawString(
    image,
    label,
    font: img.arial24,
    x: 18,
    y: 24,
    color: img.ColorRgb8(70, 45, 45),
  );
  for (var y = 90; y < height - 35; y += 24) {
    img.drawLine(
      image,
      x1: 18,
      y1: y,
      x2: width - 18,
      y2: y,
      color: img.ColorRgb8(180, 170, 160),
    );
  }
  return File('${directory.path}/$name.jpg')
    ..writeAsBytesSync(img.encodeJpg(image));
}

class _Assets extends NoopEvidencePhotoAssetRepository {
  final prepared = <String>[];
  @override
  Future<String?> prepare({
    required String path,
    required String sha256,
  }) async {
    prepared.add(path);
    return path;
  }
}

Map<String, String> _attributes(String tag) => {
  for (final match in RegExp(r'(\w+)="([^"]*)"').allMatches(tag))
    match.group(1)!: match.group(2)!,
};
