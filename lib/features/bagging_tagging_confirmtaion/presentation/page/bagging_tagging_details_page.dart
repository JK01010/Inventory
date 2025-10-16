import 'dart:developer';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../good_receipts/domain/entities/goods_receipt_transaction_entity.dart';
import '../../../good_receipts/presentation/widgets/number_of_packets_popup_widget.dart';
import '../../../good_receipts/presentation/widgets/yes_no_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../bloc/bagging_tagging_confirmation_bloc/bagging_tagging_confirmation_bloc.dart';
import '../bloc/bagging_tagging_purchase_pending_bloc/bagging_tagging_purchase_pending_bloc.dart';
import '../bloc/bagging_tagging_purchase_pending_details_bloc/bagging_tagging_purchase_pending_details_bloc.dart';
import '../widgets/goods_item_card.dart';
import '../widgets/shimmer/bagging_pending_details_shimmer.dart';
import '../widgets/shimmer/bagging_pending_shimmer.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}

class BaggingTaggingDetailsView extends StatefulWidget {
  const BaggingTaggingDetailsView({super.key, required this.items});

  final GoodsReceiptsTransactionEntity items;

  @override
  State<BaggingTaggingDetailsView> createState() =>
      _BaggingTaggingDetailsViewState();
}

class _BaggingTaggingDetailsViewState extends State<BaggingTaggingDetailsView> {
  @override
  void initState() {
    super.initState();
    /*  context.read<BaggingItemDetailsBloc>()
      ..add(BaggingPurchaseItemDetailsGetAllDataEvent())
      ..add(BaggingPurchaseItemListGetAllDataEvent());*/
    // context.read<BaggingTaggingPurchaseListBloc>().add(
    //   BaggingTaggingPurchaseListGetAllDataEvent(poHDId: widget.items.poNo),
    // );

    context.read<BaggingTaggingPurchasePendingDetailsBloc>().add(
      SetPendingInitalDataEvent(goodsReceiptsTransactionEntity: widget.items),
    );
    // goodsReceiptPurchaseItemDetailEntityList

    context.read<BaggingTaggingPurchasePendingDetailsBloc>().add(
      GetBaggingTaggingPendingByIdEvent(widget.items.grnId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      BaggingTaggingPurchasePendingDetailsBloc,
      BaggingTaggingPurchasePendingDetailsState
    >(
      listener: (context, state) {
        if (state.saveLoading) {
          context.read<BaggingTaggingPurchasePendingBloc>().add(
            FetchAllTransactionFromDb(),
          );
          context.read<BaggingTaggingConfirmationBloc>().add(
            FetchAllConfirmationTransactionFromDb(),
          );
          context.pop();
        }
      },
      child: GradientBackground(
        child: BlocBuilder<
          BaggingTaggingPurchasePendingDetailsBloc,
          BaggingTaggingPurchasePendingDetailsState
        >(
          // buildWhen:
          //     (previous, current) =>
          //         (previous.isLoading != current.isLoading),
          builder: (context, state) {
            debugPrint(
              "needs PoiD::::::${state.goodsReceiptsTransactionEntity.poId}",
            );
            debugPrint(
              "needs lengthhhhh::::::${state.goodsReceiptPurchaseItemDetailEntityList.length}",
            );
            return Scaffold(
              backgroundColor: AppColor.colorTransparent,
              appBar: AppBar(
                leadingWidth: 60,
                titleSpacing: 0,
                title: Text(
                  state.goodsReceiptsTransactionEntity.poNo,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.padding15,
                      ),
                      child:
                      // return
                      Column(
                        children: [
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
                            child:
                                state.isLoading
                                    ? BaggingPendingDetailsShimmer()
                                    : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state
                                              .goodsReceiptsTransactionEntity
                                              .pOtitle,
                                          // state.baggingTaggingList.first.poCode,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineSmall?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: AppFontSize.fontSize16,
                                          ),
                                        ),
                                        buildSizedBox10(),
                                        Row(
                                          children: [
                                            CountryFlag.fromCountryCode(
                                              state
                                                      .goodsReceiptPurchaseItemDetailEntity
                                                      .countryName
                                                      .isEmpty
                                                  ? "-"
                                                  : state
                                                      .goodsReceiptPurchaseItemDetailEntity
                                                      .countryName,
                                              height: AppSize.size20,
                                              width: AppSize.size30,
                                              shape: const RoundedRectangle(6),
                                            ),
                                            SizedBox(width: AppSize.size10),
                                            Text(
                                              state
                                                      .goodsReceiptPurchaseItemDetailEntity
                                                      .countryName
                                                      .isEmpty
                                                  ? "-"
                                                  : state
                                                      .goodsReceiptPurchaseItemDetailEntity
                                                      .countryName,
                                            ),
                                          ],
                                        ),
                                        /*dropDown(
                              labelText: context.loc.portReceived,
                              hintText: context.loc.deliveryPortHint,
                              items: portsList,
                              value: null,
                              context: context,
                              onChanged: (value) {},
                            ),*/
                                        buildSizedBox10(),
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
                                                buildColumnTitleSubTitle(
                                                  context: context,
                                                  title:
                                                      context
                                                          .loc
                                                          .deliveryReference,
                                                  subTitle:
                                                      state
                                                          .goodsReceiptsTransactionEntity
                                                          .poNo,
                                                ),
                                                buildSizedBox10(),
                                                buildColumnTitleSubTitle(
                                                  context: context,
                                                  title: context.loc.weight,
                                                  subTitle:
                                                      state
                                                          .goodsReceiptsTransactionEntity
                                                          .weight
                                                          .toString(),
                                                ),
                                                buildSizedBox10(),
                                                buildColumnColoredTitleSubTitle(
                                                  context: context,
                                                  title:
                                                      context.loc.noOfPackets,
                                                  subTitle: state
                                                      .goodsReceiptsTransactionEntity
                                                      .noOfPackets
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  widthSize: AppSize.size30,
                                                  coloredSubTitleOnTap: () async {
                                                    showModalBottomSheet(
                                                      isDismissible: false,
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder: (context) {
                                                        return DecoratedBox(
                                                          decoration: BoxDecoration(
                                                            color:
                                                                context.isDarkMode
                                                                    ? AppColor
                                                                        .colorBGBlack
                                                                    : AppColor
                                                                        .colorWhite,
                                                            borderRadius: BorderRadius.vertical(
                                                              top: Radius.circular(
                                                                AppBorderRadius
                                                                    .borderRadius20,
                                                              ),
                                                            ),
                                                          ),
                                                          child: NumberOfPacketsPopupWidget(
                                                            grnId:
                                                                widget
                                                                    .items
                                                                    .grnId
                                                                    .toString(),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                buildSizedBox10(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing: AppSize.size6,
                                                  children: [
                                                    Text(
                                                      context
                                                          .loc
                                                          .baggingTaggingCompleted,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize:
                                                                AppFontSize
                                                                    .fontSize13,
                                                          ),
                                                    ),
                                                    state
                                                                .goodsReceiptsTransactionEntity
                                                                .isBaggingCompleted ==
                                                            'Y'
                                                        ? YesNoWidget.yes(
                                                          context,
                                                        )
                                                        : YesNoWidget.no(
                                                          context,
                                                        ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                buildColumnTitleSubTitle(
                                                  context: context,
                                                  title:
                                                      context.loc.receivedDate,
                                                  subTitle:
                                                      state
                                                          .goodsReceiptsTransactionEntity
                                                          .receiptDate,
                                                ),
                                                buildSizedBox10(),
                                                buildColumnTitleSubTitle(
                                                  context: context,
                                                  title:
                                                      context.loc.actualVolume,
                                                  subTitle:
                                                      state
                                                          .goodsReceiptsTransactionEntity
                                                          .actualvolume
                                                          .toString(),
                                                ),
                                                buildSizedBox10(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing: AppSize.size6,
                                                  children: [
                                                    Text(
                                                      context.loc.partial,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize:
                                                                AppFontSize
                                                                    .fontSize13,
                                                          ),
                                                    ),
                                                    state
                                                                .goodsReceiptsTransactionEntity
                                                                .isFull ==
                                                            'Y'
                                                        ? YesNoWidget.yes(
                                                          context,
                                                        )
                                                        : YesNoWidget.no(
                                                          context,
                                                        ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                          ),

                          ///item listing
                          SizedBox(height: AppSize.size15),
                          Column(
                            children: [
                              state.isLoading
                                  ? SizedBox(height: AppSize.size10)
                                  : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${context.loc.itemsRoundBrackets}${state.goodsReceiptPurchaseItemDetailEntityList.length})",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: AppFontSize.fontSize16,
                                        ),
                                      ),
                                      Container(
                                        width: AppSize.size134_18,
                                        height: AppSize.size35,
                                        decoration: BoxDecoration(
                                          color:
                                              context.isDarkMode
                                                  ? AppColor.colorTransparent
                                                  : AppColor.colorWhite,
                                          border: Border.all(
                                            color:
                                                context.isDarkMode
                                                    ? AppColor
                                                        .createLabelBorderDarkColor
                                                    : AppColor.colorGrey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            AppBorderRadius.borderRadius8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            // Main label container
                                            GestureDetector(
                                              onTap: () {
                                                context.push(
                                                  AppRoute
                                                      .baggingPrintRfidPage
                                                      .path,
                                                );
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: AppPadding.padding10,
                                                  right: AppPadding.padding10,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context.loc.createLabel,
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleMedium?.copyWith(
                                                      color: context
                                                          .customThemeColor(
                                                            light:
                                                                AppColor
                                                                    .colorBlack2,
                                                            dark:
                                                                AppColor
                                                                    .colorPrimary,
                                                          ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          AppFontSize
                                                              .fontSize14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Dots menu icon
                                            Container(
                                              width: AppSize.size30,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    context.isDarkMode
                                                        ? AppColor
                                                            .colorTransparent
                                                        : AppColor.colorWhite,
                                                border: Border(
                                                  left: BorderSide(
                                                    color:
                                                        context.isDarkMode
                                                            ? AppColor
                                                                .createLabelBorderDarkColor
                                                            : AppColor
                                                                .colorGrey,
                                                  ),
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(
                                                    AppBorderRadius
                                                        .borderRadius7,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    AppBorderRadius
                                                        .borderRadius7,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  AppIcons.threeDotIcon,
                                                  semanticsLabel: 'More Icon',
                                                  colorFilter:
                                                      context.isDarkMode
                                                          ? const ColorFilter.mode(
                                                            AppColor
                                                                .colorPrimary,
                                                            BlendMode.srcIn,
                                                          )
                                                          : null,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.isLoading
                                        ? 4
                                        : state
                                            .goodsReceiptPurchaseItemDetailEntityList
                                            .length,
                                itemBuilder:
                                    (context, index) =>
                                        state.isLoading
                                            ? BaggingPendingShimmer()
                                            : GestureDetector(
                                              onTap: () {
                                                context.push(
                                                  AppRoute
                                                      .goodsDetailsPage
                                                      .path,
                                                  extra:
                                                      state
                                                          .goodsReceiptPurchaseItemDetailEntityList[index],
                                                );
                                              },
                                              child: GoodsItemCard(
                                                baggingTaggingPurchaseListViewEntity:
                                                    state
                                                        .goodsReceiptPurchaseItemDetailEntityList[index],
                                              ),
                                            ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AppTwoRowButtonWidget(
                buttonSecondTitle: context.l.save,
                buttonSecondOnPress: () {
                  context.read<BaggingTaggingPurchasePendingDetailsBloc>().add(
                    SaveBaggingAndTagging(id: widget.items.grnId),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Column buildColumnTitleSubTitle({
    required BuildContext context,
    required String title,
    required String subTitle,
    double? widthSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSize.size6,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            overflow: TextOverflow.ellipsis,
            fontSize: AppFontSize.fontSize13,
          ),
        ),
        SizedBox(
          width: widthSize,
          child: Text(
            subTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
              fontSize: AppFontSize.fontSize14,
            ),
          ),
        ),
      ],
    );
  }

  Column buildColumnColoredTitleSubTitle({
    required BuildContext context,
    required String title,
    required String subTitle,
    void Function()? coloredSubTitleOnTap,
    double? widthSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSize.size6,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            overflow: TextOverflow.ellipsis,
            fontSize: AppFontSize.fontSize13,
          ),
        ),
        InkWell(
          onTap: coloredSubTitleOnTap,
          child: SizedBox(
            width: widthSize,
            child: Text(
              subTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColor.colorPrimary,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
                fontSize: AppFontSize.fontSize14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox buildSizedBox10() => SizedBox(height: AppSize.size10);
}
