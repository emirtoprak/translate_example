import 'package:flutter/material.dart';
import 'package:google_translate/google_translate.dart';
import 'package:provider/provider.dart';
import 'package:translate_example/controllers/translate_controller.dart';
import 'package:translate_example/home/translate_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleTranslate.initialize(
    apiKey: "5749dbb97fmsha6e6773d5c180c6p1e1e3fjsn0983f1d41e88",
    sourceLanguage: "en",
    targetLanguage: "es",
  );
  runApp(const Translate());
}

class Translate extends StatelessWidget {
  const Translate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TranslateController()),
      ],
      child: MaterialApp(
        title: 'Translate',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const TranslateHomePage(),
      ),
    );
  }
}
