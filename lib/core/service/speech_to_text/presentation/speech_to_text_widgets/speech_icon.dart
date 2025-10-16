import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/app_colors.dart';
import '../../../../extensions/theme_extension.dart';
import '../speech_to_text_bloc/speech_to_text_bloc.dart';
import '../speech_to_text_bloc/speech_to_text_bloc_state.dart';

class SpeechToTextMicWidget extends StatelessWidget {
  const SpeechToTextMicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool isListening =
            context.read<SpeechToTextBloc>().state.speechToTextStatus ==
            SpeechToTextStatus.listening;
        if (isListening) {
          context.read<SpeechToTextBloc>().onSpeechDone();
        } else {
          context.read<SpeechToTextBloc>().startListening();
        }
      },
      child: Icon(
        Icons.mic,
        color: context.isDarkMode ? AppColor.colorWhite : AppColor.colorBlack3,
      ),
    );
  }
}
