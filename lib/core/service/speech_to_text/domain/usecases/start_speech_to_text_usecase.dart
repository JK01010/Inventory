import 'package:fpdart/fpdart.dart';

import '../failures/speech_to_text_failure.dart';
import '../repositories/speech_to_text_repository.dart';

abstract class StartSpeechToTextUseCase {
  Future<Either<SpeechToTextFailures, bool>> call({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
    required Function() onDone,
  });
}

class StartSpeechToTextUseCaseImpl implements StartSpeechToTextUseCase {
  StartSpeechToTextUseCaseImpl({
    required SpeechToTextRepository speechToTextRepository,
  }) : _speechToTextRepository = speechToTextRepository;
  final SpeechToTextRepository _speechToTextRepository;

  @override
  Future<Either<SpeechToTextFailures, bool>> call({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
    required Function() onDone,
  }) async {
    return _speechToTextRepository.startListening(
      onDone: onDone,
      onResult: onResult,
      onSoundLevelChange: onSoundLevelChange,
    );
  }
}
