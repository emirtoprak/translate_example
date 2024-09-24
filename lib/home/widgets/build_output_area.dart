import 'package:flutter/material.dart';
import 'package:translate_example/controllers/translate_controller.dart';

class BuildOutputArea extends StatelessWidget {
  const BuildOutputArea({super.key, required this.controller});
  final TranslateController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: double.infinity,
          color: Colors.grey[200],
          child: FutureBuilder<String?>(
            future: controller.translateText(
                text: controller.selectedInputLanguage ?? '',
                target: controller.selectedOutputLanguage ?? '',
                source: controller.inputController.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error occurred'));
              } else if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data ?? 'Translation will appear here',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                );
              } else {
                return const Center(child: Text('No translation available'));
              }
            },
          )),
    );
  }
}
