import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../profile/presentation/page/profile_screen.dart';
import '../../../theme/theme_bloc.dart';
import '../../../theme/theme_state.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../dashboard_bloc/dashboard_bloc.dart';
import '../widget/dashboard_appbar.dart';
import '../widget/dashboard_grid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<DashboardBloc>().add(FetchAllCommonApi());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return GradientBackground(
          child: BlocConsumer<DashboardBloc, DashboardState>(
            listener: (BuildContext context, DashboardState state) {
              if (state is LogoutSuccess) {
                context.go(AppRoute.login.path);
              }
              if (state is LogoutFailed) {
                showSuccessPopup("Logout failed", context);
              }
            },
            listenWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppSize.size80),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                    child: DashboardAppBar(),
                  ),
                ),
                drawer: SizedBox(
                  width: AppSize.appDrawerWidth,
                  child: Drawer(child: ProfileScreen()),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(AppPadding.scaffoldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: state is DashboardLoading
                            ? _buildShimmerGrid()
                            : DashboardGrid(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.3,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: context.isDarkMode
              ? AppColor.colorDarkProfileContainer
              : AppColor.colorBlack6,
          highlightColor: AppColor.colorIconBackgroundGrey,
          child: Container(
            decoration: ShapeDecoration(
              color: context.isDarkMode
                  ? AppColor.colorDarkProfileContainer
                  : AppColor.colorBlack6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppPadding.padding15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.padding13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 40, height: 40, color: Colors.white),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(width: 60, height: 12, color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
