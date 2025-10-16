import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../common_feature/domain/entities/item_category_entity.dart';
import '../../../../widgets/app_two_row_button_widget.dart';
import '../../../../widgets/bottom_sheet_header_widget.dart';
import '../../../../widgets/rounded_check_box_widget.dart';
import '../bloc/purchase_order_filter_bloc/purchase_order_filter_bloc.dart';

class ChooseCategoryPurchaseOrderBottomSheetWidget extends StatelessWidget {
  const ChooseCategoryPurchaseOrderBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: BottomSheetHeaderWidget(
            title: context.l.selectCategory,
            onTap: () {
              context.read<PurchaseOrderFilterBloc>().add(
                ClearCategoryTempFilter(),
              );
              context.pop();
            },
          ),
        ),
        Divider(color: AppColor.closeButtonColor),
        Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: BlocBuilder<PurchaseOrderFilterBloc, PurchaseOrderFilterState>(
            builder: (context, state) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * .40,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.itemCategoryList.length,
                  controller: ScrollController(),
                  itemBuilder: (context, index) {
                    return _CategoryWidget(item: state.itemCategoryList[index]);
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: AppSize.size10),
        AppTwoRowButtonWidget(
          buttonFirstTitle: context.l.clear,
          buttonSecondTitle: context.l.apply,
          buttonFirstOnPress: () {
            context.read<PurchaseOrderFilterBloc>().add(
              ClearCategoryTempFilter(),
            );
          },
          buttonSecondOnPress: () {
            context.read<PurchaseOrderFilterBloc>().add(
              CategoryApplyButtonClick(),
            );

            context.pop();
          },
        ),
      ],
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({required this.item});
  final ItemCategoryEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.padding10,
            right: AppPadding.padding10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(item.categoryName, overflow: TextOverflow.ellipsis),
              ),
              RoundedCheckBoxWidget(
                value: context
                    .read<PurchaseOrderFilterBloc>()
                    .state
                    .tempCategoryList
                    .contains(item),
                onTap: () {
                  context.read<PurchaseOrderFilterBloc>().add(
                    ChangeCategory(categoryEntity: item),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(color: AppColor.colorBlack5),
      ],
    );
  }
}
