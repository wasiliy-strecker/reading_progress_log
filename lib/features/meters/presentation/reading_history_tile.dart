import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_io/io.dart';

import '../../../core/utils/formatters.dart';
import '../domain/meter.dart';
import '../domain/meter_reading.dart';
import 'meter_visuals.dart';

class ReadingHistoryTile extends StatelessWidget {
  const ReadingHistoryTile({
    super.key,
    this.onTap,
    required this.reading,
    required this.showDelta,
    this.previous,
  });

  final VoidCallback? onTap;
  final MeterReading reading;
  final MeterReading? previous;
  final bool showDelta;

  @override
  Widget build(BuildContext context) {
    final meterAccent = meterColor(
      reading.meter.type,
      brightness: Theme.of(context).brightness,
    );
    final sameUnit =
        previous == null || previous!.meter.unit == reading.meter.unit;
    final delta = !showDelta || previous == null || !sameUnit
        ? null
        : formatReadingValue(reading.value.difference(previous!.value));
    return Card(
      key: ValueKey('reading-card-${reading.id}'),
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap:
            onTap ??
            () => context.pushNamed(
              'readingDetail',
              pathParameters: {'id': reading.id},
            ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: stringsOf(
                  context,
                ).recordedOn((formatDateTime(reading.capturedAt)).toString()),
                child: SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    key: ValueKey('reading-date-badge-${reading.id}'),
                    decoration: BoxDecoration(
                      color: meterAccent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 17,
                            color: meterAccent,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              stringsOf(context).recorded(
                                (formatDateTime(reading.capturedAt)).toString(),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: meterAccent,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _ReadingPhotoThumbnail(reading: reading),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentProgressLabel(reading.meter.unit),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          progressValueLabel(
                            formatReadingValue(reading.value),
                            reading.meter.unit,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        if (showDelta && previous != null && !sameUnit) ...[
                          const SizedBox(height: 8),
                          Text(
                            stringsOf(
                              context,
                            ).countingUnitChangedSinceThisEntry,
                          ),
                        ] else if (delta != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            stringsOf(context).progressChange(
                              (progressUnitSingular(
                                reading.meter.unit,
                              )).toString(),
                              (formatReadingValue(previous!.value)).toString(),
                              (formatReadingValue(reading.value)).toString(),
                              (delta).toString(),
                              progressUnitLabel(reading.meter.unit),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              if (reading.note.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notes_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        reading.note.trim(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadingPhotoThumbnail extends StatelessWidget {
  const _ReadingPhotoThumbnail({required this.reading});

  final MeterReading reading;

  @override
  Widget build(BuildContext context) {
    final fallbackColor = Theme.of(context).colorScheme.primaryContainer;
    return Semantics(
      label: reading.hasPhoto
          ? stringsOf(context).photosForProgressEntry(
              reading.currentPhotos.length,
              (formatReadingValue(reading.value)).toString(),
            )
          : stringsOf(context).enteredManually159(
              (formatReadingValue(reading.value)).toString(),
            ),
      image: reading.hasPhoto,
      child: ClipRRect(
        key: ValueKey('reading-thumbnail-${reading.id}'),
        borderRadius: BorderRadius.circular(14),
        child: SizedBox.square(
          dimension: 92,
          child: !reading.hasPhoto
              ? ColoredBox(
                  color: fallbackColor,
                  child: const Icon(Icons.edit_note_outlined, size: 30),
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(reading.currentPhotos.first.path),
                      fit: BoxFit.cover,
                      cacheWidth: 240,
                      errorBuilder: (_, _, _) => ColoredBox(
                        color: fallbackColor,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                    if (reading.currentPhotos.length > 1)
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            child: Text(
                              stringsOf(
                                context,
                              ).photoCount(reading.currentPhotos.length),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
