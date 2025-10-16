import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/app_version_widget.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/log_out_text_widget.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/profile_close_button_widget.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/profile_image_widget.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/profile_name_widget.dart';
import 'package:pal_ng_inventory/features/profile/presentation/widget/scan_mode_widget.dart';
import 'package:pal_ng_inventory/features/widgets/gradient_background_widget.dart';

import '../profile_bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height * 0.5;

    return GradientBackground(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned(
                left: AppSize.size0,
                right: AppSize.size0,
                top:
                    ((height * .14) + kToolbarHeight) -
                    AppSize.profileImageRadius,
                child: Column(
                  children: [
                    ProfileImageWidget(state.profileImage),
                    SizedBox(height: AppSize.size10),
                    NameWidget(state.userName),
                    ScanModeWidget(state),
                  ],
                ),
              ),
              CloseButtonWidget(height: height),
              LogOutTextWidget(),
              AppVersionWidget(),
            ],
          );
        },
      ),
    );
  }
}
