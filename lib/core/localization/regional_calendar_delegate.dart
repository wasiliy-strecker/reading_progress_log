import 'package:flutter/material.dart';

import '../utils/formatters.dart';
import 'app_locale.dart';

/// The picker keeps its buttons and month names in the UI language, while
/// numeric date entry follows the device region, including parsing order.
class RegionalCalendarDelegate extends GregorianCalendarDelegate {
  RegionalCalendarDelegate({AppLocaleData? settings})
    : settings = settings ?? AppLocale.current;

  final AppLocaleData settings;

  @override
  String formatCompactDate(
    DateTime date,
    MaterialLocalizations localizations,
  ) => regionalDateFormat(settings).format(date);

  @override
  String formatShortDate(DateTime date, MaterialLocalizations localizations) =>
      regionalDateFormat(settings).format(date);

  @override
  DateTime? parseCompactDate(
    String? inputString,
    MaterialLocalizations localizations,
  ) {
    if (inputString == null) return null;
    try {
      return regionalDateFormat(settings).parseStrict(inputString.trim());
    } on FormatException {
      return null;
    }
  }

  @override
  String dateHelpText(MaterialLocalizations localizations) =>
      regionalDateFormat(settings).pattern!.toUpperCase();
}
