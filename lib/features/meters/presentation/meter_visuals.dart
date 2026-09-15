import 'package:flutter/material.dart';
import '../domain/meter.dart';

IconData meterIcon(MeterType type) => switch (type) {
  MeterType.knitting => Icons.texture_rounded,
  MeterType.crochet => Icons.gesture_rounded,
};

Color meterColor(MeterType type, {Brightness brightness = Brightness.light}) =>
    switch (type) {
      MeterType.knitting =>
        brightness == Brightness.dark
            ? const Color(0xFFB8CCB4)
            : const Color(0xFF526B59),
      MeterType.crochet =>
        brightness == Brightness.dark
            ? const Color(0xFFE0B29B)
            : const Color(0xFF9B644E),
    };
