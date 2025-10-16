

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';

class WifiScanAnimation extends StatefulWidget {
  const WifiScanAnimation({super.key});

  @override
  State<WifiScanAnimation> createState() => _WifiScanAnimationState();
}

class _WifiScanAnimationState extends State<WifiScanAnimation> {

  bool _isOuterFrame = true;
  bool _isInnerFrame = true;
  Timer? _outerTimer, _innerTimer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _outerTimer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        _isOuterFrame = !_isOuterFrame;
      });
    });
    _innerTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _isInnerFrame = !_isInnerFrame;
      });
    });
  }

  @override
  void dispose() {
    _outerTimer?.cancel();
    _innerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          _isOuterFrame ? AppIcons.wifiLeftIcon:AppIcons.wifiEmptyIcon,
          width: 10,
          height: 18,
        ),
        SvgPicture.asset(
          _isInnerFrame ? AppIcons.wifiLeftIcon:AppIcons.wifiEmptyIcon,
          width: 10,
          height: 14,
        ),
        SvgPicture.asset(
          AppIcons.wifiLeftIcon,
          width: 10,
          height: 12,
        ),
        SvgPicture.asset(
          AppIcons.wifiCenterIcon,
          width: 8,
          height: 8,
        ),
        SvgPicture.asset(
          AppIcons.wifiRightIcon,
          width: 10,
          height: 12,
        ),
        SvgPicture.asset(
          _isInnerFrame ? AppIcons.wifiRightIcon:AppIcons.wifiEmptyIcon,
          width: 10,
          height: 14,
        ),
        SvgPicture.asset(
          _isOuterFrame ? AppIcons.wifiRightIcon:AppIcons.wifiEmptyIcon,
          width: 10,
          height: 18,
        ),
      ],
    );
  }
}