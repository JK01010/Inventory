import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../core/utils/app_date_utils.dart';
import '../../../../packets/add_packets_sheet/domain/entities/packets_entity.dart';
import '../../../../packets/add_packets_sheet/presentation/pages/add_packets_sheet.dart';
import '../../../../packets/view_packets_sheet/presentation/view_packets_sheet.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_heading_widget.dart';
import '../../../../widgets/app_search_bar_widget.dart';
import '../../../../widgets/app_suffix_icon.dart';
import '../../../../widgets/app_text_field_with_button_widget.dart';
import '../../../../widgets/app_text_form_field.dart';
import '../../../../widgets/app_title_widget.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc_event.dart';
import '../purchase_order_detail_bloc/purchase_order_detail_bloc_state.dart';

class PurchaseOrderDetailCardWidget extends StatefulWidget {
  const PurchaseOrderDetailCardWidget({super.key});

  @override
  State<PurchaseOrderDetailCardWidget> createState() =>
      PurchaseOrderDetailCardWidgetState();
}

class PurchaseOrderDetailCardWidgetState
    extends State<PurchaseOrderDetailCardWidget> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseOrderDetailBloc, PurchaseOrderDetailBlocState>(
      buildWhen:
          (previous, current) =>
              previous.purchaseOrderData != current.purchaseOrderData,
      builder: (context, state) {
        _portReceivedController.text = state.purchaseOrderData.deliveryPort;
        _deliveryReferenceController.text =
            state.purchaseOrderData.vendorReference;
        if (state.purchaseOrderData.vendorDeliveryDate.isNotEmpty) {
          String poDate = AppDateUtils.getStringFromDateWithFormat(
            DateTime.parse(state.purchaseOrderData.vendorDeliveryDate),
            'dd-MMM-yyyy',
          );
          _poReceivedDateController.text = poDate;
        }
        _remarksController.text = state.purchaseOrderData.remarksToVendor;
        _packetsNumberController.text =
            state.purchaseOrderData.packets.isEmpty
                ? ''
                : state.purchaseOrderData.packets.length.toString();
        return AppDecoratedBoxShadowWidget(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeadingWidget(text: state.purchaseOrderData.poCode),
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
                        final pickedDate = await AppDateUtils.appDatePicker(
                          context: context,
                        );
                        if (pickedDate != null && context.mounted) {
                          String strPickedDate =
                              AppDateUtils.getStringFromDateWithFormat(
                                pickedDate,
                                'yyyy-MM-ddThh:mm:ss',
                              );
                          // context.read<GoodsReceiptsPoBloc>().add(
                          //   ChangeReceivedDate(
                          //     receivedDate: strPickedDate,
                          //     index: widget.selectedPOIndex,
                          //   ),
                          // );
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
                      onTextFieldTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: AppColor.colorWhite,
                          builder: (context) {
                            return ViewPacketsSheet(
                              packets: state.purchaseOrderData.packets,
                            );
                          },
                        );
                      },
                      onTap: () async {
                        final List<PacketEntity>? packets =
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: AppColor.colorWhite,
                              builder: (context) {
                                return AddPacketsSheet(
                                  packets: state.purchaseOrderData.packets,
                                  poHdId: state.purchaseOrderData.poHdId,
                                );
                              },
                            );
                        debugPrint("packets : $packets");
                        if (packets != null &&
                            packets.isNotEmpty &&
                            context.mounted) {
                          context.read<PurchaseOrderDetailBloc>().add(
                            SetPurchaseOrderPacketsEvent(packets: packets),
                          );
                        }
                      },
                      labelText: context.l.noOfPackets,
                      controller: _packetsNumberController,
                      readOnly: true,
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

                    /// ToDo
                    // CupertinoSwitch(
                    //   value: isEnableListener.value[1],
                    //   activeTrackColor: AppColor.colorPrimary,
                    //   onChanged: (value) {
                    //     final updatedList = List<bool>.from(
                    //       isEnableListener.value,
                    //     );
                    //     updatedList[1] = value;
                    //     isEnableListener.value = updatedList;
                    //   },
                    //   inactiveTrackColor:
                    //   context.isDarkMode
                    //       ? AppColor.colorBGBlack
                    //       : AppColor.colorGrey,
                    // ),
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
                    // CupertinoSwitch(
                    //   value: isEnableListener.value[2],
                    //   activeTrackColor: AppColor.colorPrimary,
                    //   onChanged: (value) {
                    //     final updatedList = List<bool>.from(
                    //       isEnableListener.value,
                    //     );
                    //     updatedList[2] = value;
                    //     isEnableListener.value = updatedList;
                    //   },
                    //   inactiveTrackColor:
                    //   context.isDarkMode
                    //       ? AppColor.colorBGBlack
                    //       : AppColor.colorGrey,
                    // ),
                  ],
                ),

                // if (isEnableListener.value[0])
                //   SizedBox(height: AppSize.size32),
                // if (isEnableListener.value[0])
                //   GoodsReceiptsAttachmentWidget(
                //     poId:
                //     '${state.goodsReceiptsHdEntityList[widget.selectedPOIndex].poId}',
                //   ),

                //more details
                // Align(
                //   child: GestureDetector(
                //     onTap: () {
                //       final updatedList = List<bool>.from(
                //         isEnableListener.value,
                //       );
                //       updatedList[0] = !updatedList[0];
                //       isEnableListener.value = updatedList;
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           expandTextName,
                //           style: Theme.of(context).textTheme.titleLarge
                //               ?.copyWith(color: AppColor.colorPrimary),
                //         ),
                //         Icon(
                //           icon,
                //           color:
                //           context.isDarkMode
                //               ? AppColor.colorWhite
                //               : AppColor.colorBlack2,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
