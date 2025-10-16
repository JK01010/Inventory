import 'package:flutter/material.dart';
import '../../../../core/constants/app_size.dart';
import '../../../good_receipts/presentation/widgets/goods_receipt_value_widget.dart';
import '../../../widgets/app_title_widget.dart';

class ItemDetailRow extends StatelessWidget {
  const ItemDetailRow({
    super.key,
    required this.titleFirst,
    required this.valueFirst,
    required this.titleSecond,
    required this.valueSecond, this.spacer,
  }
);
  final String titleFirst;
  final String valueFirst;
  final String titleSecond;
  final String valueSecond;
  final double? spacer;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitleWidget(text: titleFirst),
              GoodsReceiptValueWidget(text: valueFirst),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitleWidget(text: titleSecond),
            GoodsReceiptValueWidget(text: valueSecond),
          ],
        ),
      ],
    );
  }
}
