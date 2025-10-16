import 'dart:developer';

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
import '../../../good_receipts/presentation/widgets/print_rfid_bottom_button_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/common_view_rfid_viewing_shimmer.dart';
import '../../../widgets/common_view_rfid_viewing_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../bloc/rfid_view_bloc/rfid_view_bloc.dart';


class ItemMasterRfidViewPage extends StatefulWidget {
  const ItemMasterRfidViewPage({super.key, required this.screenType,required this.selectedItemId});

  final String screenType;
  final int selectedItemId;

  @override
  State<ItemMasterRfidViewPage> createState() => _ItemMasterRfidViewPageState();
}

class _ItemMasterRfidViewPageState extends State<ItemMasterRfidViewPage> {

  final bool isLoading = false;


  @override
  void initState() {
    super.initState();
    // context.read<RfidViewBloc>().add(ItemMasterRfidListingInsertEvent());
    context.read<RfidViewBloc>().add(ItemMasterRfidListingFetchEvent(selectedItemId: widget.selectedItemId));
  }


  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: CustomAppBar(title: context.l.viewRfid,onBack: (){
          context.read<ItemMasterBloc>().add(FetchAllDataItemMasterEvent());
          context.pop();
        },),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.padding15,
                ),
                child: BlocBuilder<RfidViewBloc, RfidViewState>(
                builder: (context, state) {
                  String itemsCount;
                  if (state.itemMasterRfidViewEntity.isNotEmpty) {
                    if (state.itemMasterRfidViewEntity.length < 10) {
                      itemsCount = "0${state.itemMasterRfidViewEntity.length}";
                    } else {
                      itemsCount = state.itemMasterRfidViewEntity.length.toString();
                    }
                  } else {
                    itemsCount = "0";
                  }
                return Visibility(
                  visible: !state.isLoading,
                  child: Text(
                    "$itemsCount item(s)",
                    style: context.textTheme.titleMedium,
                  ),
                );
               },
              ),
              ),
              SizedBox(
                height: AppSize.size18,
              ),
              Flexible(
                child: AppDecoratedBoxShadowWidget(
                  child: BlocBuilder<RfidViewBloc, RfidViewState>(
                    builder: (context, state) {
                      //noDataFound check
                      if(!state.isLoading && state.itemMasterRfidViewEntity.isEmpty){
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: AppDecoratedBoxShadowWidget(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(AppIcons.noItemIcon),
                                  const SizedBox(height: AppSize.size6),
                                  Text(context.l.noItemsScanned,style: TextStyle(color: AppColor.colorBlack2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: state.isLoading ? 13 : state.itemMasterRfidViewEntity.length,
                        itemBuilder: (context, index) {
                          if(state.isLoading) {
                            return CommonViewRfidViewingShimmer();
                          }
                          return CommonListingRfidWidget(item: state.itemMasterRfidViewEntity[index],count:index+1);
                        },
                        separatorBuilder:
                            (context, index) =>
                            SizedBox(height: AppSize.size10),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: PrintRfIdBottomButtonWidget(
          onCancelPress: (){
            context.pop();
          },
          addManuallyOnPress: (){
            context.push(
              AppRoute.addManually.path,
              extra:{
                'selectedItemId': widget.selectedItemId,
                'screenType': 'addManually',
              },
            );
            //rfid init
            if (widget.selectedItemId != 0) {
              context.read<ItemMasterBloc>().add(KdcReaderInitEvent(screenType: 'addManually'));
            }
          },
          buttonSecondTitle: context.l.scanVerifyRFID,
          onSecondButtonPress:  () {
            showSuccessPopup("Feature under development", context);
          },
          selectedItemId: widget.selectedItemId,
        ),
      ),
    );
  }
}



