import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../bloc/consumption_add_page_bloc/consumption_add_page_bloc.dart';

class ConsumptionFlatRadioCheckButton extends StatelessWidget {

  const ConsumptionFlatRadioCheckButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColor.colorTransparent,
    this.borderColor = AppColor.colorTextBlack3,
    this.textColor = AppColor.colorBlack,
    this.borderRadius = AppBorderRadius.borderRadius12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.border,
    required this.index
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final BoxBorder? border;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        margin: EdgeInsets.only(left: AppSize.size5, right: AppSize.size5),
        child: Container(
          height: AppSize.size50,
          padding: padding,
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            // border: boxBorder,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius15),
            boxShadow: [
              BoxShadow(
                color: AppColor.colorGrey,
                offset: const Offset(0, 1), // X: 0, Y: 4
                blurRadius: 2.5,
                spreadRadius: 0.6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    text,
                    style: Theme.of(context,).textTheme.titleLarge
                        ?.copyWith(color: textColor),
                  ),
                ),
              ),
              BlocBuilder<ConsumptionAddPageBloc, ConsumptionAddPageState>(
                builder: (context, state) {
                  return RoundedCheckBoxWidget(
                    value: state.selectedChooseItems[index].isSelected??false,
                    onTap: () {
                      bool value = state.selectedChooseItems[index].isSelected??false;
                      context.read<ConsumptionAddPageBloc>().add(IsChooseItemSelectedEvent(index: index,isSelectedValue:!value,isClosed: false));
                      context.pop();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
