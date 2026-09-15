import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:strick_haekelbuch/app/app_providers.dart';
import 'package:strick_haekelbuch/app/app_theme.dart';
import 'package:strick_haekelbuch/core/files/evidence_photo_asset_repository.dart';
import 'package:strick_haekelbuch/core/files/meter_photo_repository.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter_reading.dart';
import 'package:strick_haekelbuch/features/meters/presentation/capture_reading_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/edit_reading_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/home_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/meter_detail_screen.dart';
import 'package:strick_haekelbuch/features/meters/presentation/meter_form_screen.dart';

import '../../support/fakes.dart';
import '../../support/reading_fixtures.dart';

void main() {
  for (final scale in [1.0, 1.5, 2.0]) {
    testWidgets(
      'book, capture and editing actions fit a narrow phone at $scale',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(320, 800);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final book = sampleBook();
        final reading = sampleReading(source: ReadingSource.manual);
        final router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (_, _) => const HomeScreen(),
            ),
            GoRoute(
              path: '/book/:id',
              name: 'meterDetail',
              builder: (_, _) => MeterDetailScreen(meterId: book.id),
            ),
            GoRoute(
              path: '/capture/:id',
              name: 'captureReading',
              builder: (_, _) => CaptureReadingScreen(meterId: book.id),
            ),
            GoRoute(
              path: '/book/edit/:id',
              name: 'meterEdit',
              builder: (_, _) => MeterFormScreen(meterId: book.id),
            ),
            GoRoute(
              path: '/edit/:id',
              name: 'readingEdit',
              builder: (_, _) => EditReadingScreen(readingId: reading.id),
            ),
          ],
        );
        addTearDown(router.dispose);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              meterRepositoryProvider.overrideWithValue(
                MemoryMeterRepository()..items[book.id] = book,
              ),
              meterReadingRepositoryProvider.overrideWithValue(
                MemoryReadingRepository()..items[reading.id] = reading,
              ),
              evidenceExportRepositoryProvider.overrideWithValue(
                MemoryEvidenceExportRepository(),
              ),
              meterReminderRepositoryProvider.overrideWithValue(
                NoopMeterReminderRepository(),
              ),
              evidencePhotoAssetRepositoryProvider.overrideWithValue(
                const NoopEvidencePhotoAssetRepository(),
              ),
              meterPhotoCaptureRepositoryProvider.overrideWithValue(
                const UnsupportedMeterPhotoCaptureRepository(),
              ),
            ],
            child: MaterialApp.router(
              theme: AppTheme.light(),
              routerConfig: router,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(scale)),
                child: child!,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        router.goNamed('meterDetail', pathParameters: {'id': book.id});
        await tester.pumpAndSettle();
        await _checkAction(tester, 'Projekt & Erinnerung bearbeiten');
        await _checkAction(tester, 'Projekt löschen');
        await _checkAction(
          tester,
          'Projektprotokoll für den Projektverlauf erstellen',
        );
        // Reach the editor through the edge of the real book action.
        await _checkAction(
          tester,
          'Projekt & Erinnerung bearbeiten',
          tap: true,
        );
        expect(find.text('Projekt bearbeiten'), findsOneWidget);
        expect(tester.takeException(), isNull);
        router.goNamed('captureReading', pathParameters: {'id': book.id});
        await tester.pumpAndSettle();
        await _checkAction(tester, 'Projekt fotografieren');
        await _checkAction(tester, 'Foto aus Galerie');
        await _checkAction(tester, 'Stand eintragen', tap: true);
        expect(find.text('Aktuelle Reihe *'), findsOneWidget);
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpAndSettle();
        await _checkAction(tester, 'Datum & Uhrzeit ändern');
        await _checkAction(tester, 'Projektstand speichern');
        router.goNamed('readingEdit', pathParameters: {'id': reading.id});
        await tester.pumpAndSettle();
        await _checkAction(tester, 'Foto ergänzen');
        await _checkAction(tester, 'Datum & Uhrzeit ändern');
        await _checkAction(tester, 'Korrektur protokollieren');
        expect(tester.takeException(), isNull);
      },
    );
  }
}

Future<void> _checkAction(
  WidgetTester tester,
  String label, {
  bool tap = false,
}) async {
  final button = find.ancestor(
    of: find.text(label),
    matching: find.byWidgetPredicate((w) => w is ButtonStyleButton),
  );
  await tester.scrollUntilVisible(
    button,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
  final rect = tester.getRect(button);
  final text = tester.getRect(find.text(label));
  expect(rect.height, greaterThanOrEqualTo(56 - .001), reason: label);
  expect(rect.left, greaterThanOrEqualTo(0), reason: label);
  expect(rect.right, lessThanOrEqualTo(320), reason: label);
  expect(rect.contains(text.topLeft), isTrue, reason: label);
  expect(rect.contains(text.bottomRight), isTrue, reason: label);
  expect(tester.takeException(), isNull);
  if (tap) {
    await tester.tapAt(Offset(rect.center.dx, rect.bottom - 2));
    await tester.pumpAndSettle();
  }
}
