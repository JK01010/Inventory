import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/api_constant.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../page/bagging_tagging_details_page.dart';
import '../../../../core/service/network/test_url.dart';
import 'custom_button.dart';

void showLoginBaseUrlPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: false,
    builder: (context) => LoginBaseUrlWidget(),
  );
}

class LoginBaseUrlWidget extends StatefulWidget {
  const LoginBaseUrlWidget({super.key});

  @override
  State<LoginBaseUrlWidget> createState() => _LoginBaseUrlWidgetState();
}

class _LoginBaseUrlWidgetState extends State<LoginBaseUrlWidget> {
  late final TextEditingController urlController;
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController(text: "https://");
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // <-- This prevents overlap
      ),
      child: Container(
        padding: EdgeInsets.only(top: AppPadding.padding16),
        decoration: ShapeDecoration(
          color: AppColor.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppBorderRadius.borderRadius20),
              topRight: Radius.circular(AppBorderRadius.borderRadius20),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Topbar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.padding21,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.loc.baseURL,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColor.colorBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: AppFontSize.fontSize20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgPicture.asset(AppIcons.closeIcon),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.size13),
            Divider(color: AppColor.closeButtonColor,),
            const SizedBox(height: AppSize.size20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.padding22),
              child:TextField(
                controller: urlController,
                decoration: InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: context.l.url,
                  hintText: context.l.url,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderRadius12,
                    ),
                  ),
                ),
              )
            ),
            const SizedBox(height: AppSize.size41),
            _isLoading?Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(backgroundColor: AppColor.colorWhite,color: AppColor.colorPrimary,),
            ):Container(
              decoration: BoxDecoration(
                color: AppColor.colorBackground,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.colorBoxShadow,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                    spreadRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.padding20,
                vertical: AppPadding.padding18,
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    buttonName: context.loc.close,
                    color: AppColor.colorWhite,
                    onTap: () {
                      context.pop();
                    },
                  ),

                  //TODO This should be removed when apis are complete its done only for demo purpose. remove set state too
                  CustomButton(
                    buttonName: context.loc.test,
                    buttonNameColor: AppColor.colorWhite,
                    onTap: ()async {

                      String? url =urlController?.text;
                      var result = await testVesselURL(url??"");
                      log("Result is $result");
                      if(result){
                        ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           backgroundColor:  AppColor.colorPrimary,
                          content: Text('Test Successful',style: TextStyle(color: AppColor.colorWhite,)),
                          duration: Duration(seconds: 3), // Optional: how long it stays visible
                          action: SnackBarAction(
                            label: 'Okay',
                            textColor:AppColor.colorWhite,
                            onPressed: () {
                            },
                          ),
                        ));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:  AppColor.colorPrimary,
                              content: Text('Test Failed',style: TextStyle(color: AppColor.colorWhite,)),
                              duration: Duration(seconds: 3), // Optional: how long it stays visible
                              action: SnackBarAction(
                                label: 'Okay',
                                textColor:AppColor.colorWhite,
                                onPressed: () {
                                },
                              ),
                            ));
                      }
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
