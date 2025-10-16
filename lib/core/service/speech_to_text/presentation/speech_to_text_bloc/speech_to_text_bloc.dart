import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/start_speech_to_text_usecase.dart';
import '../../domain/usecases/stop_speech_to_text_usecase.dart';
import 'speech_to_text_bloc_state.dart';

class SpeechToTextBloc extends Cubit<SpeechToTextState> {
  SpeechToTextBloc({
    required StartSpeechToTextUseCase startSpeechToTextUseCase,
    required StopSpeechToTextUseCase stopSpeechToTextUseCase,
  }) : _startSpeechToTextUseCase = startSpeechToTextUseCase,
       _stopSpeechToTextUseCase = stopSpeechToTextUseCase,
       super(SpeechToTextState.initial());
  final StartSpeechToTextUseCase _startSpeechToTextUseCase;
  final StopSpeechToTextUseCase _stopSpeechToTextUseCase;

  Future<void> startListening() async {
    emit(state.copyWith(soundLevel: 0, text: ''));
    final result = await _startSpeechToTextUseCase(
      onDone: onSpeechDone,
      onResult: onResult,
      onSoundLevelChange: onSoundLevelChange,
    );
    result.fold((l) {}, (r) {
      if (r) {
        emit(state.copyWith(speechToTextStatus: SpeechToTextStatus.listening));
      }
    });
  }

  void onSpeechDone() async {
    await _stopSpeechToTextUseCase();
    emit(state.copyWith(speechToTextStatus: SpeechToTextStatus.stopped));
  }

  void onResult(String text) {
    debugPrint("text : $text");
    emit(state.copyWith(text: text));
  }

  void onSoundLevelChange(double soundLevel) async {
    emit(state.copyWith(soundLevel: soundLevel));
  }
}
