import 'package:flutter/material.dart';
import '../../../widgets/rounded_check_box_widget.dart';

class CustomCheckButton extends StatefulWidget {
  final String checkBoxName;
  final bool enableButton;
  final ValueChanged<bool> onItemUpdate;
  final void Function()? onTap;
  final bool checkBoxValue;

  const CustomCheckButton({super.key,
    required this.checkBoxName,
    required this.enableButton,
    required this.onItemUpdate, this.onTap, this.checkBoxValue = false});

  @override
  State<CustomCheckButton> createState() => _CustomCheckboxState();
  }

  class _CustomCheckboxState extends State<CustomCheckButton> {

  late final String checkBoxName;
  late final bool enableButton;
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    checkBoxName = widget.checkBoxName;
    enableButton = widget.enableButton;
    isChecked = widget.enableButton;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       isChecked = !isChecked;
        //     });
        //     widget.onItemUpdate(isChecked);
        //   },
        //   child: SvgPicture.asset(
        //     isChecked ? AppIcons.enabledCheckboxIcon : AppIcons.disabledCheckboxIcon,
        //     width: 25,
        //     height: 25,
        //   )
        // ),
        // RoundedCheckBoxWidget(
        //     value: widget.checkBoxValue,
        //     onTap: widget.onTap
        // ),
        SizedBox(width: 10),
        Text(
          checkBoxName,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            // color: AppColor.colorTextBlack2,
          ),
        ),
      ],
    );
  }
}
