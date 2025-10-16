import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../domin/entities/consumption_location_entity.dart';
import '../bloc/consumption_item_update_page_bloc/consumption_item_update_bloc.dart';

class LocationList extends StatelessWidget {
  const LocationList({
    super.key,
    required this.locationEntity,
    this.onTap,
    this.showArrow = true,
    required this.index,
  });

  final ConsumptionLocationEntity locationEntity;
  final void Function()? onTap;
  final bool showArrow;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsumptionItemUpdateBloc, ConsumptionItemUpdateState>(
      builder: (context, state) {
        bool isSelected = false;
        isSelected = state.locationListEntity[index].isSelected ?? false;

        return AppDecoratedBoxShadowWidget(
          boxBorder: Border.all(
            color: isSelected ? AppColor.colorPrimary : AppColor.colorGrey,
          ),
          child: InkWell(
            onTap: onTap,
            child: ListTile(
              leading: SvgPicture.asset(
                AppIcons.equipmentIcon,
                colorFilter:
                    context.isDarkMode
                        ? const ColorFilter.mode(
                          AppColor.colorWhite,
                          BlendMode.srcIn,
                        )
                        : null,
              ),
              title: Text(
                locationEntity.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                locationEntity.code,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing:
                  showArrow
                      ? SvgPicture.asset(
                        AppIcons.rightArrowIcon,
                        colorFilter:
                            context.isDarkMode
                                ? const ColorFilter.mode(
                                  AppColor.colorWhite,
                                  BlendMode.srcIn,
                                )
                                : null,
                      )
                      : SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
