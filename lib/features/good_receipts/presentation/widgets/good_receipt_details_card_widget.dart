import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/utils/app_date_utils.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_heading_widget.dart';
import '../../../widgets/app_search_bar_widget.dart';
import '../../../widgets/app_suffix_icon.dart';
import '../../../widgets/app_text_field_with_button_widget.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/app_title_widget.dart';
import '../../domain/entities/purchase_order_hd_entity.dart';
import '../goods_receipt_packet_detail_bloc/goods_receipt_packet_detail_bloc.dart';
import '../goods_receipts_po_bloc/goods_receipts_po_bloc.dart';
import 'goods_receipts_attachment_widget.dart';
import 'number_of_packets_widget.dart';

class GoodReceiptsDetailCardWidget extends StatefulWidget {
  GoodReceiptsDetailCardWidget(
    this.purchaseOrderHDEntity,
    this.selectedPOIndex,
    this.headerValueNotifiers, {
    super.key,
  });

  int selectedPOIndex;
  ValueNotifier<List<bool>> headerValueNotifiers;
  PurchaseOrderHDEntity purchaseOrderHDEntity;

  @override
  State<GoodReceiptsDetailCardWidget> createState() =>
      GoodReceiptsDetailCardWidgetState();
}

class GoodReceiptsDetailCardWidgetState
    extends State<GoodReceiptsDetailCardWidget> {
  final TextEditingController _portReceivedController = TextEditingController();
  final TextEditingController _deliveryReferenceController =
      TextEditingController();
  final TextEditingController _poReceivedDateController =
      TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _actualVolumeController = TextEditingController();
  final TextEditingController _packetsNumberController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  late PurchaseOrderHDEntity _purchaseOrderHDEntity;
  late ValueNotifier<List<bool>> isEnableListener;
  late int poId;
  late int poDtId;
  late int noOfPackets;
  late int portId;

  @override
  void initState() {
    super.initState();
    isEnableListener = widget.headerValueNotifiers;
    portId = widget.purchaseOrderHDEntity.portId ?? 0;
    _purchaseOrderHDEntity = widget.purchaseOrderHDEntity;
    _portReceivedController.text =
        widget.purchaseOrderHDEntity.deliveryPort ?? '';
    _deliveryReferenceController.text =
        widget.purchaseOrderHDEntity.vendorReference ?? '';
    if (widget.purchaseOrderHDEntity.vendorDeliveryDate != null &&
        widget.purchaseOrderHDEntity.vendorDeliveryDate!.isNotEmpty) {
      String poDate = AppDateUtils.getStringFromDateWithFormat(
        DateTime.parse(widget.purchaseOrderHDEntity.vendorDeliveryDate!),
        'dd-MMM-yyyy',
      );
      _poReceivedDateController.text = poDate;
    }
    _remarksController.text =
        widget.purchaseOrderHDEntity.remarksToVendor ?? '';
    poId = widget.purchaseOrderHDEntity.poHdId!;
    poDtId = 0;
    noOfPackets = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsReceiptsPoBloc, GoodsReceiptsPoState>(
      builder: (context, state) {
        return AppDecoratedBoxShadowWidget(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: ValueListenableBuilder(
              valueListenable: isEnableListener,
              builder: (context, value, _) {
                final String expandTextName =
                    value[0] ? context.l.hideDetails : context.l.moreDetails;
                final IconData icon =
                    value[0]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppHeadingWidget(
                      text:
                          state
                              .goodsReceiptsHdEntityList[widget.selectedPOIndex]
                              .poCode!,
                    ),
                    SizedBox(height: AppSize.size15),

                    //Port Received
                    AppSearchBar(
                      itemToString: (p0) {
                        return p0;
                      },
                      suggestionsCallback: (p0) async {
                        return [];
                      },
                      items: AppSearchBarSampleData.data,
                      labelText: context.l.portReceived,
                      onSelected: (p0) {
                        //TODO update the selected port id value into portId variable
                      },
                      controller: _portReceivedController,
                      suffixIcon: AppSuffixIcon(imagePath: AppIcons.searchIcon),
                      suffixIconBoxConstraints: BoxConstraints(),
                      filled: true,
                    ),

                    //delivery reference
                    SizedBox(height: AppSize.size15),

                    AppSearchBar(
                      itemToString: (p0) {
                        return p0;
                      },
                      suggestionsCallback: (p0) async {
                        return [];
                      },
                      items: AppSearchBarSampleData.data,
                      labelText: context.l.deliveryReference,
                      onSelected: (p0) {},
                      controller: _deliveryReferenceController,
                      suffixIcon: AppSuffixIcon(imagePath: AppIcons.searchIcon),
                      suffixIconBoxConstraints: BoxConstraints(),
                      filled: true,
                    ),
                    SizedBox(height: AppSize.size15),

                    if (isEnableListener.value[0])
                      Column(
                        children: <Widget>[
                          //received date
                          AppTextFormField(
                            labelText: context.l.receivedDate,
                            suffixIcon: AppSuffixIcon(
                              imagePath: AppIcons.calendarIcon,
                              height: AppSize.size16,
                            ),
                            controller: _poReceivedDateController,
                            suffixIconConstraints: BoxConstraints(),
                            filled: true,
                            onTap: () async {
                              final pickedDate =
                                  await AppDateUtils.appDatePicker(
                                    context: context,
                                  );
                              if (pickedDate != null && context.mounted) {
                                String strPickedDate =
                                    AppDateUtils.getStringFromDateWithFormat(
                                      pickedDate,
                                      'yyyy-MM-ddThh:mm:ss',
                                    );
                                context.read<GoodsReceiptsPoBloc>().add(
                                  ChangeReceivedDate(
                                    receivedDate: strPickedDate,
                                    index: widget.selectedPOIndex,
                                  ),
                                );
                                _poReceivedDateController.text = strPickedDate;
                              }
                            },
                            readOnly: true,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),

                          //weight - actual volume
                          SizedBox(height: AppSize.size15),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: AppTextFormField(
                                  labelText: context.l.weight,
                                  suffixIcon: UnconstrainedBox(
                                    child: AppTitleWidget(text: "Kg"),
                                  ),
                                  controller: _weightController,
                                  enabled: false,
                                  fillColor:
                                      context.isDarkMode
                                          ? AppColor.colorBGBlackEnd
                                          : AppColor.colorBlack5,
                                  filled: true,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              SizedBox(width: AppSize.size15),
                              Expanded(
                                child: AppTextFormField(
                                  labelText: context.l.actualVolume,
                                  suffixIcon: UnconstrainedBox(
                                    child: AppTitleWidget(text: "Mtq"),
                                  ),
                                  controller: _actualVolumeController,
                                  enabled: false,
                                  fillColor:
                                      context.isDarkMode
                                          ? AppColor.colorBGBlackEnd
                                          : AppColor.colorBlack5,
                                  filled: true,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),

                          //no of packets - remark
                          SizedBox(height: AppSize.size15),
                          AppTextFormFieldWithButtonWidget(
                            borderRadius: BorderRadius.circular(
                              AppBorderRadius.borderRadius12,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                // Allows top corners to be rounded
                                builder: (context) {
                                  return BlocBuilder<
                                    GoodsReceiptPacketDetailBloc,
                                    GoodsReceiptPacketDetailState
                                  >(
                                    builder: (context, state) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.6,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color:
                                                context.isDarkMode
                                                    ? AppColor.colorBGBlack
                                                    : AppColor.colorWhite,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          child: SafeArea(
                                            child: NumberOfPacketsWidget(
                                              poId: poId,
                                              poDtId: poDtId,
                                              noOfPackets: noOfPackets,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            labelText: context.l.noOfPackets,
                            controller: _packetsNumberController,
                            keyboardType: TextInputType.number,
                            buttonWidget: Center(
                              child: SvgPicture.asset(
                                AppIcons.plusIcon,
                                height: AppSize.size24,
                                width: AppSize.size24,
                                colorFilter:
                                    context.isDarkMode
                                        ? const ColorFilter.mode(
                                          AppColor.colorDividerLight,
                                          BlendMode.srcIn,
                                        )
                                        : null,
                              ),
                            ),
                            fillColor:
                                context.isDarkMode
                                    ? AppColor.colorBGBlackEnd
                                    : AppColor.colorBlack5,
                            filled: true,
                          ),
                          SizedBox(height: AppSize.size15),

                          //remark
                          AppTextFormField(
                            hintText: context.l.remark,
                            maxLine: 3,
                            controller: _remarksController,
                            filled: true,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    SizedBox(height: AppSize.size18),

                    //partial button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.l.partial,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        CupertinoSwitch(
                          value: isEnableListener.value[1],
                          activeTrackColor: AppColor.colorPrimary,
                          onChanged: (value) {
                            final updatedList = List<bool>.from(
                              isEnableListener.value,
                            );
                            updatedList[1] = value;
                            isEnableListener.value = updatedList;
                          },
                          inactiveTrackColor:
                              context.isDarkMode
                                  ? AppColor.colorBGBlack
                                  : AppColor.colorGrey,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.size10),
                    //bagging and complete button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.l.baggingTaggingCompleted,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        CupertinoSwitch(
                          value: isEnableListener.value[2],
                          activeTrackColor: AppColor.colorPrimary,
                          onChanged: (value) {
                            final updatedList = List<bool>.from(
                              isEnableListener.value,
                            );
                            updatedList[2] = value;
                            isEnableListener.value = updatedList;
                          },
                          inactiveTrackColor:
                              context.isDarkMode
                                  ? AppColor.colorBGBlack
                                  : AppColor.colorGrey,
                        ),
                      ],
                    ),

                    if (isEnableListener.value[0])
                      SizedBox(height: AppSize.size32),
                    if (isEnableListener.value[0])
                      GoodsReceiptsAttachmentWidget(
                        poId:
                            '${state.goodsReceiptsHdEntityList[widget.selectedPOIndex].poId}',
                      ),

                    //more details
                    Align(
                      child: GestureDetector(
                        onTap: () {
                          final updatedList = List<bool>.from(
                            isEnableListener.value,
                          );
                          updatedList[0] = !updatedList[0];
                          isEnableListener.value = updatedList;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              expandTextName,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: AppColor.colorPrimary),
                            ),
                            Icon(
                              icon,
                              color:
                                  context.isDarkMode
                                      ? AppColor.colorWhite
                                      : AppColor.colorBlack2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  TextEditingController get remarksController => _remarksController;

  TextEditingController get poReceivedDateController =>
      _poReceivedDateController;

  TextEditingController get deliveryReferenceController =>
      _deliveryReferenceController;

  int get receivedPortId => portId;

  double get weight =>
      _weightController.text.isNotEmpty
          ? double.parse(_weightController.text)
          : 0.0;

  double get actualVolume =>
      _actualVolumeController.text.isNotEmpty
          ? double.parse(_actualVolumeController.text)
          : 0.0;

  int get numberOfPacket =>
      _packetsNumberController.text.isNotEmpty
          ? int.parse(_packetsNumberController.text)
          : 0;

  PurchaseOrderHDEntity get purchaseOrderHDEntity => _purchaseOrderHDEntity;
}
