import 'package:flutter/material.dart';
import '../domain/meter.dart';

class MeterUnitField extends StatelessWidget {
  const MeterUnitField({
    super.key,
    required this.meterType,
    required this.value,
    required this.labelText,
    required this.onChanged,
    this.enabled = true,
  });
  final MeterType meterType;
  final String value;
  final String labelText;
  final ValueChanged<String> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
    key: ValueKey('project-unit-$value'),
    initialValue: value,
    isExpanded: true,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: const Icon(Icons.format_list_numbered_outlined),
    ),
    items: [
      for (final unit in meterType.availableUnits)
        DropdownMenuItem(value: unit, child: Text(unit)),
    ],
    onChanged: enabled
        ? (unit) {
            if (unit != null) onChanged(unit);
          }
        : null,
  );
}
