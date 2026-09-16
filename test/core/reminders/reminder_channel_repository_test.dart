import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:strick_haekelbuch/core/reminders/local_notification_reminder_repository.dart';
import 'package:strick_haekelbuch/features/meters/domain/meter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('com.appfactory.strick_haekelbuch/reminders');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final repository = LocalNotificationReminderRepository.instance;
  setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.android);
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    messenger.setMockMethodCallHandler(channel, null);
  });

  for (final mode in ReminderDeliveryMode.values) {
    for (final entry in <bool?, ReminderChannelStatus>{
      true: ReminderChannelStatus.enabled,
      false: ReminderChannelStatus.blocked,
      null: ReminderChannelStatus.unknown,
    }.entries) {
      test(
        'reads $mode as ${entry.value} without changing permission',
        () async {
          final calls = <String>[];
          messenger.setMockMethodCallHandler(channel, (call) async {
            calls.add(call.method);
            expect(call.arguments, {'deliveryMode': mode.name});
            return entry.key;
          });
          expect(await repository.channelStatus(mode), entry.value);
          expect(calls, ['isReminderChannelEnabled']);
        },
      );
    }
    test('opens the selected channel $mode', () async {
      messenger.setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'openNotificationSettings');
        expect(call.arguments, {'deliveryMode': mode.name});
        return true;
      });
      expect(await repository.openNotificationSettings(mode: mode), isTrue);
    });
    test('blocked $mode returns no test success', () async {
      messenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'areNotificationsEnabled') return true;
        expect(call.method, 'showReminderTest');
        expect((call.arguments as Map)['deliveryMode'], mode.name);
        return false;
      });
      expect(
        await repository.showReminderTest(
          MeterReminderTestRequest(
            label: 'Schal',
            meterType: MeterType.knitting,
            deliveryMode: mode,
          ),
        ),
        isFalse,
      );
    });
  }
  test('opens app notification settings for app-wide denial', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'openNotificationSettings');
      expect(call.arguments, isEmpty);
      return false;
    });
    expect(await repository.openNotificationSettings(), isFalse);
  });
  test('old native installation and failed calls remain unknown', () async {
    for (final mode in ReminderDeliveryMode.values) {
      expect(
        await repository.channelStatus(mode),
        ReminderChannelStatus.unknown,
      );
    }
    messenger.setMockMethodCallHandler(channel, (_) async {
      throw PlatformException(code: 'unavailable');
    });
    expect(
      await repository.channelStatus(ReminderDeliveryMode.normal),
      ReminderChannelStatus.unknown,
    );
    expect(await repository.openNotificationSettings(), isFalse);
  });
  test('non-Android platforms do not invoke native settings', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    messenger.setMockMethodCallHandler(channel, (_) async {
      fail('Unexpected native call');
    });
    expect(
      await repository.channelStatus(ReminderDeliveryMode.normal),
      ReminderChannelStatus.unsupported,
    );
    expect(await repository.openNotificationSettings(), isFalse);
  });
}
