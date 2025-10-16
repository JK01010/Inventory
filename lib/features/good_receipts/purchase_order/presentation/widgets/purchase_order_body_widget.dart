import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_size.dart';
import '../../../../../core/routes/route_name.dart';
import '../bloc/purchase_order_bloc/purchase_order_bloc.dart';
import 'purchase_order_card_widget.dart';
import 'purchase_order_shimmer_widget.dart';

class PurchaseOrderBodyWidget extends StatelessWidget {
  const PurchaseOrderBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseOrderBloc, PurchaseOrderState>(

      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: state.isLoading ? 4 : state.purchaseOrderEntityList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.push(
                  AppRoute.purchaseOrderDetailPage.path,
                  extra: state.purchaseOrderEntityList[index],
                );
              },
              child:
                  state.isLoading
                      ? PurchaseOrderShimmerWidget()
                      : PurchaseOrderCardWidget(
                        purchaseOrderEntity:
                            state.purchaseOrderEntityList[index],
                      ),
            );
          },
          separatorBuilder:
              (context, index) => SizedBox(height: AppSize.size10),
        );
      },
    );
  }
}
