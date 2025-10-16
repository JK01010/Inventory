import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../good_receipts/domain/entities/goods_receipt_purchase_item_detail_entity.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/bagging_tagging_item_details_bloc/bagging_item_details_bloc.dart';
import '../widgets/custom_goods_details_widget.dart';
import '../widgets/expansion_tile_widget.dart';
import '../widgets/goods_item_card.dart';
import '../widgets/shimmer/bagging_goods_details_page_shimmer.dart';
import '../widgets/title_with_yes_no_widget.dart';
import 'bagging_tagging_details_page.dart';

class GoodsDetailsPage extends StatefulWidget {
  final GoodsReceiptPurchaseItemDetailEntity purchaseItems;

  const GoodsDetailsPage({super.key, required this.purchaseItems});

  @override
  State<GoodsDetailsPage> createState() => _GoodsDetailsPageState();
}

class _GoodsDetailsPageState extends State<GoodsDetailsPage> {
  @override
  void initState() {
    super.initState();
    debugPrint(
      "widget.purchaseItems.grnDtId : ${widget.purchaseItems.grnDtId}",
    );
    context.read<BaggingItemDetailsBloc>().add(
      BaggingItemDetailsGetAllDataEvent(
        grnDtId: widget.purchaseItems.grnDtId,
        grnId: widget.purchaseItems.grnId,
      ),
    );
  }

  List<Map<String, TextEditingController>> newQuantityListController = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaggingItemDetailsBloc, BaggingItemDetailsState>(
      listener: (context, state) {
        if (state.splitLocationEntity.isNotEmpty) {
          for (var element in state.splitLocationEntity) {
            debugPrint("element.quantity : ${element.quantity}");
            debugPrint("element.locationId : ${element.locationId}");
            // Add only if there is no element with key location id
            if (!newQuantityListController.any(
              (el) => el.containsKey(element.locationId.toString()),
            )) {
              newQuantityListController.add({
                element.locationId.toString(): TextEditingController(
                  text: element.quantity.toString(),
                ),
              });
            }
          }
        }
      },

      builder: (context, state) {
        return GradientBackground(
          child: Scaffold(
            backgroundColor: AppColor.colorTransparent,
            appBar: AppBar(
              leadingWidth: 60,
              titleSpacing: 0,
              title:
                  widget.purchaseItems.productName.isEmpty
                      ? SizedBox()
                      : Text(
                        widget.purchaseItems.productName,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                          fontSize: AppFontSize.fontSize17,
                        ),
                      ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.padding15),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: AppPadding.padding50),
                child:
                    widget.purchaseItems.productName.isEmpty
                        ? BaggingGoodsDetailsPageShimmer()
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            ExpansionTileWidget(
                              baggingTaggingPurchaseListViewEntity:
                                  widget.purchaseItems,
                            ),
                            //2nd widget
                            //todo
                            CustomInfoCard(
                              heading1: context.loc.splitStorageLocation,
                              damagedQty: context.loc.damagedQty,
                              storage: context.loc.storage,
                              newQty: context.loc.newQty,
                              receivedQty: context.loc.receivedQty,
                              damagedQuantity:
                                  state.splitLocationEntity
                                      .where((element) => element.typeId == 1)
                                      .toList(),
                              newQuantityList:
                                  state.splitLocationEntity
                                      .where((element) => element.typeId == 2)
                                      .toList(),
                              reconditionedQuantityList:
                                  state.splitLocationEntity
                                      .where((element) => element.typeId == 3)
                                      .toList(),
                              newQuantityListTextControllerList:
                                  newQuantityListController,
                            ),
                            //3rd Widget
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: AppPadding.padding18,
                                horizontal: AppPadding.padding18,
                              ),
                              decoration: ShapeDecoration(
                                color:
                                    context.isDarkMode
                                        ? AppColor.colorDarkProfileContainer
                                        : AppColor.colorWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppBorderRadius.borderRadius15,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomizableColumn(
                                            titleText: context.loc.mdRequired,
                                            yesNoText:
                                                widget.purchaseItems.isMd
                                                    .toString(),
                                          ),
                                          buildSizedBox15(),
                                          CustomizableColumn(
                                            titleText:
                                                context.loc.zeroDeclaration,
                                            yesNoText:
                                                widget
                                                    .purchaseItems
                                                    .zeroDeclaration
                                                    .toString(),
                                            bgColor: AppColor.colorGreen,
                                            yesNoTextColor: AppColor.colorWhite,
                                          ),
                                          buildSizedBox15(),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: AppSize.size6,
                                            children: [
                                              Text(
                                                ' ${context.loc.ihmAttachment}(1)',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          AppFontSize
                                                              .fontSize13,
                                                    ),
                                              ),
                                              Container(
                                                width: AppSize.size45,
                                                height: AppSize.size45,
                                                decoration: ShapeDecoration(
                                                  color:
                                                      context.isDarkMode
                                                          ? AppColor
                                                              .colorTransparent
                                                          : AppColor.colorWhite,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: AppSize.size1_5,
                                                      color:
                                                          AppColor.colorPrimary,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          AppBorderRadius
                                                              .borderRadius12,
                                                        ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    AppIcons.paperclipIcon,
                                                    height: AppSize.size25,
                                                    width: AppSize.size25,
                                                    semanticsLabel:
                                                        'Paper Clip Icon',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomizableColumn(
                                            titleText: context.loc.sdocRequired,
                                            yesNoText:
                                                widget.purchaseItems.isSdoc
                                                    .toString(),
                                            bgColor: AppColor.colorGreen,
                                            yesNoTextColor: AppColor.colorWhite,
                                          ),
                                          buildSizedBox15(),
                                          buildColumnTitleSubTitle(
                                            context: context,
                                            title: context.loc.ihmMaterialQty,
                                            subTitle:
                                                widget.purchaseItems.remarks,
                                            // state
                                            //     .baggingItemDetailsEntityList
                                            //     .first
                                            //     .iHMMaterialQty,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
              ),
            ),
            bottomNavigationBar: AppTwoRowButtonWidget(
              buttonSecondTitle: context.l.save,
              buttonSecondOnPress: () {
                debugPrint(
                  "newQuantityListController.length : ${newQuantityListController.length}",
                );
                for (var mapEntry in newQuantityListController) {
                  for (var textEditingController in mapEntry.values) {
                    debugPrint(
                      "Controller text: ${textEditingController.text}",
                    );
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  SizedBox buildSizedBox15() => const SizedBox(height: AppSize.size15);
}
