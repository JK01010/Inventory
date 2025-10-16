import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../widgets/app_flat_button.dart';

class CreateLabelDetailsBottomButtonWidget extends StatelessWidget {
  const CreateLabelDetailsBottomButtonWidget({
    super.key,
    required this.buttonSecondTitle,
  });

  final String buttonSecondTitle;

  @override
  Widget build(BuildContext context) {
    return
      DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.13), // #000000 with 13% opacity
              offset: Offset(0, 2), // X: 0, Y: 2
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.padding18, horizontal: AppPadding.padding20),
          child: Row(
            children: <Widget>[
              AppFlatButton(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.padding20, vertical:AppPadding.padding12),
                text: context.l.cancel,
                onPressed: () {},
                backgroundColor: AppColor.colorWhite,
                textColor: AppColor.colorPrimary,
              ),
              SizedBox(width: AppSize.size10),
              Expanded(
                flex: 3,
                child: AppFlatButton(
                  // padding: EdgeInsets.symmetric(horizontal: AppPadding.padding24, vertical:AppPadding.padding13),
                  text: context.l.addManually,
                  onPressed: () {
                    context.push(AppRoute.addManuallyItemListingPage.path,extra: '');
                  },
                  backgroundColor: AppColor.colorPrimary,
                  textColor: AppColor.colorWhite,
                ),
              ),
              SizedBox(width: AppSize.size10),
              Expanded(
                flex: 2,
                child: AppFlatButton(
                  // padding: EdgeInsets.symmetric(horizontal: AppPadding.padding28, vertical:AppPadding.padding13),
                  text: buttonSecondTitle,
                  onPressed: () {

                  },
                  backgroundColor: AppColor.colorPrimary,
                  textColor: AppColor.colorWhite,
                ),
              ),
            ],
          ),
        ),
      );
  }
}