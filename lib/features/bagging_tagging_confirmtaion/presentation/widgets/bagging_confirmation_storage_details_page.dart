import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enum.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import '../../../item_master/presentation/widgets/item_detail_row.dart';
import '../../../widgets/app_bar_title_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_title_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/chip_icon_list_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../../model/confirmation_selection_model.dart';
import '../bloc/bagging_confirmation_list/bagging_confirmation_list_bloc.dart';
import '../widgets/custom_checkbox.dart';
import 'shimmer/bagging_confirmation_shimmer.dart';

class BaggingConfirmationStorageDetailsPage extends StatefulWidget {
  BaggingConfirmationStorageDetailsPage({
    super.key,
    required this.selectedItemIds,
    required this.grnId,
    required this.storageLocId
  });

  List<int> selectedItemIds;
  int grnId;
  int storageLocId;

  @override
  State<BaggingConfirmationStorageDetailsPage> createState() =>
      _BaggingConfirmationStorageDetailsPageState();
}

class _BaggingConfirmationStorageDetailsPageState
    extends State<BaggingConfirmationStorageDetailsPage> {

  final List<Map<String, dynamic>> _selectedItems =
      []; // to store selected items

  @override
  void initState() {
    super.initState();
    log("selectedItems listing page----> ${widget.selectedItemIds.length}");
    log("grnId listing page----> ${widget.grnId}");
    log("locationId listing page----> ${widget.grnId}");

    context.read<BaggingConfirmationListBloc>().add(
      FetchConfirmationListByItemIdsEvent(itemIds: widget.selectedItemIds, storageLocationId: widget.storageLocId, grnId: widget.grnId),
    );
  }

  void _toggleSelection(Map<String, dynamic> item) {
    debugPrint("Item selected: $item");
    final exists = _selectedItems.any((e) => e['ItemID'] == item['ItemID']);
    setState(() {
      if (exists) {
        _selectedItems.removeWhere((e) => e['ItemID'] == item['ItemID']);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GradientBackground(
      child: BlocListener<
        BaggingConfirmationListBloc,
        BaggingConfirmationListState
      >(
        listenWhen:
            (previous, current) =>
                !current.isConfirmationListLoading, // only when loaded
        listener: (context, state) {},
        child: Scaffold(
          backgroundColor: AppColor.colorTransparent,
          appBar: AppBar(
            titleSpacing: AppSize.size0,
            title: Padding(
              padding: EdgeInsets.only(top: AppPadding.scaffoldPadding),
              child: AppBarTitleWidget(
                text: AppLocalizations.of(context)?.confirmation ?? "",
              ),
            ),

            leadingWidth: AppSize.appBarLeadingWidth,
            leading: InkWell(
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppPadding.scaffoldPadding,
                  left: AppPadding.scaffoldPadding,
                ),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
          body: BlocBuilder<
            BaggingConfirmationListBloc,
            BaggingConfirmationListState
          >(
            builder: (context, state) {

              if (state.isConfirmationListLoading) {
                // Loading shimmer
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 4,
                    itemBuilder: (_, __) => const BaggingConfirmationShimmer(),
                    separatorBuilder: (_, __) => const SizedBox(),
                  ),
                );
              }

              if (state.confirmationListByItemIds.isEmpty) {
                // No data found
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppDecoratedBoxShadowWidget(
                    child: commonNoDataFoundTwo(context),
                  ),
                );
              }

              // Show list
              return Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: AppSize.size25),
                      CustomCheckButton(
                        checkBoxName: '${state.confirmationListByItemIds.length} Item(s) found',
                        enableButton: true,
                        onItemUpdate: onDeckStoreItemDataFound,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: state.confirmationListByItemIds.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = state.confirmationListByItemIds[index];
                          final isSelected = _selectedItems.any(
                            (e) =>
                                e['ItemID'].toString() == item['ItemID'].toString(),
                          );
                      
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: AppDecoratedBoxShadowWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      AppPadding.scaffoldPadding,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Item heading
                                        Row(
                                          children: [
                                            item['IsInList'] == "Found"?
                                            RoundedCheckBoxWidget(
                                              value: isSelected,
                                              onTap: () => _toggleSelection(item),
                                            ):SizedBox(),
                                            const SizedBox(width: AppSize.size15),
                                            Text(
                                                item['itemName']!=null?item['itemName'].toString():"",
                                              style: textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: AppSize.size15),
                                        ItemDetailRow(
                                          titleFirst: context.l.rob,
                                          valueFirst: item['Quantity']!=null?item['Quantity'].toString():"-",
                                          titleSecond: context.l.articleNo,
                                          valueSecond:
                                          item['articleNumber']!=null?item['articleNumber'].toString():"",
                                          spacer: AppSize.size105,
                                        ),
                                        const SizedBox(height: AppSize.size10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppTitleWidget(
                                              text: context.l.storageLocation,
                                            ),
                                            const GoodsReceiptValueWidget(text: "-"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(height: 0),
                                  ChipIconListWidget(
                      
                                    chipStatusList:  item['IsInList'] == "Found"? []:const [
                                      ChipStatus.noDataFound
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          bottomNavigationBar: AppTwoRowButtonWidget(
            buttonSecondTitle: context.l.save,
            buttonFirstOnPress: () {
              debugPrint("Cancel Button pressed");
            },
            buttonSecondOnPress: () {
              debugPrint("Save Button pressed");
              debugPrint("Selected Items: $_selectedItems");
              context.read<BaggingConfirmationListBloc>().add(
                SaveConfirmationEvent(grnId: widget.grnId), ///replace with actual data
              );
              context
                  ..pop()
                  ..pop();
            },
          ),
        ),
      ),
    );
  }

  void onDeckStoreItemDataFound(bool value) {
    //print('The checkbox value is $value');
  }
}
