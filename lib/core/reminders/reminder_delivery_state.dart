import '../../features/meters/domain/meter.dart';
import 'local_notification_reminder_repository.dart';

class ReminderDeliveryState {
  const ReminderDeliveryState({
    this.permission = ReminderPermissionStatus.unknown,
    this.channel = ReminderChannelStatus.unknown,
    this.doNotDisturb = DoNotDisturbStatus.unknown,
  });

  final ReminderPermissionStatus permission;
  final ReminderChannelStatus channel;
  final DoNotDisturbStatus doNotDisturb;

  bool get appBlocked => permission == ReminderPermissionStatus.denied;
  bool get channelBlocked => channel == ReminderChannelStatus.blocked;
  bool get blocked => appBlocked || channelBlocked;
  bool get hasHint => blocked || doNotDisturb == DoNotDisturbStatus.enabled;

  static Future<ReminderDeliveryState> read(
    MeterReminderRepository repository,
    ReminderDeliveryMode mode,
  ) async {
    final values = await Future.wait<Object>([
      _readOr(repository.permissionStatus, ReminderPermissionStatus.unknown),
      _readOr(
        () => repository.channelStatus(mode),
        ReminderChannelStatus.unknown,
      ),
      _readOr(repository.doNotDisturbStatus, DoNotDisturbStatus.unknown),
    ]);
    return ReminderDeliveryState(
      permission: values[0] as ReminderPermissionStatus,
      channel: values[1] as ReminderChannelStatus,
      doNotDisturb: values[2] as DoNotDisturbStatus,
    );
  }

  static Future<T> _readOr<T>(Future<T> Function() read, T fallback) async {
    try {
      return await read();
    } on Object {
      return fallback;
    }
  }
}
