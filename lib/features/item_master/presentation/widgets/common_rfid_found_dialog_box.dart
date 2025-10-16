import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/app_flat_button.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../bloc/rfid_view_bloc/rfid_view_bloc.dart';


void commonRfidFoundDialog(BuildContext context,List<String> rfidList,int selectedItemId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColor.colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.padding18,
            vertical: AppPadding.padding34,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Message List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rfidList.length, // Replace with the actual number of messages if dynamic
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(
                        "* ${rfidList[index]}", // Replace with dynamic message if needed
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSize14,
                          color: AppColor.colorBlack,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSize.size20),

              Text(
                "Above RfIds is already mapped with other items", // Replace with dynamic message if needed
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppFontSize.fontSize14,
                  color: AppColor.colorBlack,
                ),
              ),

              const SizedBox(height: AppSize.size40),

              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: AppFlatButton(
                      backgroundColor: AppColor.colorWhite,
                      textColor: AppColor.colorPrimary,
                      text: context.l.cancel,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(width: AppSize.size10),
                  Expanded(
                    child: AppFlatButton(
                      backgroundColor: AppColor.colorPrimary,
                      textColor: AppColor.colorWhite,
                      text: context.l.okay,
                      onPressed: () {
                        log("save hit");
                        context.read<ItemMasterBloc>().add(RfidSaveByItemIdEvent(
                          selectedItemId: selectedItemId,
                          rfidList:[]
                        ));
                        context.read<RfidViewBloc>().add(ItemMasterRfidListingFetchEvent(selectedItemId:selectedItemId));
                        // showSuccessPopup("Item Mapped Successfully", context);
                        context.pop();

                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}