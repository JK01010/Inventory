import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

abstract interface class SpeechToTextLocalDataSource {
  Future<bool> startListening({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
    required Function() onDone,
  });

  Future<void> stopListening();
}

class SpeechToTextLocalDataSourceImpl implements SpeechToTextLocalDataSource {
  final SpeechToText _speech = SpeechToText();

  @override
  Future<bool> startListening({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
    required Function() onDone,
  }) async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        debugPrint("Speech status: $status");
        if (status == 'done' || status == 'notListening') {
          onDone();
        }
      },
      onError: (error) => debugPrint("Speech error: $error"),
    );
    if (!available) {
      return false;
    } else {
      await _speech.listen(
        onResult: (result) => onResult(result.recognizedWords),
        onSoundLevelChange: (val) {
          onSoundLevelChange(val);
        },
      );
      return true;
    }
  }

  @override
  Future<void> stopListening() async {
    await _speech.stop();
  }
}
