import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool isListening = false;

  Future<bool> initSpeech() async {
    return await _speechToText.initialize(
      onStatus: (status) => print('Estado del micrófono: $status'),
      onError: (error) => print('Error: $error'),
    );
  }

  Future<void> startListening(Function(String) onResult) async {
    if (!_speechToText.isListening) {
      isListening = true;
      await _speechToText.listen(
        onResult: (result) => onResult(result.recognizedWords),
        localeId: 'es_ES', 
      );
    }
  }

  void stopListening() {
    _speechToText.stop();
    isListening = false;
  }
}
