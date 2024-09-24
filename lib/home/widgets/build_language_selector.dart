import 'package:flutter/material.dart';
import 'package:translate_example/controllers/translate_controller.dart';
import 'package:translate_example/home/widgets/build_dropdown_button.dart';

class BuildLanguageSelector extends StatelessWidget {
  const BuildLanguageSelector({super.key, required this.controller});

  final TranslateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildDropdownButton(
              label: 'Input Language',
              currentValue: controller.selectedInputLanguage,
              onChanged: (String? newValue) {
                controller.selectedInputLanguage = newValue!;
                controller.selectedOutputLanguage = newValue;
              },
              controller: controller),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              controller.selectedOutputLanguage =
                  controller.selectedInputLanguage;
            },
          ),
          BuildDropdownButton(
            label: 'Output Language',
            currentValue: controller.selectedOutputLanguage,
            onChanged: (String? newValue) {
              controller.selectedOutputLanguage = newValue!;
              controller.selectedInputLanguage = newValue;
            },
            controller: controller,
          ),
        ],
      ),
    );
  }
}
