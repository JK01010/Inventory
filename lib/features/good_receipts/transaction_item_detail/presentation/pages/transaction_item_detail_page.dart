import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../../../widgets/split_location_widget.dart';
import '../../../domain/entities/split_location_entity.dart';
import '../../../purchase_order_item_detail/domain/entity/serial_number_entity.dart';
import '../bloc/transaction_item_detail_bloc.dart';
import '../bloc/transaction_item_detail_bloc_event.dart';
import '../bloc/transaction_item_detail_bloc_state.dart';
import '../pages_params/purchase_order_item_detail_page_params.dart';
import '../widgets/transaction_item_detail_bottom_widget.dart';
import '../widgets/transaction_item_detail_header_widget.dart';

class TransactionItemDetailPage extends StatefulWidget {
  const TransactionItemDetailPage({
    super.key,
    required this.transactionItemDetailPageParams,
  });

  final TransactionItemDetailPageParams transactionItemDetailPageParams;

  @override
  State<TransactionItemDetailPage> createState() =>
      _TransactionItemDetailPageState();
}

class _TransactionItemDetailPageState extends State<TransactionItemDetailPage> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      context.read<TransactionItemDetailBloc>().add(
        SetTransactionItemDetailInitialDataEvent(
          transactionEntity:
              widget.transactionItemDetailPageParams.transactionEntity,
          itemEntity: widget.transactionItemDetailPageParams.itemEntity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: BlocBuilder<
        TransactionItemDetailBloc,
        TransactionItemDetailBlocState
      >(
        builder: (context, state) {
          debugPrint("${state.transactionEntity.grnId}");
          if (state.isLoading == true) {
            return GradientBackground(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.colorPrimary,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: CustomAppBar(title: state.itemEntity.productName),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                  child: Column(
                    children: <Widget>[
                      //first card
                      TransactionItemDetailHeaderWidget(),
                      //second card
                      SizedBox(height: AppSize.size15),
                      //Split storage
                      AppDecoratedBoxShadowWidget(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppPadding.scaffoldPadding,
                          ),
                          child: SplitStorageLocationListWidget(
                            onQuantityControllerChanged: (val, split) {},
                            onAddTap: (int typeId) {},
                            splitLocationEntityList: state.splitLocationEntity,
                            onLocationChange: (val, split) {},
                            onSerialNumberTap: (
                              SplitLocationEntity splitLocation,
                              double quantity,
                            ) {
                              context.read<TransactionItemDetailBloc>().add(
                                GenerateSerialNumbersEvent(
                                  splitLocationEntity: splitLocation,
                                  quantity: quantity,
                                ),
                              );
                            },
                            onSerialNumberSaveTap:
                                (
                                  SplitLocationEntity splitLocation,
                                  List<SerialNumberEntity> updatedSerialNumbers,
                                ) {},
                          ),
                        ),
                      ),
                      // //bottom card
                      SizedBox(height: AppSize.size15),
                      TransactionItemDetailBottomWidget(),
                    ],
                  ),
                ),
              ),
              // bottomNavigationBar: Padding(
              //   padding: const EdgeInsets.only(
              //     left: AppPadding.scaffoldPadding,
              //     right: AppPadding.scaffoldPadding,
              //     bottom: AppPadding.scaffoldPadding,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Expanded(
              //         child: AppFlatButton(
              //           backgroundColor: context.customThemeColor(
              //             light: AppColor.colorWhite,
              //             dark: AppColor.colorTransparent,
              //           ),
              //           textColor: AppColor.colorPrimary,
              //           text: context.l.cancel,
              //           onPressed: () {},
              //         ),
              //       ),
              //       SizedBox(width: AppSize.size8),
              //       Expanded(
              //         child: AppFlatButton(
              //           backgroundColor: AppColor.colorPrimary,
              //           textColor: AppColor.colorWhite,
              //           text: context.l.save,
              //           onPressed: onSaveTransactionDetail(),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            );
          }
        },
      ),
    );
  }
}
