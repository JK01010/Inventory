import 'package:equatable/equatable.dart';

class SpeechToTextState extends Equatable {
  const SpeechToTextState({
    required this.soundLevel,
    required this.text,
    required this.speechToTextStatus,
  });

  factory SpeechToTextState.initial() {
    return SpeechToTextState(
      soundLevel: 0,
      text: '',
      speechToTextStatus: SpeechToTextStatus.stopped,
    );
  }

  final double soundLevel;
  final String text;
  final SpeechToTextStatus speechToTextStatus;

  @override
  List<Object?> get props => [soundLevel, text, speechToTextStatus];

  SpeechToTextState copyWith({
    double? soundLevel,
    String? text,
    SpeechToTextStatus? speechToTextStatus,
  }) {
    return SpeechToTextState(
      soundLevel: soundLevel ?? this.soundLevel,
      text: text ?? this.text,
      speechToTextStatus: speechToTextStatus ?? this.speechToTextStatus,
    );
  }
}

enum SpeechToTextStatus { listening, stopped }
