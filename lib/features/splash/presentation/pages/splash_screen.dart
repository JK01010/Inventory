import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../splash_bloc/bloc/splash_bloc.dart';
import '../splash_bloc/events/splash_event.dart';
import '../splash_bloc/states/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.mounted) {
        context.read<SplashBloc>().add(CheckAuthenticationEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            Theme.of(context).brightness == Brightness.dark
                ? AppColor.kDarkAppBackgroundGradient
                : AppColor.kAppBackgroundGradient,
      ),
      child: GradientBackground(
        child: Scaffold(
          backgroundColor: AppColor.colorTransparent,
          body: SafeArea(
            child: BlocListener<SplashBloc, SplashState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  context.pushReplacement(AppRoute.dashboard.path);
                } else if (state is AuthUnAuthenticated) {
                  context.pushReplacement(AppRoute.login.path);
                }
              },

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: 188,
                        child: Image.asset(
                          // AppAssets.maerskLoginIcon,
                          context.isDarkMode
                              ? AppImage.maerskLogoDark
                              : AppImage.maerskLogoLight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    AppConstant.appName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
