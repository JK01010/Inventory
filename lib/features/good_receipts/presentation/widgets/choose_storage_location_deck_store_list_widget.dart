import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_colors.dart';
import 'package:pal_ng_inventory/core/constants/app_icons.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/core/routes/route_name.dart';

import 'package:pal_ng_inventory/features/widgets/common_decorated_bordered_box_shadow_widget.dart';

import '../../../bagging_tagging_confirmtaion/data/model/confirmation_scanning_deck_store_item_options_model.dart';
import '../../../bagging_tagging_confirmtaion/domain/entities/confirmation_scanning_deck_store_model.dart';


class ChooseStorageLocationDeckStoreListWidget extends StatelessWidget {
  final ConfirmationScanningDeckStore item;
  ChooseStorageLocationDeckStoreListWidget({super.key, required this.item});

  final List<ConfirmationScanningDeckStore> deskStoreItems = [
    ConfirmationScanningDeckStore(
        grnNo: '',
        storageLocation: 'Deck Store A',
        isSelected: false,
        deckStoreItemOptionList:[
          ConfirmationScanningDeckStoreItemOptions(
              storageLocation: 'Thermal Boiler Suit L',
              isSelected: false
          ),
          ConfirmationScanningDeckStoreItemOptions(
              storageLocation: 'Shelf A',
              isSelected: false
          ),
          ConfirmationScanningDeckStoreItemOptions(
              storageLocation: 'Shelf B',
              isSelected: false
          ),
          ConfirmationScanningDeckStoreItemOptions(
              storageLocation: 'Shelf C',
              isSelected: false
          ),
          ConfirmationScanningDeckStoreItemOptions(
              storageLocation: 'Shelf D',
              isSelected: false
          )
        ]
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return CommonDecoratedBorderedBoxShadowWidget(
          borderColor: AppColor.colorGrey,
          child: Padding(
              padding: const EdgeInsets.all(AppPadding.padding17),
              child: InkWell(
                onHover: (bool onHOver){},
                onTap: (){
                  context.push(AppRoute.chooseStorageLocationPage.path,extra: {'screenType': ''});
                },
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.folderIcon,
                            height: 21,
                            width: 16),
                            SizedBox(width: AppSize.size8,),
                              Text(item.storageLocation, style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColor.colorBlack
                              )),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right, color: AppColor.colorBlack2),
                    ]),
                  ],
                ),
              )
          )
      );
    },);
  }
}