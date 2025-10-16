import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppSize.size30,
      left: AppSize.size0,
      right: AppSize.size0,
      child: Text(
        "App Version 2.0.0",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
