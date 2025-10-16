import 'package:flutter/material.dart';

import '../../core/constants/app_size.dart';
import '../../core/extensions/localization_extension.dart';
import 'wifi_animation_widget.dart';

class RfidScanningAnimation extends StatefulWidget {
  const RfidScanningAnimation({super.key});

  @override
  State<RfidScanningAnimation> createState() => _RfidScanningAnimationState();
}

class _RfidScanningAnimationState extends State<RfidScanningAnimation>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WifiScanAnimation(),
        SizedBox(width: AppSize.size2),
        Text(
          context.l.rfidScanning,
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,fontSize: 13
          )
        ),
      ],
    );
  }
}
