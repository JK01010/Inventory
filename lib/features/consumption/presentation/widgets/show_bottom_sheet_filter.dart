import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../bagging_tagging_confirmtaion/domain/entities/dropdown_model.dart';
import '../../../bagging_tagging_confirmtaion/presentation/widgets/custom_dropdown.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_two_row_button_widget.dart';

Future showBottomSheetFilter(BuildContext context) {

  final List<DropDownModel> portsList = [
    DropDownModel(id: 1, title: 'Port A'),
    DropDownModel(id: 2, title: 'Port B'),
    DropDownModel(id: 3, title: 'Port C'),
  ];

  return  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.colorWhite,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // allows dynamic height
            children: [
              // Filter heading
              Padding(
                padding: const EdgeInsets.all(AppPadding.padding20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      context.l.filter,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SvgPicture.asset(
                        AppIcons.closeIcon,
                        height: AppSize.size29,
                        width: AppSize.size29,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),

              // Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    spaceNeed,
                    AppTextFormField(
                      labelText: context.l.itemName,
                      hintText: context.l.enterKeyword,
                    ),
                    spaceNeed,
                    AppTextFormField(
                      labelText: context.l.articleNo,
                      hintText: context.l.enterKeyword,
                    ),
                    spaceNeed1,
                    dropDown(
                      labelText: context.l.storageLocation,
                      hintText: context.l.chooseCategory,
                      items: portsList,
                      value: null,
                      context: context,
                      onChanged: (value) {},
                    ),
                    spaceNeed1,
                    AppTextFormField(
                      labelText: context.l.referenceNo,
                      hintText: context.l.enterKeyword,
                    ),
                    spaceNeed,
                  ],
                ),
              ),

              // Button Area
              AppTwoRowButtonWidget(
                buttonSecondTitle: context.l.apply,
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
