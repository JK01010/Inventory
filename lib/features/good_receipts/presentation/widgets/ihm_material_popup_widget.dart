import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';
import 'item_size_detail_text_column_widget.dart';
import 'number_of_packets_widget.dart';

class IhmMaterialPopupWidget extends StatelessWidget {
  const IhmMaterialPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: BottomSheetHeaderWidget(title: context.l.ihmMaterial,onTap: () => Navigator.pop(context),),
        ),
        Divider(height: AppSize.size0,color: AppColor.closeButtonColor,),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: packageListValue,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      MaterialQuantityCardWidget(),
                      SizedBox(height: AppSize.size10),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
class MaterialQuantityCardWidget extends StatelessWidget {
  const MaterialQuantityCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDecoratedBoxShadowWidget(
      boxBorder: Border.all(color: AppColor.colorGrey),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //title
            Text(
              "Mercury",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),

            SizedBox(height: AppSize.size16),

            //last change
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ItemsSizeDetailTextColumnWidget(
                    title: context.l.quantity,
                    value: "10",
                  ),
                ),
                SizedBox(
                  width: AppSize.size133,
                  child: ItemsSizeDetailTextColumnWidget(
                    title: context.l.unit,
                    value: "Mg",
                  ),
                ),
                SizedBox(),
              ],
            ),
            SizedBox(height: AppSize.size9),
            //height  Weight
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ItemsSizeDetailTextColumnWidget(
                    title: context.l.lastChanged,
                    value: "22-Aug-2014",
                  ),
                ),
                SizedBox(
                  width: AppSize.size133,
                  child: ItemsSizeDetailTextColumnWidget(
                    title: context.l.createdOn,
                    value: "22-Aug-2014",
                  ),
                ),
                SizedBox(),
              ],
            ),
            SizedBox(height: AppSize.size9),
            //Created by
            ItemsSizeDetailTextColumnWidget(
              title: context.l.createdBy,
              value: "Mariapps Admin",
            ),
          ],
        ),
      ),
    );
  }
}
