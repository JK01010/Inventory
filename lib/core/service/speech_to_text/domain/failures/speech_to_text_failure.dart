sealed class SpeechToTextFailures {

  SpeechToTextFailures({required this.message});
  final String message;
}

class SpeechToTextFailure extends SpeechToTextFailures {
  SpeechToTextFailure({required super.message});
}
