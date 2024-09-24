import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslateController extends ChangeNotifier {
  TranslateController() {
    init();
  }

  String? _selectedInputLanguage;
  String? _selectedOutputLanguage;
  List<String> _supportedLanguages = [];
  String? _translatedText;
  final _inputController = TextEditingController();

  String? get selectedInputLanguage => _selectedInputLanguage;
  String? get selectedOutputLanguage => _selectedOutputLanguage;
  List<String> get supportedLanguages => _supportedLanguages;
  TextEditingController get inputController => _inputController;
  String? get translatedText => _translatedText;

  set translatedText(String? value) {
    _translatedText = value;
    notifyListeners();
  }

  set selectedInputLanguage(String? value) {
    _selectedInputLanguage = value;
    notifyListeners();
  }

  set selectedOutputLanguage(String? value) {
    _selectedOutputLanguage = value;
    notifyListeners();
  }

  set supportedLanguages(List<String> value) {
    _supportedLanguages = value;
    notifyListeners();
  }

  void setInputText(String text) {
    _inputController.text = text;
    notifyListeners();
  }

  void init() {
    fetchSupportedLanguages().then((languages) {
      supportedLanguages = languages;
      if (supportedLanguages.isNotEmpty) {
        selectedInputLanguage =
            supportedLanguages.contains('en') ? 'en' : supportedLanguages.first;
        selectedOutputLanguage =
            supportedLanguages.contains('tr') ? 'tr' : supportedLanguages.first;
      }
    });
  }

  Future<List<String>> fetchSupportedLanguages() async {
    var url = Uri.https(
        "google-translate1.p.rapidapi.com", "/language/translate/v2/languages");

    var headers = {
      'x-rapidapi-key':
          "3b677ae2afmsh8ed27826ec098cep1b73c0jsn1c9dcccc0c1f", // Replace with your own API key
      'x-rapidapi-host': "google-translate1.p.rapidapi.com",
      'Accept-Encoding': "application/gzip"
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log("Supported Languages: ${data['data']['languages']}");
      List<String> languages = List<String>.from(
          data['data']['languages'].map((lang) => lang['language']));
      return languages;
    } else {
      log("Error: ${response.statusCode}");
      return [];
    }
  }

  Future<void> detectLanguage() async {
    var url = Uri.https(
        "google-translate1.p.rapidapi.com", "/language/translate/v2/detect");

    // Define the payload (in this case, the English text to detect)
    var payload = {
      "q": "English is hard, but detectably so",
    };

    // Define the headers for the request
    var headers = {
      'x-rapidapi-key': "3b677ae2afmsh8ed27826ec098cep1b73c0jsn1c9dcccc0c1f",
      'x-rapidapi-host': "google-translate1.p.rapidapi.com",
      'Content-Type': "application/x-www-form-urlencoded",
      'Accept-Encoding': "application/gzip"
    };

    // Make the POST request
    var response = await http.post(url, headers: headers, body: payload);

    if (response.statusCode == 200) {
      // Parse the response and print it
      var data = jsonDecode(response.body);
      log("Detected language: ${data['data']['detections'][0][0]['language']}");
    } else {
      log("Error: ${response.statusCode}, ${response.body}");
    }
  }

  Future<String?> translateText(
      {required String text,
      required String target,
      required String source}) async {
    var url = Uri.https(
        "google-translate1.p.rapidapi.com", "/language/translate/v2/detect");

    var payload = {"q": text, "target": target, "source": source};

    // Define the headers for the request
    var headers = {
      'x-rapidapi-key':
          "5749dbb97fmsha6e6773d5c180c6p1e1e3fjsn0983f1d41e88", // Your API key
      'x-rapidapi-host': "google-translate1.p.rapidapi.com",
      'Content-Type': "application/json",
      'Accept-Encoding': "application/gzip"
    };

    // Make the POST request
    var response =
        await http.post(url, headers: headers, body: jsonEncode(payload));

    if (response.statusCode == 200) {
      // Parse the response and print the translated text
      var data = jsonDecode(response.body);
      log("Translated text: ${data['data']['translations'][0]['translatedText']}");
      return data['data']['translations'][0]['translatedText'];
    } else {
      log("Error: ${response.statusCode}, ${response.body}");
      return null;
    }
  }
}
