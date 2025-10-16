import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_size.dart';
import '../../core/extensions/localization_extension.dart';
import '../../core/extensions/theme_extension.dart';
import '../../core/routes/route_name.dart';
import '../good_receipts/domain/entities/split_location_entity.dart';
import '../good_receipts/presentation/widgets/add_location_bottom_bar_widget.dart';
import '../good_receipts/purchase_order_item_detail/domain/entity/serial_number_entity.dart';
import '../serial_numbers_sheet/presentation/pages/serial_numbers_listing_sheet.dart';
import 'app_text_form_field.dart';

class SplitStorageLocationListWidget extends StatelessWidget {
  const SplitStorageLocationListWidget({
    super.key,
    required this.splitLocationEntityList,
    required this.onQuantityControllerChanged,
    required this.onLocationChange,
    required this.onAddTap,
    this.isEditable = false,
    required this.onSerialNumberTap,
    required this.onSerialNumberSaveTap,
  });

  final List<SplitLocationEntity> splitLocationEntityList;
  final Function(String value, SplitLocationEntity splitLocationData)
  onQuantityControllerChanged;
  final Function(
    Map<String, dynamic> data,
    SplitLocationEntity splitLocationData,
  )
  onLocationChange;
  final Function(int itemTypeId) onAddTap;
  final bool isEditable;
  final Function(SplitLocationEntity splitLocation, double quantity)
  onSerialNumberTap;
  final Function(
    SplitLocationEntity splitLocation,
    List<SerialNumberEntity> updatedSerialNumbers,
  )
  onSerialNumberSaveTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context
                    .l
                    .splitStorageLocation, // Make sure loc extension is defined
                style: TextStyle(
                  fontSize: AppFontSize.fontSize16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSize.size20),
        Row(
          children: [
            //Received Qty
            SizedBox(
              width: AppSize.size114,
              child: Text(
                context.l.damagedQty,
                style: getSplitTextStyle(context),
              ),
            ),

            //Storage
            SizedBox(width: AppSize.size29),
            Expanded(
              child: Text(context.l.storage, style: getSplitTextStyle(context)),
            ),
            //3 dot
            SizedBox(
              height: AppSize.size15,
              width: AppSize.size15,
              child: InkWell(
                onTap:
                    isEditable
                        ? () async {
                          onTapEvent(context, 1);
                        }
                        : null,
                child: SvgPicture.asset(
                  AppIcons.burgerIcon,
                  height: AppSize.size15,
                  width: AppSize.size15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 7),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              splitLocationEntityList
                  .where((element) => element.typeId == 1)
                  .toList()
                  .length,
          itemBuilder: (context, index) {
            TextEditingController textEditingController = TextEditingController(
              text:
                  '${splitLocationEntityList.where((element) => element.typeId == 1).toList()[index].quantity}',
            );
            return SplitLocationWidget(
              quantityController: textEditingController,
              splitLocationEntity:
                  splitLocationEntityList
                      .where((element) => element.typeId == 1)
                      .toList()[index],
              onQuantityControllerChanged: onQuantityControllerChanged,
              onLocationChange: onLocationChange,
              isEditable: isEditable,
              onSerialNumberTap: onSerialNumberTap,
              onSerialNumberSaveTap: onSerialNumberSaveTap,
              allSerialNumbers: splitLocationEntityList.expand((element)=> element.serialNumbers).toList(),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: AppSize.size10);
          },
        ),
        SizedBox(height: 7),
        Row(
          children: [
            //Received Qty
            SizedBox(
              width: AppSize.size114,
              child: Text(
                context.l.newStock,
                style: getSplitTextStyle(context),
              ),
            ),

            //Storage
            SizedBox(width: AppSize.size29),
            Expanded(
              child: Text(context.l.storage, style: getSplitTextStyle(context)),
            ),
            //3 dot
            SizedBox(
              height: AppSize.size15,
              width: AppSize.size15,
              child: InkWell(
                onTap:
                    isEditable
                        ? () async {
                          onTapEvent(context, 2);
                        }
                        : null,
                child: SvgPicture.asset(
                  AppIcons.burgerIcon,
                  height: AppSize.size15,
                  width: AppSize.size15,
                ),
              ),
            ),
          ],
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              splitLocationEntityList
                  .where((element) => element.typeId == 2)
                  .toList()
                  .length,
          itemBuilder: (context, index) {
            TextEditingController textEditingController = TextEditingController(
              text:
                  '${splitLocationEntityList.where((element) => element.typeId == 2).toList()[index].quantity}',
            );
            return SplitLocationWidget(
              quantityController: textEditingController,
              splitLocationEntity:
                  splitLocationEntityList
                      .where((element) => element.typeId == 2)
                      .toList()[index],
              onQuantityControllerChanged: onQuantityControllerChanged,
              onLocationChange: onLocationChange,
              isEditable: isEditable,
              onSerialNumberTap: onSerialNumberTap,
              onSerialNumberSaveTap: onSerialNumberSaveTap,
                allSerialNumbers: splitLocationEntityList.expand((element)=> element.serialNumbers).toList()            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: AppSize.size10);
          },
        ),
        SizedBox(height: 7),
        Row(
          children: [
            //Received Qty
            SizedBox(
              width: AppSize.size114,
              child: Text(
                context.l.reconditioned,
                style: getSplitTextStyle(context),
              ),
            ),

            //Storage
            SizedBox(width: AppSize.size29),
            Expanded(
              child: Text(context.l.storage, style: getSplitTextStyle(context)),
            ),
            //3 dot
            SizedBox(
              height: AppSize.size15,
              width: AppSize.size15,
              child: InkWell(
                onTap:
                    isEditable
                        ? () async {
                          onTapEvent(context, 3);
                        }
                        : null,
                child: SvgPicture.asset(
                  AppIcons.burgerIcon,
                  height: AppSize.size15,
                  width: AppSize.size15,
                ),
              ),
            ),
          ],
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              splitLocationEntityList
                  .where((element) => element.typeId == 3)
                  .toList()
                  .length,
          itemBuilder: (context, index) {
            TextEditingController textEditingController = TextEditingController(
              text:
                  '${splitLocationEntityList.where((element) => element.typeId == 3).toList()[index].quantity}',
            );
            return SplitLocationWidget(
              quantityController: textEditingController,
              splitLocationEntity:
                  splitLocationEntityList
                      .where((element) => element.typeId == 3)
                      .toList()[index],
              onQuantityControllerChanged: onQuantityControllerChanged,
              onLocationChange: onLocationChange,
              isEditable: isEditable,
              onSerialNumberTap: onSerialNumberTap,
              onSerialNumberSaveTap: onSerialNumberSaveTap,
                allSerialNumbers: splitLocationEntityList.expand((element)=> element.serialNumbers).toList()            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: AppSize.size10);
          },
        ),
      ],
    );
  }

  TextStyle? getSplitTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      color: context.customThemeColor(
        light: AppColor.colorCommonTextColor,
        dark: AppColor.colorDividerLight,
      ),
    );
  }

  Future<void> onTapEvent(BuildContext context, int typeId) async {
    debugPrint("inside the on tap 333333333333*****************");
    await showModalBottomSheet(
      context: context,
      showDragHandle: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: AddLocationBottomBarWidget(
            onTap: () {
              debugPrint("inside the on tap 5555555555*****************");
              onAddTap(typeId);
              context.pop();
            },
            iconName: AppIcons.addIcon,
            buttonName: context.l.add,
          ),
        );
      },
    );
  }
}

class SplitLocationWidget extends StatelessWidget {
  const SplitLocationWidget({
    super.key,
    required this.splitLocationEntity,
    required this.quantityController,
    required this.onQuantityControllerChanged,
    required this.onLocationChange,
    this.isEditable = false,
    required this.onSerialNumberTap,
    required this.onSerialNumberSaveTap,
    required this.allSerialNumbers,
  });

  final SplitLocationEntity splitLocationEntity;
  final TextEditingController quantityController;
  final Function(String, SplitLocationEntity) onQuantityControllerChanged;
  final Function(Map<String, dynamic> data, SplitLocationEntity)
  onLocationChange;
  final bool isEditable;
  final Function(SplitLocationEntity splitLocation, double quantity)
  onSerialNumberTap;
  final List<SerialNumberEntity> allSerialNumbers;
  final Function(
    SplitLocationEntity splitLocation,
    List<SerialNumberEntity> updatedSerialNumbers,
  )
  onSerialNumberSaveTap;

  // final GoodsReceiptPurchaseOrderLineItemEntity
  // goodsReceiptPurchaseOrderLineItemEntity;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            padding: EdgeInsets.only(top: 10),
            backgroundColor: AppColor.redColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '',
            onPressed: (BuildContext context) {
              // context.read<GoodsReceiptSplitLocationBloc>().add(
              //   DeleteSplitStorageLocationItemByIdEvent(
              //     splitLocationEntity,
              //     goodsReceiptPurchaseOrderLineItemEntity,
              //   ),
              // );
            },
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: AppSize.size114,
            child: AppTextFormField(
              controller: quantityController,
              onChanged: (val) {
                onQuantityControllerChanged(val, splitLocationEntity);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              keyboardType: TextInputType.number,
              filled: true,
              readOnly: isEditable ? false : true,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(width: AppSize.size29),
          Expanded(
            child: InkWell(
              onTap:
                  isEditable
                      ? () async {
                        // context.read<StorageLocationBloc>().add(
                        //   FetchStorageLocationByParentIdEvent(0, null),
                        // );
                        Map<String, dynamic>? result = await context.push(
                          AppRoute.chooseStorageLocationPage.path,
                          extra: {'screenType': ''},
                        );
                        debugPrint(
                          "result from chooseStorageLocationPage: $result",
                        );
                        if (result != null) {
                          onLocationChange(result, splitLocationEntity);
                        }
                      }
                      : null,
              child: Text(
                splitLocationEntity.locationName.isNotEmpty
                    ? splitLocationEntity.locationName
                    : context.l.chooseStorageLocation,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColor.colorPrimary,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  fontSize: AppFontSize.fontSize14,
                ),
              ),
            ),
          ),
          InkWell(
            onTap:
                splitLocationEntity.serialNumbers.isEmpty ||
                        splitLocationEntity.quantity !=
                            splitLocationEntity.serialNumbers.length
                    ? () {
                      onSerialNumberTap(
                        splitLocationEntity,
                        splitLocationEntity.quantity,
                      );
                    }
                    : () async {
                      final List<SerialNumberEntity>? result =
                          await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,

                            backgroundColor: AppColor.colorWhite,
                            builder: (context) {
                              return SerialNumbersListingSheet(
                                currentSerialNumbers:
                                    splitLocationEntity.serialNumbers,
                                allSerialNumbers: allSerialNumbers,
                              );
                            },
                          );
                      if (result != null && result.isNotEmpty) {
                        onSerialNumberSaveTap(splitLocationEntity, result);
                      }
                    },
            child: SvgPicture.asset(
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
          ),
        ],
      ),
    );
  }
}
