import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import 'add_location_bottom_bar_widget.dart';
import 'create_label_item_row_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_dropdown_widget.dart';
import '../../../widgets/app_suffix_icon.dart';
import '../../../widgets/app_text_field_with_button_widget.dart';
import '../../../widgets/app_text_form_field.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/utils/app_date_utils.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../bagging_tagging_confirmtaion/presentation/page/bagging_tagging_details_page.dart';
import '../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../common_feature/domain/entities/storage_location_entity.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/entities/split_location_entity.dart';
import '../goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import '../goods_receipt_split_location_bloc/goods_receipt_split_location_bloc.dart';
import '../quality_bloc/quality_bloc.dart';
import '../storage_location_bloc/storage_location_bloc.dart';
import 'serial_number_widget.dart';
import 'split_storage_location_bottom_bar_widget.dart';

class CreateLabelSecondCardWidget extends StatefulWidget {
  const CreateLabelSecondCardWidget({
    super.key,
    required this.goodsReceiptPurchaseOrderLineItemEntity,
  });
  final GoodsReceiptPurchaseOrderLineItemEntity
  goodsReceiptPurchaseOrderLineItemEntity;

  @override
  State<CreateLabelSecondCardWidget> createState() =>
      CreateLabelSecondCardWidgetState();
}

class CreateLabelSecondCardWidgetState
    extends State<CreateLabelSecondCardWidget> {
  late TextEditingController _damagedQtyController;

  late TextEditingController _receivedQtyController;

  late TextEditingController _newStockController;

  late TextEditingController _reConditionStockController;

  late TextEditingController _expiryDateController;

  late TextEditingController _batchNameController;

  late TextEditingController _inputSerialNumController;

  late TextEditingController _remarksController;

  String _storageLocation = "";
  int _selectedImdgClass = 0;
  String _selectedQuality = "";

  late GoodsReceiptPurchaseOrderLineItemEntity?
  _goodsReceiptPurchaseOrderLineItemEntity;

  // final GlobalKey<SplitStorageLocationWidgetState>
  // _splitStorageLocationWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _goodsReceiptPurchaseOrderLineItemEntity =
        widget.goodsReceiptPurchaseOrderLineItemEntity;
    context.read<QualityBloc>().add(FetchAllQualityListEvent());
    _damagedQtyController = TextEditingController();

    _receivedQtyController = TextEditingController();

    _newStockController = TextEditingController();

    _reConditionStockController = TextEditingController();

    _expiryDateController = TextEditingController();

    _batchNameController = TextEditingController();

    _inputSerialNumController = TextEditingController();

    _remarksController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /*
     * moved the below code from the build method to here, due to updated values getting reseted
     * while changing the dropdown value of quality and storage location.
     */
    if (context
            .read<GoodsReceiptCreateLabelBloc>()
            .state
            .goodsReceiptPurchaseOrderLineItemEntity!
            .poDtId! >
        0) {
      if (widget.goodsReceiptPurchaseOrderLineItemEntity.damagedOrWrongSupply >
          0) {
        _damagedQtyController.text =
            '${widget.goodsReceiptPurchaseOrderLineItemEntity.damagedOrWrongSupply}';
      }
      if (widget.goodsReceiptPurchaseOrderLineItemEntity.receivedQty > 0) {
        _receivedQtyController.text =
            '${widget.goodsReceiptPurchaseOrderLineItemEntity.receivedQty}';
      }
      if (widget.goodsReceiptPurchaseOrderLineItemEntity.newStock > 0) {
        _newStockController.text =
            '${widget.goodsReceiptPurchaseOrderLineItemEntity.newStock}';
      }
      if (widget.goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock >
          0) {
        _reConditionStockController.text =
            '${widget.goodsReceiptPurchaseOrderLineItemEntity.reconditionedStock}';
      }
      _expiryDateController.text =
          widget.goodsReceiptPurchaseOrderLineItemEntity.expiryDate;
      _batchNameController.text =
          widget.goodsReceiptPurchaseOrderLineItemEntity.batchNo;
      _inputSerialNumController.text =
          widget
              .goodsReceiptPurchaseOrderLineItemEntity
              .articleNo; //R.L GR Label Changes
      _remarksController.text =
          widget.goodsReceiptPurchaseOrderLineItemEntity.remarks;
      _selectedQuality =
          '${widget.goodsReceiptPurchaseOrderLineItemEntity.qualityId}';
      _selectedImdgClass = int.parse(
        '${widget.goodsReceiptPurchaseOrderLineItemEntity.imdgClassId}',
      );
      _storageLocation =
          widget
              .goodsReceiptPurchaseOrderLineItemEntity
              .className; //R.L GR Label Changes
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.goodsReceiptPurchaseOrderLineItemEntity.poDtId! > 0) {
      return AppDecoratedBoxShadowWidget(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //1
              Row(
                children: [
                  //received qty
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.receivedQty,
                      controller: _receivedQtyController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<GoodsReceiptCreateLabelBloc>().add(
                            OnReceivedQtyUpdateEvent(double.parse(value) ?? 0),
                          );
                        }
                      },
                      style: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                      maxLine: 1,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSize.size15),
                  //damage
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.damageWrong,
                      controller: _damagedQtyController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<GoodsReceiptCreateLabelBloc>().add(
                            OnDamagedQtyUpdateEvent(double.parse(value)),
                          );
                        }
                      },
                      style: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                      maxLine: 1,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                ],
              ),
              //2
              SizedBox(height: AppSize.size10),
              Row(
                children: [
                  //new stock
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.newStock,
                      controller: _newStockController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<GoodsReceiptCreateLabelBloc>().add(
                            OnNewStockUpdateEvent(double.parse(value) ?? 0),
                          );
                        }
                      },
                      style: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: AppSize.size15),
                  //recondition
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.reconditionStock,
                      controller: _reConditionStockController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<GoodsReceiptCreateLabelBloc>().add(
                            OnReConditionedStockUpdateEvent(
                              double.parse(value) ?? 0,
                            ),
                          );
                        }
                      },
                      style: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                      maxLine: 1,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                ],
              ),
              //3
              SizedBox(height: AppSize.size10),
              Row(
                children: [
                  //quality
                  Expanded(
                    child: BlocBuilder<QualityBloc, QualityState>(
                      builder: (context, state) {
                        return AppDropDownWidget(
                          labelText: context.l.quality,
                          items:
                              state.fetchQualityList
                                  .map(
                                    (element) => DropdownMenuItem(
                                      value: element.id,
                                      child: Text(element.code),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (selectedQuality) {
                            _selectedQuality = selectedQuality.toString();
                          },
                          // selectedValue:
                          //     locationState.storageLocationEntityList[0].id,
                          filled: true,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: AppSize.size15),
                  //Expiry date
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.expiryDate,
                      suffixIcon: AppSuffixIcon(
                        imagePath: AppIcons.calendarIcon,
                        height: AppSize.size16,
                      ),
                      controller: _expiryDateController,
                      suffixIconConstraints: BoxConstraints(),

                      onTap: () async {
                        final pickedDate = await AppDateUtils.appDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                        );
                        if (pickedDate != null && context.mounted) {
                          String expiryDate =
                              AppDateUtils.getStringFromDateWithFormat(
                                pickedDate,
                                'dd-MMM-yyyy',
                              );
                          _expiryDateController.text = expiryDate;
                          context.read<GoodsReceiptCreateLabelBloc>().add(
                            OnExpiryDateUpdateEvent(expiryDate),
                          );
                        }
                      },
                      readOnly: true,
                      style: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                    ),
                  ),
                ],
              ),
              //batch no
              SizedBox(height: AppSize.size10),
              AppTextFormField(
                labelText: context.l.batchNo,
                controller: _batchNameController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<GoodsReceiptCreateLabelBloc>().add(
                      OnBatchNoUpdateEvent(value),
                    );
                  }
                },
                style: Theme.of(context).textTheme.bodySmall,
                filled: true,
                maxLine: 1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              //input serial no
              SizedBox(height: AppSize.size10),
              AppTextFormFieldWithButtonWidget(
                labelText: context.l.inputSerialNo,
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.borderRadius12,
                ),
                onTap: () {
                  showModalBottomSheet(
                    isDismissible: false,
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
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
                          child: SafeArea(child: SerialNumberWidget()),
                        ),
                      );
                    },
                  );
                },
                buttonWidget: SvgPicture.asset(
                  AppIcons.serialNoIcon,
                  height: AppSize.size20,
                  width: AppSize.size20,
                  colorFilter:
                      context.isDarkMode
                          ? const ColorFilter.mode(
                            AppColor.colorDividerLight,
                            BlendMode.srcIn,
                          )
                          : null,
                ),
                controller: _inputSerialNumController,
                onChanged: (value) {
                  context.read<GoodsReceiptCreateLabelBloc>().add(
                    OnSerialNoUpdateEvent(value),
                  );
                },
                filled: true,
              ),
              SizedBox(height: AppSize.size10),
              //imdg class
              // AppDropDownWidget(
              //   labelText: context.l.imdgClass,
              //   items:
              //       state.fetchImdgClassList
              //           .where((element) => element.isActive == false)
              //           .toList()
              //           .map((item) {
              //             return DropdownMenuItem<ImdgClassEntity>(
              //               value: item,
              //               child: Text(item.typeName),
              //             );
              //           })
              //           .toList(),
              //   onChanged: (selectedImdgClass) {
              //     _selectedImdgClass =
              //         (selectedImdgClass as ImdgClassEntity).id;
              //     context.read<GoodsReceiptCreateLabelBloc>().add(
              //       OnImdgClassIdUpdateEvent(selectedImdgClass),
              //     );

              //   },
              //   selectedValue:
              //       _selectedImdgClass == 0
              //           ? state.fetchImdgClassList.first
              //           : state.fetchImdgClassList
              //               .where(
              //                 (element) => element.id == _selectedImdgClass,
              //               )
              //               .toList()
              //               .first,
              //   filled: true,
              // ),
              //remark
              SizedBox(height: AppSize.size10),
              AppTextFormField(
                labelText: context.l.remarks,
                controller: _remarksController,
                onChanged: (value) {
                  context.read<GoodsReceiptCreateLabelBloc>().add(
                    OnRemarksUpdateEvent(value),
                  );
                },
                style: Theme.of(context).textTheme.bodySmall,
                filled: true,
              ),
              SizedBox(height: AppSize.size10),
              //storage location
              // AppDropDownWidget(
              //   labelText: context.l.defaultStorageLocation,
              //   items:
              //   state.storageLocationEntityList
              //       .map(
              //         (element) =>
              //         DropdownMenuItem<StorageLocationEntity>(
              //           value: element,
              //           child: Text(element.code),
              //         ),
              //   )
              //       .toList(),
              //   onChanged: (selectedStorageLocation) {
              //     _storageLocation =
              //         (selectedStorageLocation as StorageLocationEntity)
              //             .code;
              //     context.read<GoodsReceiptCreateLabelBloc>().add(
              //       OnDefaultStorageLocationEvent(selectedStorageLocation),
              //     );

              //   },
              //   selectedValue:
              //   _storageLocation.isEmpty
              //       ? state.storageLocationEntityList.first
              //       : state.storageLocationEntityList.isNotEmpty
              //       ? state.storageLocationEntityList
              //       .where(
              //         (element) => element.code == _storageLocation,
              //   )
              //       .toList()
              //       .first
              //       : StorageLocationState.initial(),
              //   filled: true,
              // ),
              SizedBox(height: AppSize.size20),
              //Split storage
              // SplitStorageLocationWidget(
              //   key: _splitStorageLocationWidgetKey,
              //   widget.goodsReceiptPurchaseOrderLineItemEntity,
              // ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(height: AppSize.size10);
    }
  }

  TextEditingController get remarksController => _remarksController;

  TextEditingController get inputSerialNumController =>
      _inputSerialNumController;

  TextEditingController get batchNameController => _batchNameController;

  TextEditingController get expiryDateController => _expiryDateController;

  TextEditingController get reConditionStockController =>
      _reConditionStockController;

  TextEditingController get newStockController => _newStockController;

  TextEditingController get receivedQtyController => _receivedQtyController;

  TextEditingController get damagedQtyController => _damagedQtyController;

  GoodsReceiptPurchaseOrderLineItemEntity?
  get goodsReceiptPurchaseOrderLineItemEntity =>
      _goodsReceiptPurchaseOrderLineItemEntity;

  String get qualityId => _selectedQuality;

  String get storageLocation => _storageLocation;

  int get imdgClassId => _selectedImdgClass;

  // GlobalKey<SplitStorageLocationWidgetState>
  // get splitStorageLocationWidgetKey => _splitStorageLocationWidgetKey;
}

// class SplitStorageLocationWidget extends StatefulWidget {
//   SplitStorageLocationWidget(
//     this.goodsReceiptPurchaseOrderLineItemEntity, {
//     required GlobalKey<SplitStorageLocationWidgetState> key,
//   }) : super(key: key);
//
//   GoodsReceiptPurchaseOrderLineItemEntity?
//   goodsReceiptPurchaseOrderLineItemEntity;
//
//   @override
//   State<SplitStorageLocationWidget> createState() =>
//       SplitStorageLocationWidgetState();
// }
//
// class SplitStorageLocationWidgetState
//     extends State<SplitStorageLocationWidget> {
//   List<SplitLocationEntity> _splitStorageLocationEntityList = [];
//
//   List<TextEditingController> _splitStorageLocationTextControllerList = [];
//
//   @override
//   void initState() {
//     _splitStorageLocationTextControllerList = [];
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 context
//                     .loc
//                     .splitStorageLocation, // Make sure loc extension is defined
//                 style: TextStyle(
//                   fontSize: AppFontSize.fontSize16,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: false,
//               child: SizedBox(
//                 height: AppSize.size18,
//                 width: AppSize.size18,
//                 child: InkWell(
//                   child: SvgPicture.asset(
//                     AppIcons.addIcon,
//                     height: AppSize.size18,
//                     width: AppSize.size18,
//                   ),
//                   onHover: (bool hOver) {},
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       showDragHandle: false,
//                       enableDrag: false,
//                       isScrollControlled: true,
//                       builder: (context) {
//                         return SplitStorageLocationBottomBarWidget();
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: AppSize.size20),
//
//         //Damage Qty
//         Row(
//           children: [
//             //Received Qty
//             SizedBox(
//               width: AppSize.size114,
//               child: Text(
//                 context.l.damagedQty,
//                 style: getSplitTextStyle(context),
//               ),
//             ),
//
//             //Storage
//             SizedBox(width: AppSize.size29),
//             Expanded(
//               child: Text(context.l.storage, style: getSplitTextStyle(context)),
//             ),
//             //3 dot
//             SizedBox(
//               height: AppSize.size15,
//               width: AppSize.size15,
//               child: InkWell(
//                 onHover: (bool hOver) {},
//                 onTap: onTapEvent(context, 1),
//                 child: SvgPicture.asset(
//                   AppIcons.burgerIcon,
//                   height: AppSize.size15,
//                   width: AppSize.size15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         BlocBuilder<
//           GoodsReceiptSplitLocationBloc,
//           GoodsReceiptSplitLocationState
//         >(
//           builder: (context, state) {
//             return Column(children: getStorageLocationWidgets(state, 1));
//           },
//         ),
//
//         SizedBox(height: AppSize.size10),
//         Divider(
//           color:
//               context.isDarkMode
//                   ? AppColor.colorDarkDivider
//                   : AppColor.closeButtonColor,
//         ),
//         SizedBox(height: AppSize.size10),
//         //received qty
//         Row(
//           children: [
//             //Received Qty
//             SizedBox(
//               width: AppSize.size114,
//               child: Text(context.l.newQty, style: getSplitTextStyle(context)),
//             ),
//
//             //Storage
//             SizedBox(width: AppSize.size29),
//             Expanded(
//               child: Text(context.l.storage, style: getSplitTextStyle(context)),
//             ),
//             //3 dot
//             SizedBox(
//               height: AppSize.size15,
//               width: AppSize.size15,
//               child: InkWell(
//                 onHover: (bool hOver) {},
//                 onTap: onTapEvent(context, 2),
//                 child: SvgPicture.asset(
//                   AppIcons.burgerIcon,
//                   height: AppSize.size15,
//                   width: AppSize.size15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         SizedBox(height: AppSize.size6),
//         BlocBuilder<
//           GoodsReceiptSplitLocationBloc,
//           GoodsReceiptSplitLocationState
//         >(
//           builder: (context, state) {
//             return Column(children: getStorageLocationWidgets(state, 2));
//           },
//         ),
//         SizedBox(height: AppSize.size10),
//
//         Divider(
//           color:
//               context.isDarkMode
//                   ? AppColor.colorDarkDivider
//                   : AppColor.closeButtonColor,
//         ),
//         SizedBox(height: AppSize.size10),
//         //received qty
//         Row(
//           children: [
//             //Received Qty
//             SizedBox(
//               width: AppSize.size114,
//               child: Text(
//                 context.l.reconditionStock,
//                 style: getSplitTextStyle(context),
//               ),
//             ),
//
//             //Storage
//             SizedBox(width: AppSize.size29),
//             Expanded(
//               child: Text(context.l.storage, style: getSplitTextStyle(context)),
//             ),
//             //3 dot
//             SizedBox(
//               height: AppSize.size15,
//               width: AppSize.size15,
//               child: InkWell(
//                 onHover: (bool hOver) {},
//                 onTap: onTapEvent(context, 3),
//                 child: SvgPicture.asset(
//                   AppIcons.burgerIcon,
//                   height: AppSize.size15,
//                   width: AppSize.size15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: AppSize.size6),
//         BlocBuilder<
//           GoodsReceiptSplitLocationBloc,
//           GoodsReceiptSplitLocationState
//         >(
//           builder: (context, state) {
//             return Column(children: getStorageLocationWidgets(state, 3));
//           },
//         ),
//         SizedBox(height: AppSize.size10),
//       ],
//     );
//   }
//
//   VoidCallback onTapEvent(BuildContext context, int typeId) {
//     return () {
//       showModalBottomSheet(
//         context: context,
//         showDragHandle: false,
//         enableDrag: false,
//         isScrollControlled: true,
//         builder: (context) {
//           return SafeArea(
//             child: AddLocationBottomBarWidget(
//               onTap: () {
//                 if (widget.goodsReceiptPurchaseOrderLineItemEntity != null) {
//                   debugPrint(
//                     'widget.goodsReceiptPurchaseOrderLineItemEntity!.poHdId  : ${widget.goodsReceiptPurchaseOrderLineItemEntity!.poHdId}',
//                   );
//                   debugPrint(
//                     'widget.goodsReceiptPurchaseOrderLineItemEntity!.poDtId  : ${widget.goodsReceiptPurchaseOrderLineItemEntity!.poDtId}',
//                   );
//                   context.read<GoodsReceiptSplitLocationBloc>().add(
//                     AddEmptySplitStorageLocationWidgetEvent(
//                       widget.goodsReceiptPurchaseOrderLineItemEntity!.poHdId!,
//                       widget.goodsReceiptPurchaseOrderLineItemEntity!.poDtId!,
//                       widget.goodsReceiptPurchaseOrderLineItemEntity!.itemId,
//                       typeId,
//                     ),
//                   );
//                 }
//                 context.pop();
//               },
//               iconName: AppIcons.addIcon,
//               buttonName: context.l.add,
//             ),
//           );
//         },
//       );
//     };
//   }
//
//   List<Widget> getStorageLocationWidgets(
//     GoodsReceiptSplitLocationState state,
//     int typeId,
//   ) {
//     List<Widget> storageLocationWidgetList = [];
//     _splitStorageLocationTextControllerList.clear();
//     for (var element in state.splitLocationEntityList) {
//       if (element.typeId == typeId) {
//         TextEditingController textEditingController = TextEditingController(
//           text: '${element.quantity > 0 ? element.quantity : ''}',
//         );
//         try {
//           textEditingController.selection = TextSelection.fromPosition(
//             TextPosition(offset: element.cursorPosition ?? 0),
//           );
//         } catch (e) {}
//         _splitStorageLocationTextControllerList.add(textEditingController);
//         storageLocationWidgetList
//           ..add(SizedBox(height: 7))
//           ..add(
//             ///ToDo
//             CreateLabelItemRowWidget(
//               isEditable: true,
//               splitLocationEntity: element,
//               quantityController: textEditingController,
//               onQuantityControllerChanged: (value) {
//                 if (value.isNotEmpty) {
//                   final cursorPos = textEditingController.selection.baseOffset;
//                   context.read<GoodsReceiptSplitLocationBloc>().add(
//                     OnChangeSplitLocationQuantityEvent(
//                       cursorPosition: cursorPos,
//                       quantity: double.parse(value),
//                       splitLocationEntity: element,
//                     ),
//                   );
//                 }
//               },
//               // goodsReceiptPurchaseOrderLineItemEntity:
//               //     widget.goodsReceiptPurchaseOrderLineItemEntity!,
//               // indexPosition: state.splitLocationEntityList.indexOf(element),
//             ),
//           )
//           ..add(SizedBox(height: 7));
//       }
//     }
//     _splitStorageLocationEntityList = state.splitLocationEntityList;
//     return storageLocationWidgetList;
//   }
//
//   TextStyle? getSplitTextStyle(BuildContext context) {
//     return Theme.of(context).textTheme.titleMedium?.copyWith(
//       color: context.customThemeColor(
//         light: AppColor.colorCommonTextColor,
//         dark: AppColor.colorDividerLight,
//       ),
//     );
//   }
//
//   List<SplitLocationEntity> get splitStorageLocationEntityList =>
//       _splitStorageLocationEntityList;
//
//   List<TextEditingController> get splitStorageLocationTextControllerList =>
//       _splitStorageLocationTextControllerList;
// }
