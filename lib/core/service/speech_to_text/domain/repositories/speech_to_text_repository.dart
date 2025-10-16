import 'package:fpdart/fpdart.dart';

import '../failures/speech_to_text_failure.dart';

abstract class SpeechToTextRepository {
  Future<Either<SpeechToTextFailures, bool>> startListening({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
    required Function() onDone,
  });

  Future<Either<SpeechToTextFailures, Unit>> stopListening();
}
