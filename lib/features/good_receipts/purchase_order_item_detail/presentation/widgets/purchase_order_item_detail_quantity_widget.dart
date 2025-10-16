import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../core/utils/app_date_utils.dart';
import '../../../../common_feature/domain/entities/fetch_imdg_class_entity.dart';
import '../../../../common_feature/domain/entities/item_entity.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_dropdown_widget.dart';
import '../../../../widgets/app_suffix_icon.dart';
import '../../../../widgets/app_text_field_with_button_widget.dart';
import '../../../../widgets/app_text_form_field.dart';
import '../../../../widgets/split_location_widget.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../presentation/quality_bloc/quality_bloc.dart';
import '../../../presentation/widgets/serial_number_widget.dart';
import '../../domain/entity/serial_number_entity.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc_event.dart';
import '../purchase_order_detail_bloc/purchase_order_item_detail_bloc_state.dart';

class PurchaseOrderItemDetailQuantityWidget extends StatefulWidget {
  const PurchaseOrderItemDetailQuantityWidget({super.key});

  @override
  State<PurchaseOrderItemDetailQuantityWidget> createState() =>
      _PurchaseOrderItemDetailQuantityWidgetState();
}

class _PurchaseOrderItemDetailQuantityWidgetState
    extends State<PurchaseOrderItemDetailQuantityWidget> {
  final TextEditingController _damagedQtyController = TextEditingController();

  final TextEditingController _receivedQtyController = TextEditingController();

  final TextEditingController _newStockController = TextEditingController();

  final TextEditingController _reConditionStockController =
      TextEditingController();

  final TextEditingController _expiryDateController = TextEditingController();

  final TextEditingController _batchNameController = TextEditingController();

  final TextEditingController _inputSerialNumController =
      TextEditingController();

  final TextEditingController _remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      PurchaseOrderItemDetailBloc,
      PurchaseOrderItemDetailBlocState
    >(
      builder: (context, state) {
        setControllersValues(state.itemEntity);
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
                            context.read<PurchaseOrderItemDetailBloc>().add(
                              PurchaseOrderItemDetailTextFieldChangeEvent(
                                newValue: value,
                                purchaseOrderItemDetailTextFieldType:
                                    PurchaseOrderItemDetailTextFieldType
                                        .receivedQty,
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
                            context.read<PurchaseOrderItemDetailBloc>().add(
                              PurchaseOrderItemDetailTextFieldChangeEvent(
                                newValue: value,
                                purchaseOrderItemDetailTextFieldType:
                                    PurchaseOrderItemDetailTextFieldType
                                        .damagedQty,
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
                            context.read<PurchaseOrderItemDetailBloc>().add(
                              PurchaseOrderItemDetailTextFieldChangeEvent(
                                newValue: value,
                                purchaseOrderItemDetailTextFieldType:
                                    PurchaseOrderItemDetailTextFieldType
                                        .newStockQty,
                              ),
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
                            context.read<PurchaseOrderItemDetailBloc>().add(
                              PurchaseOrderItemDetailTextFieldChangeEvent(
                                newValue: value,
                                purchaseOrderItemDetailTextFieldType:
                                    PurchaseOrderItemDetailTextFieldType
                                        .reconditionedQty,
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
                        builder: (context, qualityState) {
                          return AppDropDownWidget(
                            labelText: context.l.quality,
                            items:
                                qualityState.fetchQualityList
                                    .map(
                                      (element) => DropdownMenuItem(
                                        value: element.id,
                                        child: Text(element.qualityName),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (selectedQuality) {
                              if (selectedQuality != null) {
                                context.read<PurchaseOrderItemDetailBloc>().add(
                                  PurchaseOrderItemQualityChangeEvent(
                                    newQuality: selectedQuality,
                                  ),
                                );
                              }
                            },
                            selectedValue:
                                state.itemEntity.qualityId == -1
                                    ? null
                                    : state.itemEntity.qualityId,
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
                            debugPrint("expiryDate : $expiryDate");
                            context.read<PurchaseOrderItemDetailBloc>().add(
                              PurchaseOrderItemDetailTextFieldChangeEvent(
                                newValue: expiryDate,
                                purchaseOrderItemDetailTextFieldType:
                                    PurchaseOrderItemDetailTextFieldType
                                        .expiryDate,
                              ),
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
                      // context.read<GoodsReceiptCreateLabelBloc>().add(
                      //   OnBatchNoUpdateEvent(value),
                      // );
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
                    // context.read<GoodsReceiptCreateLabelBloc>().add(
                    //   OnSerialNoUpdateEvent(value),
                    // );
                  },
                  filled: true,
                ),
                SizedBox(height: AppSize.size10),
                //imdg class
                AppDropDownWidget(
                  labelText: context.l.imdgClass,
                  items:
                      state.imdgClassList
                          .where((element) => element.isActive == true)
                          .toList()
                          .map((item) {
                            return DropdownMenuItem<ImdgClassEntity>(
                              value: item,
                              child: Text(item.typeName),
                            );
                          })
                          .toList(),
                  onChanged: (selectedImdgClass) {
                    if (selectedImdgClass != null) {
                      context.read<PurchaseOrderItemDetailBloc>().add(
                        PurchaseOrderItemImdgClassChangeEvent(
                          imdgClassEntity: selectedImdgClass,
                        ),
                      );
                    }
                  },
                  selectedValue:
                      state.itemEntity.imdgClass.isNotEmpty
                          ? state.imdgClassList.firstWhereOrNull(
                            (element) =>
                                element.code == state.itemEntity.imdgClass,
                          )
                          : null,
                  filled: true,
                ),
                //remark
                SizedBox(height: AppSize.size10),
                AppTextFormField(
                  labelText: context.l.remarks,
                  controller: _remarksController,
                  onChanged: (value) {
                    context.read<PurchaseOrderItemDetailBloc>().add(
                      PurchaseOrderItemDetailTextFieldChangeEvent(
                        newValue: value,
                        purchaseOrderItemDetailTextFieldType:
                            PurchaseOrderItemDetailTextFieldType.remarks,
                      ),
                    );
                    // context.read<GoodsReceiptCreateLabelBloc>().add(
                    //   OnRemarksUpdateEvent(value),
                    // );
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
                SplitStorageLocationListWidget(
                  splitLocationEntityList: state.splitLocationEntity,
                  onQuantityControllerChanged: (
                    controllerValue,
                    splitLocationData,
                  ) {
                    if (controllerValue.isNotEmpty) {
                      context.read<PurchaseOrderItemDetailBloc>().add(
                        SplitLocationQuantityChangeEvent(
                          newQuantity: controllerValue,
                          splitLocationEntity: splitLocationData,
                        ),
                      );
                    }
                  },
                  onAddTap: (int itemTypeId) {
                    context.read<PurchaseOrderItemDetailBloc>().add(
                      AddSplitLocationEvent(itemTypeId: itemTypeId),
                    );
                  },
                  onLocationChange: (
                    Map<String, dynamic> data,
                    SplitLocationEntity splitLocationData,
                  ) {
                    context.read<PurchaseOrderItemDetailBloc>().add(
                      SplitLocationChangeEvent(
                        data: data,
                        splitLocationEntity: splitLocationData,
                      ),
                    );
                  },
                  isEditable: true,
                  onSerialNumberTap: (
                    SplitLocationEntity splitLocationEntity,
                    double quantity,
                  ) {
                    context.read<PurchaseOrderItemDetailBloc>().add(
                      GenerateSerialNumbersEvent(
                        splitLocationEntity: splitLocationEntity,
                        quantity: quantity,
                      ),
                    );
                  },
                  onSerialNumberSaveTap: (
                    SplitLocationEntity splitLocation,
                    List<SerialNumberEntity> updatedSerialNumbers,
                  ) {
                    context.read<PurchaseOrderItemDetailBloc>().add(
                      SaveSerialNumbersEvent(
                        splitLocationEntity: splitLocation,
                        updatedSerialNumbers: updatedSerialNumbers,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setControllersValues(ItemEntity itemEntity) {
    _receivedQtyController.text =
        itemEntity.receivedQuantity == -1
            ? ''
            : itemEntity.receivedQuantity.toString();
    _damagedQtyController.text =
        itemEntity.damagedQuantity == -1
            ? ''
            : itemEntity.damagedQuantity.toString();
    _newStockController.text =
        itemEntity.newStockQuantity == -1
            ? ''
            : itemEntity.newStockQuantity.toString();
    _reConditionStockController.text =
        itemEntity.reconditionedStock == -1
            ? ''
            : itemEntity.reconditionedStock.toString();

    _expiryDateController.text = itemEntity.expiryDate;
    _remarksController.text = itemEntity.remarks;
  }
}
