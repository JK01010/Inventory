import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../item_master/presentation/bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../../../widgets/app_flat_button.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';

class PrintRfIdBottomButtonWidget extends StatelessWidget {
  const PrintRfIdBottomButtonWidget({
    super.key,
    required this.buttonSecondTitle,
    required this.selectedItemId,

    required this.onCancelPress,
    required this.addManuallyOnPress,
    required this.onSecondButtonPress
  });

  final String buttonSecondTitle;

  final void Function() onCancelPress;
  final void Function() addManuallyOnPress;
  final void Function() onSecondButtonPress;

  final int selectedItemId;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColor.colorBGBlack : AppColor.colorWhite,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.13), // #000000 with 13% opacity
            offset: Offset(0, 2), // X: 0, Y: 2
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.padding18,
          horizontal: AppPadding.padding20,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: AppFlatButton(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.padding7,
                  vertical: AppPadding.padding11,
                ),
                text: context.l.cancel,
                onPressed: onCancelPress,
                backgroundColor:
                    context.isDarkMode
                        ? AppColor.colorTransparent
                        : AppColor.colorWhite,
                textColor: AppColor.colorPrimary,
              ),
            ),
            SizedBox(width: AppSize.size10),
            Expanded(
              flex: 2,
              child: AppFlatButton(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.padding10,
                  vertical: AppPadding.padding11,
                ),
                text: context.l.addManually,
                onPressed: addManuallyOnPress/*() {
                  context.push(
                    AppRoute.addManually.path,
                    extra: selectedItemId,
                  );
                  //todo rfid init
                  if (selectedItemId != 0) {
                    context.read<ItemMasterBloc>().add(KdcReaderInitEvent());
                  }
                }*/,
                backgroundColor: AppColor.colorPrimary,
                textColor: AppColor.colorWhite,
              ),
            ),
            SizedBox(width: AppSize.size10),
            Expanded(
              flex: 3,
              child: AppFlatButton(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.padding15,
                  vertical: AppPadding.padding11,
                ),
                text: buttonSecondTitle,
                onPressed: onSecondButtonPress,
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
