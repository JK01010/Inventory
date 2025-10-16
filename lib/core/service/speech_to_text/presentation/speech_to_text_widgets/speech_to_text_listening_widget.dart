import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_icons.dart';
import '../../../../constants/app_size.dart';
import '../../../../extensions/navigation_mode_extension.dart';
import '../speech_to_text_bloc/speech_to_text_bloc.dart';
import '../speech_to_text_bloc/speech_to_text_bloc_state.dart';

class SpeechToTextListeningWidget extends StatelessWidget {
  const SpeechToTextListeningWidget({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: context.isButtonNavigationMode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: AppPadding.padding20),
            child: BlocConsumer<SpeechToTextBloc, SpeechToTextState>(
              listener: (context, state) {
                if (state.text.isNotEmpty) {
                  textEditingController.text = state.text;
                  textEditingController.selection = TextSelection.fromPosition(
                    TextPosition(offset: textEditingController.text.length),
                  );
                }
              },
              buildWhen: (previous, current) {
                return (current.speechToTextStatus !=
                        previous.speechToTextStatus ||
                    current.soundLevel != previous.soundLevel ||
                    current.text != previous.text);
              },
              builder: (context, state) {
                final isListening =
                    state.speechToTextStatus == SpeechToTextStatus.listening;
                final soundLevel = isListening ? state.soundLevel : 0.0;

                final glowSize = 114.0 + (soundLevel * 2);
                const micSize = AppSize.size80;
                debugPrint("isListening in listening widget: $isListening");
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isListening ? 1.0 : 0.0,
                  curve: Curves.easeInOut,
                  child: IgnorePointer(
                    // Prevent interaction when invisible
                    ignoring: !isListening,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        height: glowSize,
                        width: glowSize,
                        decoration: BoxDecoration(
                          color: AppColor.colorBlue1.withAlpha(
                            (255 * (0.5 + (soundLevel / 100).clamp(0.0, 1.0)))
                                .toInt(),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              if (isListening) {
                                context.read<SpeechToTextBloc>().onSpeechDone();
                              } else {
                                context
                                    .read<SpeechToTextBloc>()
                                    .startListening();
                              }
                            },
                            child: Container(
                              height: micSize,
                              width: micSize,
                              decoration: BoxDecoration(
                                color: AppColor.colorPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppIcons.micIcon,
                                  height: AppSize.size30,
                                  colorFilter: const ColorFilter.mode(
                                    AppColor.colorWhite,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
