import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import '../../domain/entities/item_rob_details_entity.dart';
import '../goods_receipt_detail_create_label_bloc/goods_receipt_create_label_bloc.dart';
import 'item_size_detail_text_column_widget.dart';
import 'number_of_packets_widget.dart';

class ROBDetailsPopupWidget extends StatelessWidget {
  const ROBDetailsPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoodsReceiptCreateLabelBloc, GoodsReceiptCreateLabelState>(
      builder: (context, state) {
        final items = state.itemRobDetailsList ?? [];

        if (state.isLoading == true) {
          return Center(child: CircularProgressIndicator());
        }

        if (items.isEmpty) {
          return Center(child: Text("No ROB details available"));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
              child: BottomSheetHeaderWidget(
                title: context.l.itemRobDetails,
                onTap: () => Navigator.pop(context),
              ),
            ),
            Divider(height: AppSize.size0, color: AppColor.closeButtonColor),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                itemBuilder: (context, index) {
                  final robDetail = items[index];
                  return Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: MaterialQuantityCardWidget(robDetail: robDetail)),
                      SizedBox(height: AppSize.size10),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class MaterialQuantityCardWidget extends StatelessWidget {
  final ItemRobDetailsEntity robDetail;

  const MaterialQuantityCardWidget({
    super.key,
    required this.robDetail,
  });

  @override
  Widget build(BuildContext context) {
    final _dateFormatter = DateFormat("dd-MM-yyyy"); // or any format you prefer

    String formatDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return '';
      try {
        // Convert "2025-08-29 14:15:51.360957" → DateTime
        final dt = DateTime.parse(dateStr.replaceFirst(' ', 'T'));
        return _dateFormatter.format(dt);
      } catch (_) {
        return '';
      }
    }
    return AppDecoratedBoxShadowWidget(
      boxBorder: Border.all(color: AppColor.colorGrey),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Item ID: ${robDetail.itemId}",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),

            SizedBox(height: AppSize.size16),
            // Storage Location
            ItemsSizeDetailTextColumnWidget(
              title: context.l.storageLocation,
              value: robDetail.storageLocation ?? "-",
            ),
            SizedBox(height: AppSize.size9),

            // Storage Location Hierarchy
            ItemsSizeDetailTextColumnWidget(
              title: context.l.storageLocationHierarchy,
              value: robDetail.storageLocationHierarchy ?? "-",
            ),
            SizedBox(height: AppSize.size9),

            // Inventory Date
            ItemsSizeDetailTextColumnWidget(
              title: context.l.inventoryDate,
                value: formatDate(robDetail.inventoryDate),
                 // format later if DateTime
            ),
            SizedBox(height: AppSize.size9),

            // Expiry Date
            ItemsSizeDetailTextColumnWidget(
              title: context.l.expiryDate,
              value: formatDate(robDetail.expiryDate),

            ),
          ],
        ),
      ),
    );
  }
}
