import 'package:flutter_tts/flutter_tts.dart';

class AudioLS {
  late FlutterTts flutterTts;
  double volume = 1;
  double pitch = 1;
  double rate = 0.3;

  initTts() {}

  Future speak(String _newVoiceText) async {
    flutterTts = FlutterTts();

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText.isNotEmpty) {
      // print("Datosss: $_newVoiceText");

      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.speak(_newVoiceText);
    } else {
      // print("Datosss: $_newVoiceText");
    }
  }
}
