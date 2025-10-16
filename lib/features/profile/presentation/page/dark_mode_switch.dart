import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/theme_extension.dart';

class DarkModeSwitch extends StatelessWidget {
  final void Function(bool) onToggle;

  const DarkModeSwitch({
    super.key,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
        return CupertinoSwitch(
          activeTrackColor: AppColor.colorPrimary,
          value: context.isDarkMode,
          onChanged: (bool value) {
            onToggle(value);
          },
        );
  }
}
