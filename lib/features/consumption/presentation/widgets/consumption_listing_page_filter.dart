import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';

import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_two_row_button_widget.dart';

Future consumptionListingPageFilter({
  required BuildContext context,
  required TextEditingController textOne,
  required TextEditingController textTwo,
  required void Function()? onApply,
  required void Function()? onCancel,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Filter heading
              Padding(
                padding: const EdgeInsets.all(AppPadding.padding20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      context.l.filter,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SvgPicture.asset(
                        context.isDarkMode
                            ? AppIcons.closeDarkIcon
                            : AppIcons.closeIcon,
                        height: AppSize.size29,
                        width: AppSize.size29,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),

              //data entering area
              Padding(
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                child: Column(
                  children: [
                    AppTextFormField(
                      labelText: context.l.itemName,
                      hintText: context.l.enterKeyword,
                      controller: textOne,
                      filled: true,
                    ),
                    spaceNeed,
                    AppTextFormField(
                      labelText: context.l.articleNo,
                      hintText: context.l.enterKeyword,
                      controller: textTwo,
                      filled: true,
                    ),
                  ],
                ),
              ),
              //button area
              AppTwoRowButtonWidget(
                buttonSecondTitle: context.l.apply,
                buttonFirstTitle: context.l.clear,
                buttonFirstOnPress: onCancel,
                buttonSecondOnPress: onApply,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget spaceNeed = SizedBox(height: AppSize.size20);
Widget spaceNeed1 = SizedBox(height: AppSize.size10);
