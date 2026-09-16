import 'package:flutter/material.dart';

const projectPhotoExamples = [
  (
    label: 'Stricken · Schal',
    asset: 'assets/examples/project_photos/01_stricken_schal.png',
    tip:
        'Lege dein Projekt flach hin, damit Form und Muster gut sichtbar sind.',
  ),
  (
    label: 'Stricken · Mütze in Runden',
    asset: 'assets/examples/project_photos/02_stricken_muetze.png',
    tip: 'Zeige auch die aktive Nadel und den markierten Rundenanfang.',
  ),
  (
    label: 'Häkeln · Granny Square',
    asset: 'assets/examples/project_photos/03_haekeln_granny_square.png',
    tip:
        'Fotografiere das ganze Motiv mit der Stelle, an der du weiterhäkelst.',
  ),
  (
    label: 'Häkeln · Körbchen in Runden',
    asset: 'assets/examples/project_photos/04_haekeln_koerbchen.png',
    tip:
        'Ein leicht schräger Blick zeigt den Boden, die Höhe und den Arbeitsrand.',
  ),
];

class ProjectPhotoExamplesButton extends StatefulWidget {
  const ProjectPhotoExamplesButton({super.key, this.enabled = true});

  final bool enabled;

  @override
  State<ProjectPhotoExamplesButton> createState() =>
      _ProjectPhotoExamplesButtonState();
}

class _ProjectPhotoExamplesButtonState
    extends State<ProjectPhotoExamplesButton> {
  bool _opening = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton.icon(
        onPressed: widget.enabled && !_opening ? _showExamples : null,
        style: TextButton.styleFrom(
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(Icons.collections_outlined, size: 20),
        label: const Text('Beispiele ansehen', textAlign: TextAlign.center),
      ),
    );
  }

  Future<void> _showExamples() async {
    setState(() => _opening = true);
    FocusScope.of(context).unfocus();
    try {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        builder: (_) => const FractionallySizedBox(
          heightFactor: 0.9,
          child: _ProjectPhotoExamplesGallery(),
        ),
      );
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }
}

class _ProjectPhotoExamplesGallery extends StatefulWidget {
  const _ProjectPhotoExamplesGallery();

  @override
  State<_ProjectPhotoExamplesGallery> createState() =>
      _ProjectPhotoExamplesGalleryState();
}

class _ProjectPhotoExamplesGalleryState
    extends State<_ProjectPhotoExamplesGallery> {
  final _pages = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _pages.animateToPage(
      index,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Beispielfotos',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    tooltip: 'Schließen',
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Halte dein Projekt bei gutem Licht fest. '
                'Deine aktuelle Reihe oder Runde trägst du selbst ein.',
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: constraints.maxHeight * 0.58,
                child: PageView.builder(
                  controller: _pages,
                  itemCount: projectPhotoExamples.length,
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    final example = projectPhotoExamples[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: ColoredBox(
                          color: theme.colorScheme.surfaceContainerLow,
                          child: Image.asset(
                            example.asset,
                            fit: BoxFit.contain,
                            cacheWidth: 768,
                            semanticLabel: 'Beispielfoto: ${example.label}',
                            errorBuilder: (_, _, _) => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Beispiel konnte nicht geladen werden.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                projectPhotoExamples[_index].label,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                projectPhotoExamples[_index].tip,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _index > 0 ? () => _goTo(_index - 1) : null,
                    tooltip: 'Vorheriges Beispiel',
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Flexible(
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        '${_index + 1} von ${projectPhotoExamples.length}',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _index < projectPhotoExamples.length - 1
                        ? () => _goTo(_index + 1)
                        : null,
                    tooltip: 'Nächstes Beispiel',
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
              Text(
                'KI-generierte Beispiele · nur zur Ansicht',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
