import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:strick_haekelbuch/app/app_theme.dart';
import 'package:strick_haekelbuch/features/meters/presentation/project_photo_examples.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'four distinct project photos are bundled and decodable offline',
    () async {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final bundledExamples = manifest.listAssets().where(
        (asset) => asset.startsWith('assets/examples/project_photos/'),
      );
      expect(projectPhotoExamples, hasLength(4));
      expect(
        bundledExamples,
        unorderedEquals(projectPhotoExamples.map((example) => example.asset)),
      );
      final uniqueImages = <String>{};
      for (final example in projectPhotoExamples) {
        final bytes = File(example.asset).readAsBytesSync();
        final decoded = img.decodePng(bytes)!;
        expect(decoded.width, greaterThanOrEqualTo(768));
        expect(decoded.height, greaterThanOrEqualTo(768));
        uniqueImages.add(base64Encode(bytes));
        final bundled = await rootBundle.load(example.asset);
        expect(
          bundled.buffer.asUint8List(
            bundled.offsetInBytes,
            bundled.lengthInBytes,
          ),
          bytes,
        );
      }
      expect(uniqueImages, hasLength(4));
    },
  );

  Future<_ExampleAssetBundle> pumpButton(
    WidgetTester tester, {
    bool enabled = true,
    double textScale = 1,
    bool dark = false,
    bool failImages = false,
  }) async {
    final bundle = _ExampleAssetBundle(failImages: failImages);
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: bundle,
        child: MaterialApp(
          theme: dark ? AppTheme.dark() : AppTheme.light(),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          home: Scaffold(body: ProjectPhotoExamplesButton(enabled: enabled)),
        ),
      ),
    );
    return bundle;
  }

  testWidgets('visible by default without loading example images early', (
    tester,
  ) async {
    final bundle = await pumpButton(tester);

    expect(find.text('Beispiele ansehen'), findsOneWidget);
    expect(bundle.loadedImages, isEmpty);
  });

  testWidgets('busy photo processing disables the link', (tester) async {
    final bundle = await pumpButton(tester, enabled: false);
    await tester.tap(find.text('Beispiele ansehen'));
    await tester.pumpAndSettle();

    expect(find.text('Beispielfotos'), findsNothing);
    expect(bundle.loadedImages, isEmpty);
  });

  testWidgets('opens only on demand, supports swiping and arrows, and closes', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final bundle = await pumpButton(tester);
    expect(bundle.loadedImages, isEmpty);
    expect(find.text('Beispielfotos'), findsNothing);

    await tester.tap(find.text('Beispiele ansehen'));
    await tester.pumpAndSettle();
    expect(find.text('Beispielfotos'), findsOneWidget);
    expect(find.text('Stricken · Schal'), findsOneWidget);
    expect(find.text('1 von 4'), findsOneWidget);
    expect(find.text(projectPhotoExamples.first.tip), findsOneWidget);
    expect(
      find.textContaining('Reihe oder Runde trägst du selbst ein'),
      findsOneWidget,
    );
    expect(bundle.loadedImages, contains(projectPhotoExamples.first.asset));
    expect(
      tester
          .widget<IconButton>(
            find.byWidgetPredicate(
              (widget) =>
                  widget is IconButton &&
                  widget.tooltip == 'Vorheriges Beispiel',
            ),
          )
          .onPressed,
      isNull,
    );

    await tester.drag(find.byType(PageView), const Offset(-350, 0));
    await tester.pumpAndSettle();
    expect(find.text('Stricken · Mütze in Runden'), findsOneWidget);
    expect(find.text('2 von 4'), findsOneWidget);
    await tester.tap(find.byTooltip('Nächstes Beispiel'));
    await tester.pumpAndSettle();
    expect(find.text('Häkeln · Granny Square'), findsOneWidget);
    await tester.tap(find.byTooltip('Nächstes Beispiel'));
    await tester.pumpAndSettle();
    expect(find.text('Häkeln · Körbchen in Runden'), findsOneWidget);
    expect(find.text('4 von 4'), findsOneWidget);
    expect(
      tester
          .widget<IconButton>(
            find.byWidgetPredicate(
              (widget) =>
                  widget is IconButton && widget.tooltip == 'Nächstes Beispiel',
            ),
          )
          .onPressed,
      isNull,
    );
    await tester.tap(find.byTooltip('Vorheriges Beispiel'));
    await tester.pumpAndSettle();
    expect(find.text('3 von 4'), findsOneWidget);

    await tester.tap(find.byTooltip('Schließen'));
    await tester.pumpAndSettle();
    expect(find.text('Beispielfotos'), findsNothing);
    await tester.tap(find.text('Beispiele ansehen'));
    await tester.pumpAndSettle();
    expect(find.text('1 von 4'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Beispielfotos'), findsNothing);
    expect(find.text('Beispiele ansehen'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'stays scrollable with large text in a small landscape viewport',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(640, 360));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await pumpButton(tester, textScale: 2, dark: true);

      await tester.tap(find.text('Beispiele ansehen'));
      await tester.pumpAndSettle();
      expect(find.text('Beispielfotos'), findsOneWidget);
      await tester.ensureVisible(find.byTooltip('Nächstes Beispiel'));
      await tester.tap(find.byTooltip('Nächstes Beispiel'));
      await tester.pumpAndSettle();
      expect(find.text('2 von 4'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
    },
  );

  testWidgets('a missing example does not block closing or the photo flow', (
    tester,
  ) async {
    await pumpButton(tester, failImages: true);
    await tester.tap(find.text('Beispiele ansehen'));
    await tester.pumpAndSettle();

    expect(find.text('Beispiel konnte nicht geladen werden.'), findsOneWidget);
    await tester.tap(find.byTooltip('Schließen'));
    await tester.pumpAndSettle();
    expect(find.text('Beispiele ansehen'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _ExampleAssetBundle extends CachingAssetBundle {
  _ExampleAssetBundle({this.failImages = false});

  final bool failImages;
  final loadedImages = <String>[];

  @override
  Future<ByteData> load(String key) async {
    if (!key.contains('examples/project_photos/')) return rootBundle.load(key);
    loadedImages.add(key);
    if (failImages) throw FlutterError('Synthetic missing image');
    // The gallery interaction tests use a tiny synthetic image; the asset test
    // above verifies the actual bundled project photos.
    return ByteData.sublistView(
      base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=',
      ),
    );
  }
}
