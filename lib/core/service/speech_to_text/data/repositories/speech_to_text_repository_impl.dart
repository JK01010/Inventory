import 'package:fpdart/fpdart.dart';
import '../../domain/failures/speech_to_text_failure.dart';
import '../../domain/repositories/speech_to_text_repository.dart';
import '../data_sources/speech_to_text_local_data_source.dart';

class SpeechToTextRepositoryImpl implements SpeechToTextRepository {
  SpeechToTextRepositoryImpl({
    required SpeechToTextLocalDataSource speechToTextLocalDataSource,
  }) : _speechToTextLocalDataSource = speechToTextLocalDataSource;
  final SpeechToTextLocalDataSource _speechToTextLocalDataSource;

  @override
  Future<Either<SpeechToTextFailures, bool>> startListening({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
    required Function() onDone,
  }) async {
    try {
      bool a = await _speechToTextLocalDataSource.startListening(
        onResult: onResult,
        onSoundLevelChange: onSoundLevelChange,
        onDone: onDone,
      );
      return right(a);
    } catch (e) {
      return left(SpeechToTextFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<SpeechToTextFailures, Unit>> stopListening() async {
    try {
      await _speechToTextLocalDataSource.stopListening();
      return right(unit);
    } catch (e) {
      return left(SpeechToTextFailure(message: e.toString()));
    }
  }
}
