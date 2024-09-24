import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_example/controllers/translate_controller.dart';
import 'package:translate_example/home/widgets/build_input_area.dart';
import 'package:translate_example/home/widgets/build_language_selector.dart';
import 'package:translate_example/home/widgets/build_output_area.dart';

class TranslateHomePage extends StatelessWidget {
  const TranslateHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TranslateController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate'),
      ),
      body: Column(
        children: [
          BuildLanguageSelector(controller: controller),
          BuildInputArea(controller: controller),
          BuildOutputArea(controller: controller),
        ],
      ),
    );
  }
}
