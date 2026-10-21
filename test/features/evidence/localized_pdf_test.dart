import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:strick_haekelbuch/core/integrity/integrity_service.dart';
import 'package:strick_haekelbuch/features/evidence/application/evidence_report_service.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/domain/reading_value.dart';
import '../../support/fakes.dart';
import '../../support/reading_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final choice in appLanguageNames.keys) {
    test(
      'PDF uses $choice with German region and unchanged source data',
      () async {
        final originalLocale = AppLocale.current;
        addTearDown(() => AppLocale.install(originalLocale));
        final directory = await Directory.systemTemp.createTemp(
          'sh-localized-pdf-',
        );
        addTearDown(() => directory.delete(recursive: true));
        final locale = AppLocaleData(
          choice: choice,
          deviceLocales: const [Locale('de', 'DE')],
          use24HourClock: true,
        );
        AppLocale.install(locale);
        final reading = sampleReading(source: ReadingSource.manual).copyWith(
          note: 'Eigene Notiz bleibt unverändert – café',
          value: const ReadingValue(
            displayText: '1234,500',
            digits: '1234500',
            scale: 3,
          ),
        );
        final before = reading.toJson();
        final service = EvidenceReportService(
          exports: MemoryEvidenceExportRepository(),
          documentsDirectoryProvider: () async => directory,
        );
        final report = await service.createSingle(
          reading: reading,
          revisions: const [],
        );
        expect(reading.toJson(), before);
        expect(
          report.record.fileName,
          startsWith(locale.strings.reportFilePrefix),
        );
        if (const bool.fromEnvironment('PDF_TEXT_AUDIT')) {
          final process = await Process.run('pdftotext', [
            '-layout',
            report.record.filePath,
            '-',
          ]);
          expect(process.exitCode, 0);
          final text = (process.stdout as String).replaceAll(
            RegExp(r'\s+'),
            ' ',
          );
          expect(text, contains(locale.strings.projectReport));
          expect(text, contains('1.234,500'));
          expect(text, contains(reading.note));
          expect(text, contains('14.09.2026'));
          if (choice != 'de') {
            expect(text, isNot(contains('Projektangaben')));
            expect(text, isNot(contains('Zeitpunkt des Projektstands')));
          }
        }
        final hash = await const IntegrityService().sha256Bytes(
          await File(report.record.filePath).readAsBytes(),
        );
        AppLocale.install(locale.withChoice(choice == 'en' ? 'fr' : 'en'));
        await service.createSingle(reading: reading, revisions: const []);
        expect(
          await const IntegrityService().sha256Bytes(
            await File(report.record.filePath).readAsBytes(),
          ),
          hash,
        );
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );
  }
}
