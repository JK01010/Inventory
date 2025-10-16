import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/text_theme_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../profile_bloc/profile_bloc.dart';
import 'profile_drawer_item_widget.dart';

class ScanModeWidget extends StatelessWidget {
  const ScanModeWidget(this.profileState, {super.key});

  final ProfileState profileState;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
        child: AppDecoratedBoxShadowWidget(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.padding15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProfileDrawerItemsWidget(
                  title:
                      profileState.userEmail.isEmpty
                          ? 'mariappuser@mariapps.com'
                          : profileState.userEmail,
                  icon: AppIcons.mailIcon,
                  isColorFilterEnabled: true,
                ),
                ProfileDividerWidget(),
                ProfileDrawerItemsWidget(
                  title: AppLocalizations.of(context)?.darkMode ?? "",
                  icon: AppIcons.darkMoonIcon,
                  switchButton: true,
                  padding: AppPadding.padding2,
                  isColorFilterEnabled: true,
                ),
                // ProfileDividerWidget(),
                //
                // ProfileDrawerItemsWidget(
                //   title: AppLocalizations.of(context)?.syncStatus ?? "",
                //   icon: AppIcons.syncStatusIcon,
                //   onTap: () {
                //     context.push(AppRoute.profileSyncStatusPage.path);
                //   },
                //   showArrow: true,
                //   isColorFilterEnabled: true,
                // ),
                ProfileDividerWidget(),
                Text(
                  context.l.defaultScanMode,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: AppFontSize.fontSize16,
                  ),
                ),
                SizedBox(height: AppSize.size10),
                Row(
                  children: [
                    Row(
                      children: [
                        RoundedCheckBoxWidget(
                          value: profileState.isRFIDEnabled,
                          onTap: () {
                            context.read<ProfileBloc>().add(
                              UpdateRFIDCheckBoxSelectedStatusEvent(
                                isRFIDSelected: !profileState.isRFIDEnabled,
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
                          value: profileState.isBarCodeEnabled,
                          onTap: () {
                            context.read<ProfileBloc>().add(
                              UpdateBarCodeCheckBoxSelectedStatusEvent(
                                isBarCodeSelected:
                                    !profileState.isBarCodeEnabled,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDividerWidget extends StatelessWidget {
  const ProfileDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.size6, bottom: AppSize.size6),
      child: Divider(
        color: context.customThemeColor(
          light: AppColor.colorDividerLight,
          dark: AppColor.colorDividerDark,
        ),
      ),
    );
  }
}
