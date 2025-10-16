import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/text_theme_extension.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../../transaction/domain/entity/transaction_entity.dart';
import '../../../transaction_item_detail/presentation/pages_params/purchase_order_item_detail_page_params.dart';
import '../bloc/transaction_detail_bloc.dart';
import '../bloc/transaction_detail_bloc_event.dart';
import '../bloc/transaction_detail_bloc_state.dart';
import '../widgets/transaction_detail_item_card.dart';
import '../widgets/transaction_details_shimmer.dart';

class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({super.key, required this.transactionEntity});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
  final TransactionEntity transactionEntity;
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      context.read<TransactionDetailBloc>().add(
        GetTransactionItemsEvent(transactionEntity: widget.transactionEntity),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionDetailBloc, TransactionDetailBlocState>(
      builder: (context, state) {
        return GradientBackground(
          child: Scaffold(
            appBar: CustomAppBar(title: state.transactionEntity.poNo),
            body: Padding(
              padding: EdgeInsets.all(AppPadding.scaffoldPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.scaffoldPadding,
                    ),
                    child: Text(
                      "${state.transactionItems.length} Item(s)",
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: AppSize.size20),
                  state.isLoading
                      ? Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TransactionDetailsShimmer();
                          },
                          itemCount: 3,
                          separatorBuilder:
                              (context, index) =>
                                  SizedBox(height: AppSize.size10),
                        ),
                      )
                      : Expanded(
                        child: ListView.separated(
                          itemCount: state.transactionItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.push(
                                  AppRoute.transactionItemDetailPage.path,
                                  extra: TransactionItemDetailPageParams(
                                    transactionEntity: state.transactionEntity,
                                    itemEntity: state.transactionItems[index],
                                  ),
                                );
                              },
                              child: TransactionDetailItemCardWidget(
                                itemEntity: state.transactionItems[index],
                              ),
                            );
                          },
                          separatorBuilder:
                              (context, index) =>
                                  SizedBox(height: AppSize.size10),
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
