import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_size.dart';
import '../../../../../core/routes/route_name.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';
import 'transaction_card_widget.dart';

class TransactionBodyWidget extends StatelessWidget {
  const TransactionBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: state.transactionEntityList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                // context.read<GoodsReceiptsTransactionBloc>().add(
                //   ChangeSelectionMode(value: true),
                // );
                // context.read<GoodsReceiptsTransactionBloc>().add(
                //   AddToSyncList(
                //     transactionEntityItem: state.transactionEntity[index],
                //   ),
                // );
              },

              onTap: () {
                context.push(
                  AppRoute.transactionDetailPage.path,
                  extra: state.transactionEntityList[index],
                );
              },
              child: TransactionCardWidget(
                transactionEntity: state.transactionEntityList[index],
                isLoading: state.isLoading,
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
