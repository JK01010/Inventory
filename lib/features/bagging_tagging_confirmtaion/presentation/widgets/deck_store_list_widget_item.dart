import 'package:flutter/material.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';

import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/domain/entities/confirmation_scanning_deck_store_model.dart';



import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/presentation/widgets/custom_checkbox.dart';
import 'package:pal_ng_inventory/features/widgets/common_decorated_bordered_box_shadow_widget.dart';

import '../../data/model/confirmation_scanning_deck_store_item_options_model.dart';

bool isDeckStoreExpanded = false;

class ConfirmScanningCard extends StatelessWidget {
  final ConfirmationScanningDeckStore item;
  const ConfirmScanningCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return CommonDecoratedBorderedBoxShadowWidget(
          borderColor: item.isSelected?AppColor.colorPrimary:AppColor.colorWhite,
          child: Padding(
              padding: const EdgeInsets.all(AppPadding.padding12),
              child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isDeckStoreExpanded = !isDeckStoreExpanded;
                        },);
                      },
                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomCheckButton(
                                    checkBoxName: '',
                                    enableButton: item.isSelected,
                                    onItemUpdate: (bool newValue) {
                                      setState((){
                                        item.isSelected = newValue;
                                      });
                                      onDeckStoreItemSelected(item, newValue, setState); // Passing item, value, setState
                                    }
                                ),
                                SizedBox(width: AppSize.size4,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.storageLocation, style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: AppColor.colorBlack
                                    )),
                                    SizedBox(height: AppSize.size4,),
                                    Text(item.grnNo, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: AppColor.colorBlack2
                                    ))
                                  ],
                                ),
                                Spacer(),
                                Icon(isDeckStoreExpanded?Icons.keyboard_arrow_up : Icons.keyboard_arrow_right, color: AppColor.colorBlack2),
                              ]),
                          if(isDeckStoreExpanded)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSize.size4),
                              child:
                              Column(children:
                              getDeckStoreItem(context, item.deckStoreItemOptionList, setState)
                              ),
                            )
                        ],
                      ),
              )
          )
      );
    },);
  }

  List<Widget> getDeckStoreItem(BuildContext context, List<ConfirmationScanningDeckStoreItemOptions> deckStoreItemOptionList, setState){
    List<Widget> columnList = [];
    for (var element in deckStoreItemOptionList) {
      columnList..add(SizedBox(height: AppSize.size10,))
      ..add(CommonDecoratedBorderedBoxShadowWidget(
        borderColor: element.isSelected ? AppColor.colorPrimary : AppColor.colorGrey,
        child: Padding(padding: const EdgeInsets.all(AppPadding.padding12),
          child: Row(
            children: [
              CustomCheckButton(
                  checkBoxName: '',
                  enableButton: element.isSelected,
                  onItemUpdate:  (bool newValue) {
                    setState((){
                      element.isSelected = newValue;
                    });
                    onDeckStoreItemOptionsSelected(element, newValue, setState); // Passing item, value, setState
              }),
              SizedBox(width: AppSize.size4,),
              Text(element.storageLocation, style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColor.colorBlack
              )),
            ],
          ),
        ),
      ));
    }
    return columnList;
  }

  void onDeckStoreItemSelected(ConfirmationScanningDeckStore deckItem, bool value, setState){
    setState((){
      deckItem.isSelected = value;
    });
  }

  void onDeckStoreItemOptionsSelected(ConfirmationScanningDeckStoreItemOptions deckItemOption, bool value, setState){
    setState((){
      deckItemOption.isSelected = value;
    });
  }
}