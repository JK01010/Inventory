import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/profile_image_widget.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/profile_name_widget.dart';
import 'package:pal_ng_inventory/features/widgets/gradient_background_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../widgets/app_flat_button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../profile_bloc/profile_bloc.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l.profile),
      body: GradientBackground(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: AppSize.size30),
                ProfileImageWidget(state.profileImage),
                SizedBox(height: AppSize.size10),
                NameWidget(state.userName),
                SizedBox(height: AppSize.size50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l.defaultScanMode,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: AppFontSize.fontSize16,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Row(
                            children: [
                              RoundedCheckBoxWidget(
                                value: state.isRFIDEnabled,
                                onTap: () {
                                  context.read<ProfileBloc>().add(
                                    UpdateRFIDCheckBoxSelectedStatusEvent(
                                      isRFIDSelected: !state.isRFIDEnabled,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: AppSize.size8),
                              Text(
                                context.l.rfid,
                                style: context.textTheme.bodySmall,
                              ),
                            ],
                          ),

                          SizedBox(width: AppSize.size20),
                          Row(
                            children: [
                              RoundedCheckBoxWidget(
                                value: state.isBarCodeEnabled,
                                onTap: () {
                                  context.read<ProfileBloc>().add(
                                    UpdateBarCodeCheckBoxSelectedStatusEvent(
                                      isBarCodeSelected:
                                          !state.isBarCodeEnabled,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: AppSize.size8),
                              Text(
                                context.l.barCodeQRCode,
                                style: context.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(height: 20),
                      // Divider(
                      //   height: AppSize.size2,
                      //   color: AppColor.colorGrey,
                      //   endIndent: AppSize.size10,
                      // ),
                      // SizedBox(height: 20),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: AppPadding.padding15,
                      //     vertical: AppPadding.padding22,
                      //   ),
                      //   decoration: ShapeDecoration(
                      //     color: AppColor.colorWhite,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(AppBorderRadius.borderRadius15),
                      //       ),
                      //     ),
                      //   ),
                      //   child: ProfileDrawerItemsWidget(
                      //     title: AppLocalizations.of(context)?.syncStatus ?? "",
                      //     icon: AppIcons.syncStatusBlueIcon,
                      //     onTap: () {
                      //       context.push(AppRoute.profileSyncStatusPage.path);
                      //     },
                      //     showArrow: false,
                      //     isColorFilterEnabled: false,
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: AppSize.size150,
                  child: AppFlatButton(
                    text: context.l.logout,
                    backgroundColor: AppColor.redColor,
                    textColor: AppColor.colorWhite,
                    onPressed: () {
                      //TODO implement the Logout function
                      context.push(AppRoute.login.path);
                    },
                  ),
                ),
                SizedBox(height: 50),
              ],
            );
          },
        ),
      ),
    );
  }
}
