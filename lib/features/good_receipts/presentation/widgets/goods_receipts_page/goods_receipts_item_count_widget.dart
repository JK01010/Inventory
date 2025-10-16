import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../purchase_order/domain/entity/purchase_order_entity.dart';
import '../../../purchase_order/presentation/bloc/purchase_order_bloc/purchase_order_bloc.dart';
import '../../../transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';

class ItemCountWidget extends StatelessWidget {
  const ItemCountWidget({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (_, _) {
        return _tabController.index == 0
            ? BlocSelector<
              PurchaseOrderBloc,
              PurchaseOrderState,
              List<PurchaseOrderEntity>
            >(
              selector: (state) {
                return state.purchaseOrderEntityList;
              },
              builder: (context, state) {
                return Text(
                  "${state.length} item(s)",
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            )
            : BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                return Text(
                  "${state.transactionEntityList.length} item(s)",
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            );
      },
    );
  }
}
