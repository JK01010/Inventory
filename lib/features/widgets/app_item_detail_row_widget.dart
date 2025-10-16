import 'package:flutter/material.dart';

import '../../core/constants/app_size.dart';
import '../good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import 'app_title_widget.dart';

class AppItemDetailRowWidget extends StatelessWidget {
  const AppItemDetailRowWidget({
    super.key,
    required this.titleFirst,
    required this.valueFirst,
    required this.titleSecond,
    required this.valueSecond,
    this.viewSlNoWidget,
  });

  final String titleFirst;
  final String valueFirst;
  final String titleSecond;
  final String valueSecond;
  final Widget? viewSlNoWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitleWidget(text: titleFirst),
              viewSlNoWidget != null
                  ? viewSlNoWidget ?? SizedBox()
                  : GoodsReceiptValueWidget(text: valueFirst),
            ],
          ),
        ),
        SizedBox(width: AppSize.size15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitleWidget(text: titleSecond),
              GoodsReceiptValueWidget(text: valueSecond),
            ],
          ),
        ),
      ],
    );
  }
}
