import 'package:flutter/material.dart';
import 'package:translate_example/controllers/translate_controller.dart';

class BuildInputArea extends StatelessWidget {
  const BuildInputArea({
    super.key,
    required this.controller,
  });

  final TranslateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller.inputController,
        // onChanged: (value) {
        //   controller.inputController.text
        //       .translate(
        //           sourceLanguage: controller.selectedInputLanguage,
        //           targetLanguage: controller.selectedOutputLanguage)
        //       .then((value) {
        //     controller.translatedText = value;
        //   });
        // },
        maxLines: 5,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter text to translate',
        ),
      ),
    );
  }
}
