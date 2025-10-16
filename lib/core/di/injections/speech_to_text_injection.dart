import '../../service/speech_to_text/data/data_sources/speech_to_text_local_data_source.dart';
import '../../service/speech_to_text/data/repositories/speech_to_text_repository_impl.dart';
import '../../service/speech_to_text/domain/repositories/speech_to_text_repository.dart';
import '../../service/speech_to_text/domain/usecases/start_speech_to_text_usecase.dart';
import '../../service/speech_to_text/domain/usecases/stop_speech_to_text_usecase.dart';
import '../../service/speech_to_text/presentation/speech_to_text_bloc/speech_to_text_bloc.dart';
import '../service_locator.dart';

void speechToTextInjection() {
  sl
    // === Data Source ===
    ..registerSingleton<SpeechToTextLocalDataSource>(
      SpeechToTextLocalDataSourceImpl(),
    )
    // === Repository ===
    ..registerSingleton<SpeechToTextRepository>(
      SpeechToTextRepositoryImpl(
        speechToTextLocalDataSource: sl<SpeechToTextLocalDataSource>(),
      ),
    )
    // === Use Cases ===
    ..registerSingleton<StartSpeechToTextUseCase>(
      StartSpeechToTextUseCaseImpl(
        speechToTextRepository: sl<SpeechToTextRepository>(),
      ),
    )
    ..registerSingleton<StopSpeechToTextUseCase>(
      StopSpeechToTextUseCaseImpl(
        speechToTextRepository: sl<SpeechToTextRepository>(),
      ),
    )
    ..registerFactory<SpeechToTextBloc>(
      () => SpeechToTextBloc(
        startSpeechToTextUseCase: sl<StartSpeechToTextUseCase>(),
        stopSpeechToTextUseCase: sl<StopSpeechToTextUseCase>(),
      ),
    );
}
