import 'package:flutter/foundation.dart';

import '../../../core/files/meter_photo_repository.dart';
import '../../../core/files/photo_draft_store.dart';
import '../../../core/utils/id_generator.dart';
import '../domain/meter_reading.dart';
import '../domain/meter_repositories.dart';

/// Owns only new files. Persisted current and historical photos are never deleted
/// by an abandoned editor. The pending operation survives an Android picker restart.
class ReadingPhotoSession extends ChangeNotifier {
  ReadingPhotoSession({
    required this.route,
    required this.repository,
    required this.store,
    required this.readings,
    this.original,
  }) : photos = [...?original?.currentPhotos];

  final String route;
  final MeterPhotoCaptureRepository repository;
  final PhotoDraftStore store;
  final MeterReadingRepository readings;
  final MeterReading? original;
  final List<ReadingPhotoVersion> photos;
  final Set<String> _owned = {};
  Map<String, dynamic> fields = {};
  String readingId = newLocalId('reading');
  bool busy = false;
  bool _closed = false;
  bool _committed = false;
  String progress = '';

  bool get changed => !listEquals(
    photos.map((p) => p.id).toList(),
    (original?.currentPhotos ?? []).map((p) => p.id).toList(),
  );

  Future<void> _persist({ReadingSource? source, String? replacementId}) =>
      store.write(route, {
        'readingId': readingId,
        'originalUpdatedAt': original?.updatedAt.toIso8601String(),
        'photos': photos.map((photo) => photo.toJson()).toList(),
        'ownedPaths': _owned.toList(),
        'fields': fields,
        if (source != null) 'pendingSource': source.name,
        'replacementId': ?replacementId,
      });

  Future<PhotoImportResult> restore() async {
    if (busy || _closed) return const PhotoImportResult();
    busy = true;
    notifyListeners();
    try {
      final draft = await store.read(route);
      if (_closed || draft == null) return const PhotoImportResult();
      readingId = draft['readingId'] as String? ?? readingId;
      _owned.addAll((draft['ownedPaths'] as List).cast<String>());
      final references = (await readings.loadAll())
          .expand((r) => r.allPhotoPaths)
          .toSet();
      // A commit may have completed immediately before the process stopped.
      if ((original == null && await readings.findById(readingId) != null) ||
          _owned.any(references.contains) ||
          draft['originalUpdatedAt'] != original?.updatedAt.toIso8601String()) {
        await discard();
        return const PhotoImportResult();
      }
      photos
        ..clear()
        ..addAll(
          (draft['photos'] as List).map(
            (p) => ReadingPhotoVersion.fromJson(
              Map<String, dynamic>.from(p as Map),
            ),
          ),
        );
      fields = Map<String, dynamic>.from(draft['fields'] as Map);
      if (draft['pendingSource'] case final String source) {
        final result = await repository.recoverPhotos(
          source: ReadingSource.values.byName(source),
          onProgress: _progress,
        );
        await _accept(result, replacementId: draft['replacementId'] as String?);
        return result;
      }
      return const PhotoImportResult();
    } finally {
      busy = false;
      if (!_closed) notifyListeners();
    }
  }

  Future<PhotoImportResult> capture(
    ReadingSource source, {
    required Map<String, dynamic> formFields,
    String? replacementId,
  }) async {
    if (busy || _closed) return const PhotoImportResult();
    busy = true;
    fields = formFields;
    progress = 'Fotos werden vorbereitet …';
    notifyListeners();
    try {
      await _persist(source: source, replacementId: replacementId);
      if (_closed) return const PhotoImportResult();
      final PhotoImportResult result;
      if (source == ReadingSource.gallery && replacementId == null) {
        result = await repository.pickGalleryPhotos(onProgress: _progress);
      } else {
        final photo = await repository.capture(source);
        result = PhotoImportResult(photos: [?photo]);
      }
      await _accept(result, replacementId: replacementId);
      return result;
    } on Object {
      // A returned picker error is not an outstanding external operation.
      if (!_closed) {
        try {
          await _persist();
        } on Object {
          /* Keep the last durable draft. */
        }
      }
      rethrow;
    } finally {
      busy = false;
      if (!_closed) notifyListeners();
    }
  }

  void _progress(int completed, int total) {
    progress = 'Fotos werden vorbereitet: $completed von $total';
    if (!_closed) notifyListeners();
  }

  Future<void> _accept(
    PhotoImportResult result, {
    String? replacementId,
  }) async {
    if (_closed) {
      for (final photo in result.photos) {
        await repository.delete(photo.path);
      }
      return;
    }
    for (final picked in result.photos) {
      final photo = ReadingPhotoVersion(
        id: newLocalId('photo_version'),
        path: picked.path,
        sha256: picked.sha256,
        source: picked.source,
        addedAt: picked.capturedAt.toUtc(),
        ocrRawText: '',
        ocrCandidate: '',
      );
      _owned.add(photo.path);
      final index = replacementId == null
          ? -1
          : photos.indexWhere((p) => p.id == replacementId);
      if (index >= 0) {
        photos[index] = photo;
        replacementId = null;
      } else {
        photos.add(photo);
      }
    }
    await _persist();
    await _cleanUnused();
  }

  Future<void> removePhoto(String id, Map<String, dynamic> formFields) async {
    if (busy || _closed) return;
    fields = formFields;
    final index = photos.indexWhere((photo) => photo.id == id);
    if (index < 0) return;
    final removed = photos.removeAt(index);
    try {
      await _persist();
    } on Object {
      photos.insert(index, removed);
      rethrow;
    }
    notifyListeners();
    await _cleanUnused();
  }

  Future<void> _cleanUnused() async {
    final used = photos.map((p) => p.path).toSet();
    for (final path in _owned.toList()) {
      if (!used.contains(path)) {
        await repository.delete(path);
        _owned.remove(path);
      }
    }
    await _persist();
  }

  Future<void> rememberFields(Map<String, dynamic> formFields) async {
    if (_closed) return;
    fields = formFields;
    await _persist();
  }

  Future<void> committed() async {
    _committed = true;
    _owned.clear();
    // A stale draft is recognized against saved photo references on recovery.
    try {
      await store.remove(route);
    } on Object {
      /* The reading is committed. */
    }
  }

  Future<void> discard() async {
    final references = (await readings.loadAll())
        .expand((r) => r.allPhotoPaths)
        .toSet();
    for (final path in _owned.toList()) {
      if (!references.contains(path)) await repository.delete(path);
      _owned.remove(path);
    }
    await store.remove(route);
    photos
      ..clear()
      ..addAll(original?.currentPhotos ?? []);
    fields = {};
    readingId = newLocalId('reading');
  }

  Future<void> close() async {
    _closed = true;
    if (!_committed) await discard();
  }
}
