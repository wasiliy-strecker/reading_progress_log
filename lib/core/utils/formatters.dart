import 'package:intl/intl.dart';

import '../localization/app_locale.dart';
import '../../features/meters/domain/reading_value.dart';

DateFormat regionalDateFormat([AppLocaleData? settings]) {
  final locale = (settings ?? AppLocale.current).formatLocale;
  // Retain the familiar padded German date, including existing audit output.
  return locale.startsWith('de')
      ? DateFormat('dd.MM.yyyy', locale)
      : DateFormat.yMd(locale);
}

DateFormat regionalTimeFormat([AppLocaleData? settings]) {
  final data = settings ?? AppLocale.current;
  return data.is24Hour
      ? DateFormat.Hm(data.formatLocale)
      : DateFormat.jm(data.formatLocale);
}

DateFormat regionalDateTimeFormat([AppLocaleData? settings]) {
  final data = settings ?? AppLocale.current;
  return DateFormat(
    '${regionalDateFormat(data).pattern}, ${regionalTimeFormat(data).pattern}',
    data.formatLocale,
  );
}

String formatDateTime(DateTime value) =>
    regionalDateTimeFormat().format(value.toLocal());
String formatDate(DateTime value) =>
    regionalDateFormat().format(value.toLocal());
String formatClockTime(int hour, int minute) =>
    regionalTimeFormat().format(DateTime(2000, 1, 1, hour, minute));
String formatMonthDay(int month, int day) => DateFormat.MMMd(
  AppLocale.current.formatLocale,
).format(DateTime(2000, month, day));

String formatDecimal(num value, {int decimalPlaces = 1}) =>
    NumberFormat.decimalPatternDigits(
      locale: AppLocale.current.formatLocale,
      decimalDigits: decimalPlaces,
    ).format(value);

/// Exact formatting, including values beyond double's integer precision.
/// No stored display text, digits, scale or manifest is rewritten.
String formatReadingValue(ReadingValue value, {bool grouping = true}) {
  final format = NumberFormat.decimalPattern(AppLocale.current.formatLocale);
  final symbols = format.symbols;
  final negative = value.digits.startsWith('-');
  final digits = negative ? value.digits.substring(1) : value.digits;
  final padded = digits.padLeft(value.scale + 1, '0');
  var integer = padded.substring(0, padded.length - value.scale);
  final fraction = value.scale == 0
      ? ''
      : padded.substring(padded.length - value.scale);
  if (grouping) {
    final pattern = symbols.DECIMAL_PATTERN.split('.').first.split(',');
    final primary = pattern.last.replaceAll(RegExp('[^#0]'), '').length;
    final secondary = pattern.length > 2
        ? pattern[pattern.length - 2].replaceAll(RegExp('[^#0]'), '').length
        : primary;
    if (pattern.length > 1 && primary > 0 && secondary > 0) {
      final groups = <String>[];
      var width = primary;
      while (integer.length > width) {
        groups.insert(0, integer.substring(integer.length - width));
        integer = integer.substring(0, integer.length - width);
        width = secondary;
      }
      groups.insert(0, integer);
      integer = groups.join(symbols.GROUP_SEP);
    }
  }
  var result =
      '${negative ? symbols.MINUS_SIGN : ''}$integer'
      '${value.scale == 0 ? '' : '${symbols.DECIMAL_SEP}$fraction'}';
  final zero = symbols.ZERO_DIGIT.runes.first;
  if (zero != 48) {
    result = result.replaceAllMapped(
      RegExp('[0-9]'),
      (m) => String.fromCharCode(zero + int.parse(m[0]!)),
    );
  }
  return result;
}

String shortHash(String value) {
  if (value.length <= 20) return value;
  return '${value.substring(0, 10)}…${value.substring(value.length - 8)}';
}

/// Repository date searches keep their established representation. Convert only
/// a complete, valid regional date, never partial dates, numbers or note text.
String normalizeHistoryQuery(String query) {
  try {
    final date = regionalDateFormat().parseStrict(query.trim());
    return DateFormat('dd.MM.yyyy', 'de_DE').format(date);
  } on FormatException {
    return query;
  }
}
