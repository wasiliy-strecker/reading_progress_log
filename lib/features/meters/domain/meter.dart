enum MeterType { knitting, crochet }

extension MeterTypeX on MeterType {
  String get wireName => name;
  String get label => switch (this) {
    MeterType.knitting => 'Stricken',
    MeterType.crochet => 'Häkeln',
  };
  List<String> get availableUnits => const ['Reihen', 'Runden'];
  String get defaultUnit => 'Reihen';
}

String progressUnitSingular(String unit) =>
    unit == 'Runden' ? 'Runde' : 'Reihe';
String currentProgressLabel(String unit) =>
    'Aktuelle ${progressUnitSingular(unit)}';
String progressValueLabel(String value, String unit) =>
    '${progressUnitSingular(unit)} $value';

enum ReminderInterval { minutely, hourly, daily, weekly, monthly, yearly }

extension ReminderIntervalLabel on ReminderInterval {
  String get label => switch (this) {
    ReminderInterval.minutely => 'Minütlich (Dev)',
    ReminderInterval.hourly => 'Stündlich',
    ReminderInterval.daily => 'Täglich',
    ReminderInterval.weekly => 'Wöchentlich',
    ReminderInterval.monthly => 'Monatlich',
    ReminderInterval.yearly => 'Jährlich',
  };
}

enum ReminderDeliveryMode { normal, punctualWithSound }

extension ReminderDeliveryModeLabel on ReminderDeliveryMode {
  String get label => switch (this) {
    ReminderDeliveryMode.normal => 'Normale Erinnerung',
    ReminderDeliveryMode.punctualWithSound => 'Pünktlich mit Ton',
  };
}

String reminderWeekdayLabel(int weekday) => switch (weekday) {
  DateTime.monday => 'Montag',
  DateTime.tuesday => 'Dienstag',
  DateTime.wednesday => 'Mittwoch',
  DateTime.thursday => 'Donnerstag',
  DateTime.friday => 'Freitag',
  DateTime.saturday => 'Samstag',
  DateTime.sunday => 'Sonntag',
  _ => 'Montag',
};

class ReadingReminderSchedule {
  const ReadingReminderSchedule({
    required this.interval,
    required this.day,
    required this.hour,
    required this.minute,
    this.month,
    this.deliveryMode = ReminderDeliveryMode.normal,
    this.startsAt,
  }) : assert(interval != ReminderInterval.hourly || startsAt != null);

  final ReminderInterval interval;
  final int day;
  final int hour;
  final int minute;
  final int? month;
  final ReminderDeliveryMode deliveryMode;
  final DateTime? startsAt;

  Map<String, dynamic> toJson() => {
    'interval': interval.name,
    'day': day,
    'hour': hour,
    'minute': minute,
    'month': month,
    'deliveryMode': deliveryMode.name,
    if (startsAt != null) 'startsAt': startsAt!.toUtc().toIso8601String(),
  };

  factory ReadingReminderSchedule.fromJson(Map<String, dynamic> json) {
    final interval = ReminderInterval.values.byName(json['interval'] as String);
    final startsAt = json['startsAt'] == null
        ? null
        : DateTime.parse(json['startsAt'] as String).toUtc();
    if (interval == ReminderInterval.hourly && startsAt == null) {
      throw const FormatException(
        'Die stündliche Erinnerung benötigt einen Startzeitpunkt.',
      );
    }
    return ReadingReminderSchedule(
      interval: interval,
      startsAt: startsAt,
      day: (json['day'] as num).toInt(),
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
      month: (json['month'] as num?)?.toInt(),
      deliveryMode: ReminderDeliveryMode.values.firstWhere(
        (mode) => mode.name == json['deliveryMode'],
        orElse: () => ReminderDeliveryMode.normal,
      ),
    );
  }
}

class Meter {
  const Meter({
    required this.id,
    required this.label,
    required this.type,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
    this.meterNumber = '',
    this.location = '',
    this.reminder,
  });

  final String id;
  final String label;
  final MeterType type;
  final String unit;
  final String meterNumber;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ReadingReminderSchedule? reminder;

  Meter copyWith({
    String? label,
    MeterType? type,
    String? unit,
    String? meterNumber,
    String? location,
    DateTime? updatedAt,
    ReadingReminderSchedule? reminder,
    bool clearReminder = false,
  }) {
    return Meter(
      id: id,
      label: label ?? this.label,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      meterNumber: meterNumber ?? this.meterNumber,
      location: location ?? this.location,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reminder: clearReminder ? null : reminder ?? this.reminder,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'type': type.name,
    'unit': unit,
    'meterNumber': meterNumber,
    'location': location,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'updatedAt': updatedAt.toUtc().toIso8601String(),
    'reminder': reminder?.toJson(),
  };

  factory Meter.fromJson(Map<String, dynamic> json) {
    final reminderJson = json['reminder'];
    return Meter(
      id: json['id'] as String,
      label: json['label'] as String,
      type: MeterType.values.byName(json['type'] as String),
      unit: json['unit'] as String,
      meterNumber: json['meterNumber'] as String? ?? '',
      location: json['location'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      reminder: reminderJson is Map
          ? ReadingReminderSchedule.fromJson(
              Map<String, dynamic>.from(reminderJson),
            )
          : null,
    );
  }
}

class MeterSnapshot {
  const MeterSnapshot({
    required this.id,
    required this.label,
    required this.type,
    required this.unit,
    required this.meterNumber,
    required this.location,
  });

  factory MeterSnapshot.fromMeter(Meter meter) => MeterSnapshot(
    id: meter.id,
    label: meter.label,
    type: meter.type,
    unit: meter.unit,
    meterNumber: meter.meterNumber,
    location: meter.location,
  );

  final String id;
  final String label;
  final MeterType type;
  final String unit;
  final String meterNumber;
  final String location;

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'type': type.name,
    'unit': unit,
    'meterNumber': meterNumber,
    'location': location,
  };

  factory MeterSnapshot.fromJson(Map<String, dynamic> json) {
    return MeterSnapshot(
      id: json['id'] as String,
      label: json['label'] as String,
      type: MeterType.values.byName(json['type'] as String),
      unit: json['unit'] as String,
      meterNumber: json['meterNumber'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );
  }
}
