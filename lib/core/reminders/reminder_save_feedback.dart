import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import '../../features/meters/domain/meter.dart';
import 'local_notification_reminder_repository.dart';

/// Domain data has already been saved. Report notification problems separately.
Future<String?> _readReminderSaveWarning(
  MeterReminderRepository reminders,
  Meter meter,
) async {
  final status = (await reminders.loadStatuses([meter.id]))[meter.id];
  if (status?.planningState == ReminderPlanningState.cancelFailed) {
    return appStrings.dataSavedCouldNotTurnOffTheReminderOpen;
  }
  final schedule = meter.reminder;
  if (schedule == null) return null;
  final available = await reminders.availability(schedule.deliveryMode);
  if (available.isBlocked) {
    return appStrings.dataSavedRemindersAreBlockedInAndroidOpenThe;
  }
  if (available == ReminderAvailability.unsupported) {
    return appStrings.dataSavedRemindersAreNotSupportedOnThisDevice;
  }
  if (status?.planningState != ReminderPlanningState.scheduled ||
      status?.nextTriggerAt == null) {
    return appStrings.dataSavedTheReminderCouldNotBeConfirmedOpen;
  }
  if (schedule.deliveryMode == ReminderDeliveryMode.punctualWithSound &&
      (!await reminders.canScheduleExactAlarms() || status?.isExact == false)) {
    return appStrings.dataSavedForAnOnTimeReminderOpenAlarms;
  }
  return null;
}

Future<String?> reminderSaveWarning(
  MeterReminderRepository reminders,
  Meter meter,
) async {
  try {
    return await _readReminderSaveWarning(reminders, meter);
  } on Object {
    return appStrings.dataSavedCouldNotCheckReminderStatusOpenThe;
  }
}
