import 'package:flutter/material.dart';

import '../../../../../core/constants/app_size.dart';
import '../../../../widgets/app_title_widget.dart';
import '../../../presentation/widgets/goods_receipt_value_widget.dart';

class ItemDetailRowWidget extends StatelessWidget {
  const ItemDetailRowWidget({
    super.key,
    required this.titleFirst,
    required this.valueFirst,
    required this.titleSecond,
    required this.valueSecond,
  });
  final String titleFirst;
  final String valueFirst;
  final String titleSecond;
  final String valueSecond;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitleWidget(text: titleFirst),
              GoodsReceiptValueWidget(text: valueFirst),
            ],
          ),
        ),
        SizedBox(width: AppSize.size55),
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
