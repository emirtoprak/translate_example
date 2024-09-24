import 'package:flutter/material.dart';
import 'package:translate_example/controllers/translate_controller.dart';

class BuildDropdownButton extends StatelessWidget {
  const BuildDropdownButton({
    super.key,
    required this.label,
    required this.currentValue,
    required this.onChanged,
    required this.controller,
  });

  final String label;
  final String? currentValue;
  final ValueChanged<String?> onChanged;
  final TranslateController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: currentValue,
          onChanged: controller.supportedLanguages.isEmpty ? null : onChanged,
          items: controller.supportedLanguages.isEmpty
              ? []
              : controller.supportedLanguages
                  .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
        ),
      ],
    );
  }
}
