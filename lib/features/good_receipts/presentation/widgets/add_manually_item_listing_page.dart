import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../item_master/presentation/bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/common_read_range_adjusting_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';

class AddManuallyItemListingPage extends StatelessWidget {
  const AddManuallyItemListingPage({super.key, required this.selectedItemId});

  final int selectedItemId;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(title: context.l.addManually),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          SizedBox(width: AppSize.size6),
                          Text(
                            context.l.zeroItems,
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSize.size10),
                // CommonReadRangeAdjustingWidget(),
                SizedBox(height: AppSize.size20),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: AppDecoratedBoxShadowWidget(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppIcons.noItemIcon),
                          const SizedBox(height: AppSize.size6),
                          Text(
                            context.l.noItemsScanned,
                            style: TextStyle(color: AppColor.colorBlack2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: AppTwoRowButtonWidget(
          buttonSecondTitle: context.l.startScan,
          buttonSecondOnPress: () {
            context.push(
              AppRoute.addManually.path,
              extra: {'selectedItemId': 0, 'screenType': ''},
            );
            // //todo rfid init
            // if(selectedItemId != 0){
            //   context.read<ItemMasterBloc>().add(KdcReaderInitEvent());
            // }
          },
        ),
      ),
    );
  }
}
