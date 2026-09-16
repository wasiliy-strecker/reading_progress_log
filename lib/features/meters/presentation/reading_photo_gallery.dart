import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import '../domain/meter_reading.dart';

class ReadingPhotoGallery extends StatelessWidget {
  const ReadingPhotoGallery({
    super.key,
    required this.photos,
    this.onReplace,
    this.onRemove,
    this.enabled = true,
  });
  final List<ReadingPhotoVersion> photos;
  final ValueChanged<ReadingPhotoVersion>? onReplace;
  final ValueChanged<ReadingPhotoVersion>? onRemove;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) return const Text('Keine aktuellen Fotos');
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = photos.length == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final (index, photo) in photos.indexed)
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    Semantics(
                      label: 'Foto ${index + 1} von ${photos.length} ansehen',
                      button: true,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ReadingPhotoViewer(
                              photos: photos,
                              initialIndex: index,
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: ReadingPhotoImage(
                              photo: photo,
                              thumbnail: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Foto ${index + 1}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (onReplace != null || onRemove != null)
                          PopupMenuButton<String>(
                            key: ValueKey('photo-menu-${photo.id}'),
                            enabled: enabled,
                            tooltip: 'Foto ${index + 1} bearbeiten',
                            onSelected: (action) => action == 'replace'
                                ? onReplace?.call(photo)
                                : onRemove?.call(photo),
                            itemBuilder: (_) => [
                              if (onReplace != null)
                                const PopupMenuItem(
                                  value: 'replace',
                                  child: Text('Foto ersetzen'),
                                ),
                              if (onRemove != null)
                                const PopupMenuItem(
                                  value: 'remove',
                                  child: Text('Foto entfernen'),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class ReadingPhotoImage extends StatelessWidget {
  const ReadingPhotoImage({
    super.key,
    required this.photo,
    this.thumbnail = false,
  });
  final ReadingPhotoVersion photo;
  final bool thumbnail;
  @override
  Widget build(BuildContext context) => Image.file(
    File(photo.path),
    fit: BoxFit.contain,
    cacheWidth: thumbnail ? 600 : null,
    errorBuilder: (_, _, _) => ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.broken_image_outlined),
              Text('Foto nicht verfügbar', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    ),
  );
}

class ReadingPhotoViewer extends StatefulWidget {
  const ReadingPhotoViewer({
    super.key,
    required this.photos,
    this.initialIndex = 0,
  });
  final List<ReadingPhotoVersion> photos;
  final int initialIndex;
  @override
  State<ReadingPhotoViewer> createState() => _ReadingPhotoViewerState();
}

class _ReadingPhotoViewerState extends State<ReadingPhotoViewer> {
  late final PageController _pages = PageController(
    initialPage: widget.initialIndex,
  );
  late int _index = widget.initialIndex;
  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Foto ${_index + 1} von ${widget.photos.length}'),
    ),
    body: PageView.builder(
      controller: _pages,
      itemCount: widget.photos.length,
      onPageChanged: (index) => setState(() => _index = index),
      itemBuilder: (_, index) => InteractiveViewer(
        minScale: 1,
        maxScale: 5,
        child: Center(child: ReadingPhotoImage(photo: widget.photos[index])),
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            tooltip: 'Vorheriges Foto',
            onPressed: _index == 0
                ? null
                : () => _pages.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  ),
            icon: const Icon(Icons.chevron_left),
          ),
          Text('${_index + 1} / ${widget.photos.length}'),
          IconButton(
            tooltip: 'Nächstes Foto',
            onPressed: _index + 1 == widget.photos.length
                ? null
                : () => _pages.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  ),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    ),
  );
}

class ReadingPhotoEditor extends StatelessWidget {
  const ReadingPhotoEditor({
    super.key,
    required this.photos,
    required this.busy,
    required this.onCamera,
    required this.onGallery,
    required this.onReplace,
    required this.onRemove,
    this.progress = '',
    this.correction = false,
  });
  final List<ReadingPhotoVersion> photos;
  final bool busy;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final ValueChanged<ReadingPhotoVersion> onReplace;
  final ValueChanged<ReadingPhotoVersion> onRemove;
  final String progress;
  final bool correction;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Aktuelle Fotos (${photos.length})',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          ReadingPhotoGallery(
            photos: photos,
            enabled: !busy,
            onReplace: onReplace,
            onRemove: onRemove,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: busy ? null : onCamera,
            icon: const Icon(Icons.add_a_photo_outlined),
            label: Text(
              photos.isEmpty ? 'Foto aufnehmen' : 'Weiteres Foto aufnehmen',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: busy ? null : onGallery,
            icon: const Icon(Icons.photo_library_outlined),
            label: const Text(
              'Fotos aus Galerie hinzufügen',
              textAlign: TextAlign.center,
            ),
          ),
          if (busy) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Text(
              progress.isEmpty ? 'Fotos werden vorbereitet …' : progress,
              textAlign: TextAlign.center,
            ),
          ],
          if (correction) ...[
            const SizedBox(height: 10),
            const Text(
              'Ersetzte und entfernte Fotos bleiben nach dem Speichern im Korrekturverlauf erhalten.',
            ),
          ],
        ],
      ),
    ),
  );
}

Future<ReadingSource?> choosePhotoReplacementSource(BuildContext context) =>
    showModalBottomSheet<ReadingSource>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const ListTile(title: Text('Foto ersetzen')),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Neu fotografieren'),
              onTap: () => Navigator.pop(context, ReadingSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Aus Galerie wählen'),
              onTap: () => Navigator.pop(context, ReadingSource.gallery),
            ),
          ],
        ),
      ),
    );
