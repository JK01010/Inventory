import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../good_receipts/presentation/widgets/print_rfid_bottom_button_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/app_two_row_button_widget.dart';
import '../../../widgets/common_view_rfid_viewing_shimmer.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../data/model/rfid_screen_type.dart';
import '../bloc/bagging_tagging_purchase_list/bagging_tagging_purchase_list_bloc.dart';


class ViewRfidListViewing extends StatefulWidget {
  const ViewRfidListViewing({super.key,
    required this.screenType,
    required this.itemId});
  final String screenType;
  final int itemId;

  @override
  State<ViewRfidListViewing> createState() => _ViewRfidListViewingState();
}

class _ViewRfidListViewingState extends State<ViewRfidListViewing> {
  void initState() {
    super.initState();
    context.read<BaggingTaggingPurchaseListBloc>().add(BaggingTaggingRFIDViewEvent(itemId: widget.itemId));
  }
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: BlocBuilder<BaggingTaggingPurchaseListBloc, BaggingTaggingPurchaseListState>(
  builder: (context, state) {
    return Scaffold(
        appBar: CustomAppBar(title: context.l.viewRfid),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.padding15,
                ),
                child: Text(
                  "${state.rfidIds.length.toString().padLeft(2,'0')} ${context.l.numberItems}",
                  style: context.textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: AppSize.size18,
              ),
              // SizedBox(
                Expanded(
                  child: AppDecoratedBoxShadowWidget(
                    child:ListView.separated(
                      padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                      if (state.isLoading) {
                          return CommonViewRfidViewingShimmer();
                        }
                        return  ListingRfidWidget(
                          item: state.rfidIds[index],count:index+1);
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: AppSize.size10),
                      itemCount:
                      state.isLoading ? 10 :state.rfidIds.length,
                    ),
                  ),
                ),
            ],
          ),
        ),

        bottomNavigationBar: widget.screenType == RfidScreenType.itemMaster
          ? PrintRfIdBottomButtonWidget(
            onCancelPress: (){},
            addManuallyOnPress: (){},
            onSecondButtonPress: (){},
            buttonSecondTitle: context.l.scanVerifyRFID,
            selectedItemId: 0
          )
        : AppTwoRowButtonWidget(
          buttonSecondTitle: context.l.scanVerifyRFID,buttonSecondOnPress: (){
            context.push(AppRoute.viewRfidListDetailsPage.path);
        },
        ),
      );
  },
),
    );
  }
}

// class ListingRfidWidget extends StatelessWidget {
//   final String titleText;
//   final String subTitleText;
//   const ListingRfidWidget({super.key, required this.titleText, required this.subTitleText});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(titleText,style: TextStyle(color: AppColor.colorBlack2,fontSize: AppFontSize.fontSize13),),
//             Text(
//               subTitleText,
//               style: context.textTheme.titleMedium?.copyWith(
//                 color: AppColor.colorPrimary,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class ListingRfidWidget extends StatelessWidget {
  const ListingRfidWidget({super.key,required this.item, required this.count});

  final String item;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${context.l.rfid } $count",style: TextStyle(color: AppColor.colorBlack2,fontSize: AppFontSize.fontSize13),),
            Text(item,
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColor.colorPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

