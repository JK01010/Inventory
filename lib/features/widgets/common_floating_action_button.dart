import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CommonFloatingActionButton extends StatelessWidget {

  const CommonFloatingActionButton({super.key,required this.onPressedAction});

  final void Function()? onPressedAction;

  @override
  Widget  build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: AppColor.colorPrimary,
        onPressed: onPressedAction,
        shape: const CircleBorder(),
        child: const Icon(Icons.add,color: AppColor.colorWhite,size: 30,)
    );
  }
}
