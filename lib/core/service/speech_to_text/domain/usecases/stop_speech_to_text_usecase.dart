import 'package:fpdart/fpdart.dart';

import '../failures/speech_to_text_failure.dart';
import '../repositories/speech_to_text_repository.dart';

abstract class StopSpeechToTextUseCase {
  Future<Either<SpeechToTextFailures, Unit>> call();
}

class StopSpeechToTextUseCaseImpl implements StopSpeechToTextUseCase {
  StopSpeechToTextUseCaseImpl({
    required SpeechToTextRepository speechToTextRepository,
  }) : _speechToTextRepository = speechToTextRepository;
  final SpeechToTextRepository _speechToTextRepository;

  @override
  Future<Either<SpeechToTextFailures, Unit>> call() async {
    return _speechToTextRepository.stopListening();
  }
}
