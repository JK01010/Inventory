import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../consumption/presentation/bloc/consumption_rfid_scanning_bloc/consumption_rfid_scanning_bloc.dart';

ValueNotifier<double> sliderValue = ValueNotifier(0.0);

class CreateLabelSliderWidget extends StatelessWidget {
  const CreateLabelSliderWidget({super.key,required this.valuePassed,required this.onChanged});

  final double valuePassed;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    const double kMin = 18;
    const double kMax = 30;
    const double thumbRadius = AppSize.size8;

    return ValueListenableBuilder<double>(
      valueListenable: sliderValue,
      builder: (context, value, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            // Calculate percent based on current value
            final double percent = (value - kMin) / (kMax - kMin);
            final double trackWidth = constraints.maxWidth - thumbRadius * 2;
            final double thumbCenterX = thumbRadius + trackWidth * percent;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Slider
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: AppSize.size8,
                    activeTrackColor: AppColor.colorGreen,
                    inactiveTrackColor: Colors.green.shade100,
                    trackShape: const RoundedRectSliderTrackShape(),
                    thumbShape: _ThumbWithBorderShape(
                      thumbRadius: thumbRadius,
                      borderColor: AppColor.colorGreen,
                      borderWidth: 3,
                    ),
                    thumbColor: AppColor.colorWhite,
                    overlayColor: AppColor.colorGreen.withAlpha(32),
                    overlayShape: const RoundSliderOverlayShape(),
                  ),
                  child: Slider(
                    padding: EdgeInsets.zero,
                    min: kMin,
                    max: kMax,
                    divisions: (kMax - kMin).toInt(), // optional: steps of 1
                    value: valuePassed.clamp(kMin, kMax),
                    onChanged: onChanged /*(newValue) {
                      context.read<ConsumptionRfidScanningBloc>().add(UpdateRangeEvent(range: newValue.round()));
                      log("slider value increasing");
                      sliderValue.value = newValue;
                    }*/,
                  ),
                ),
                SizedBox(height: AppSize.size10),
                SizedBox(
                  height: AppSize.size20,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Min label
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Text(
                          '${kMin.toInt()}',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                      // Current value above thumb
                      // Positioned(
                      //   left: thumbCenterX - AppSize.size20,
                      //   bottom: 0,
                      //   child: Text(
                      //     '${value.toStringAsFixed(1)}',
                      //     style: context.textTheme.bodyMedium?.copyWith(
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      // Max label
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Text(
                          '${kMax.toInt()}',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ThumbWithBorderShape extends SliderComponentShape {
  _ThumbWithBorderShape({
    required this.thumbRadius,
    required this.borderColor,
    required this.borderWidth,
  });

  final double thumbRadius;
  final Color borderColor;
  final double borderWidth;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius + borderWidth);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;

    final Paint fillPaint =
        Paint()
          ..color = sliderTheme.thumbColor ?? Colors.white
          ..style = PaintingStyle.fill;

    canvas
      ..drawCircle(center, thumbRadius, fillPaint)
      ..drawCircle(center, thumbRadius, borderPaint);
  }
}
