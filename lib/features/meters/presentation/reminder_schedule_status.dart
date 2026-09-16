import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app_providers.dart';
import '../../../app/widgets/app_snack_bar.dart';
import '../../../core/reminders/local_notification_reminder_repository.dart';
import '../../../core/utils/formatters.dart';
import '../domain/meter.dart';

final reminderAvailabilityProvider = FutureProvider.autoDispose
    .family<ReminderAvailability, ReminderDeliveryMode>((ref, mode) async {
      ref.watch(reminderStatusChangesProvider);
      return ref.watch(meterReminderRepositoryProvider).availability(mode);
    });

class ReminderScheduleStatus extends ConsumerWidget {
  const ReminderScheduleStatus({
    super.key,
    required this.meterId,
    required this.deliveryMode,
    required this.nextReminder,
    required this.accentColor,
  });

  final String meterId;
  final ReminderDeliveryMode deliveryMode;
  final DateTime nextReminder;
  final Color accentColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availability =
        ref.watch(reminderAvailabilityProvider(deliveryMode)).value ??
        ReminderAvailability.unknown;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final blocked = availability.isBlocked;
    final unsupported = availability == ReminderAvailability.unsupported;
    final foreground = blocked ? colors.onErrorContainer : colors.onSurface;
    return Container(
      key: ValueKey('next-reminder-$meterId'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: blocked
            ? colors.errorContainer
            : accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: blocked ? colors.error : accentColor.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                blocked || unsupported
                    ? Icons.notifications_off_outlined
                    : Icons.schedule_outlined,
                size: 20,
                color: foreground,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blocked
                          ? 'Erinnerung blockiert'
                          : unsupported
                          ? 'Erinnerungen nicht unterstützt'
                          : availability == ReminderAvailability.available
                          ? 'Nächste Erinnerung'
                          : 'Geplanter Termin',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      blocked
                          ? availability == ReminderAvailability.appBlocked
                                ? 'Benachrichtigungen sind ausgeschaltet.'
                                : 'Diese Erinnerungsart ist ausgeschaltet.'
                          : unsupported
                          ? 'Auf diesem Gerät können keine Erinnerungen angezeigt werden.'
                          : '${formatDateTime(nextReminder)} Uhr',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: foreground,
                        fontWeight: blocked || unsupported
                            ? FontWeight.normal
                            : FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (blocked) ...[
            const SizedBox(height: 8),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 50),
                foregroundColor: foreground,
                side: BorderSide(color: foreground),
              ),
              onPressed: () => _openSettings(context, ref, availability),
              icon: const Icon(Icons.settings_outlined),
              label: const Text(
                'Einstellungen öffnen',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openSettings(
    BuildContext context,
    WidgetRef ref,
    ReminderAvailability availability,
  ) async {
    var opened = false;
    try {
      opened = await ref
          .read(meterReminderRepositoryProvider)
          .openNotificationSettings(
            mode: availability == ReminderAvailability.channelBlocked
                ? deliveryMode
                : null,
          );
    } on Object {
      // Preserve a usable manual path if Android cannot open its settings.
    }
    if (!context.mounted || opened) return;
    ScaffoldMessenger.of(context).showSnackBar(
      AppSnackBar(
        message:
            'Die Einstellungen konnten nicht geöffnet werden. Öffne in den '
            'Einstellungen deines Smartphones „Apps“, wähle diese App und '
            'dann „Benachrichtigungen“.',
      ),
    );
  }
}
