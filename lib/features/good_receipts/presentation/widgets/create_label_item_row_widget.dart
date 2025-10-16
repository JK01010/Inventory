import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/widgets/app_text_form_field.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../domain/entities/goods_receipt_purchase_order_line_item_entity.dart';
import '../../domain/entities/split_location_entity.dart';
import '../goods_receipt_split_location_bloc/goods_receipt_split_location_bloc.dart';
import '../storage_location_bloc/storage_location_bloc.dart';

class CreateLabelItemRowWidget extends StatelessWidget {
  const CreateLabelItemRowWidget({
    super.key,
    required this.splitLocationEntity,
    required this.quantityController,
    // required this.goodsReceiptPurchaseOrderLineItemEntity,
    this.onQuantityControllerChanged,
    this.isEditable = false,
  });

  final SplitLocationEntity splitLocationEntity;
  final TextEditingController quantityController;
  final Function(String)? onQuantityControllerChanged;
  final bool isEditable;

  // final GoodsReceiptPurchaseOrderLineItemEntity
  // goodsReceiptPurchaseOrderLineItemEntity;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const BehindMotion(),
        // A pane can dismiss the Slidable.
        // dismissible: DismissiblePane(onDismissed: () {}),
        extentRatio: 0.2,
        // All actions are defined in the children parameter.
        children: [
          // A Slidable Action can have an icon and/or a label.
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
              onChanged: onQuantityControllerChanged,
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
              onHover: (bool isHover) {},
              onTap:
                  isEditable
                      ? () {
                        context.read<StorageLocationBloc>().add(
                          FetchStorageLocationByParentIdEvent(0, null),
                        );
                        context.push(
                          AppRoute.chooseStorageLocationPage.path,
                          extra: {'screenType': ''},
                        );
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
        ],
      ),
    );
  }
}
