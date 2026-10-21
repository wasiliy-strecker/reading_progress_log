import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/app_snack_bar.dart';
import '../../../core/reminders/local_notification_reminder_repository.dart';
import '../../../core/reminders/reminder_delivery_state.dart';
import '../domain/meter.dart';

class ReminderDeliveryHint extends StatelessWidget {
  const ReminderDeliveryHint({
    super.key,
    required this.state,
    required this.mode,
    required this.onOpenSettings,
  });

  final ReminderDeliveryState state;
  final ReminderDeliveryMode mode;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final title = state.appBlocked
        ? stringsOf(context).notificationsAreTurnedOff269
        : state.channelBlocked
        ? stringsOf(context).thisReminderCategoryIsTurnedOff270
        : stringsOf(context).doNotDisturbIsOn;
    final message = state.appBlocked
        ? stringsOf(context).androidIsBlockingNotificationsForStrickHKelbuchYou
        : state.channelBlocked
        ? stringsOf(context).androidIsBlockingYouCanEnableThisCategoryIn(
            (mode == ReminderDeliveryMode.normal
                    ? stringsOf(context).projectReminders
                    : stringsOf(context).onTimeProjectReminders)
                .toString(),
          )
        : mode == ReminderDeliveryMode.normal
        ? stringsOf(context).standardRemindersMayAppearWithoutSoundOrABanner
        : stringsOf(context).alarmSoundAndBannersDependOnYourDoNot;
    return Container(
      key: const ValueKey('reminder-delivery-hint'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                state.blocked
                    ? Icons.notifications_off_outlined
                    : Icons.bedtime_outlined,
                color: colors.onSecondaryContainer,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colors.onSecondaryContainer,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onOpenSettings,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 56),
              foregroundColor: colors.onSecondaryContainer,
              side: BorderSide(color: colors.onSecondaryContainer),
            ),
            icon: const Icon(Icons.settings_outlined),
            label: Text(
              state.blocked
                  ? stringsOf(context).openAndroidSettings
                  : stringsOf(context).openDoNotDisturb,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> openReminderSettings({
  required ScaffoldMessengerState messenger,
  required MeterReminderRepository reminders,
  bool doNotDisturb = false,
  ReminderDeliveryMode? mode,
}) async {
  var opened = false;
  try {
    opened = doNotDisturb
        ? await reminders.openDoNotDisturbSettings()
        : await reminders.openNotificationSettings(mode: mode);
  } on Object {
    // A settings failure must leave the form usable.
  }
  if (opened || !messenger.mounted) return;
  messenger.showSnackBar(
    AppSnackBar(
      message: doNotDisturb
          ? appStrings.couldNotOpenSystemSettingsSearchYourPhoneSettings
          : appStrings.couldNotOpenSystemSettingsInYourPhoneSettings,
    ),
  );
}
