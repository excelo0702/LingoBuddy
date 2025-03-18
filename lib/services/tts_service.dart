import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final FlutterTts _tts = FlutterTts();

  static Future<void> speak(String text, {String language = "en-US"}) async {
    await _tts.setLanguage(language);  // Set language
    await _tts.setPitch(1.0);         // Set pitch (default = 1.0)
    await _tts.setSpeechRate(0.5);    // Set speed (default = 0.5)
    await _tts.speak(text);           // Speak text
  }
}