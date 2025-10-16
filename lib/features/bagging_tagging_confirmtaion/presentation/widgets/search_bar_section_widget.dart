import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../good_receipts/presentation/storage_location_bloc/storage_location_bloc.dart';
class SearchBarSection<T> extends StatelessWidget {

  const SearchBarSection({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.errorText,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageLocationBloc, StorageLocationState>(
      builder: (context, state) {
        return Container(
      padding: EdgeInsets.only(
        left: AppPadding.padding15,
        right: AppPadding.padding15,
        top: AppPadding.padding22,
      ),
      decoration: ShapeDecoration(
        color:context.customThemeColor(light: AppColor.colorWhite, dark: AppColor.colorDarkProfileContainer),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.borderRadius15),
            topRight: Radius.circular(AppBorderRadius.borderRadius15),
          ),
        ),
      ),
          child: TextFormField(
            // SearchBarSection(
            //   items: state.storageLocationEntityList.map((e) => e.locName).toList(),
            //   onChanged: (value) {
            //     context.read<StorageLocationBloc>().add(
            //       StorageLocationListSearchEvent(searchText: value),
            //     );
            //   },
            // ),

            onChanged: (value) {
              return context.read<StorageLocationBloc>().add(
                StorageLocationListSearchEvent(searchText: value),
              );
              // return context.read<ConsumptionItemUpdateBloc>().add(LocationListSearchEvent(searchText:value));
            },
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color:  context.customThemeColor(light: AppColor.colorTextBlack3, dark: AppColor.colorBlack5)),
              labelStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: context.customThemeColor(light: AppColor.colorTextBlack2, dark: AppColor.colorBackground5)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.colorTextBlack2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.colorPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.colorTextBlack2),
              ),
              suffixIcon:  Padding(
                padding: const EdgeInsets.only(right: AppPadding.padding5),
                child: SvgPicture.asset(
                  AppIcons.greySearchIcon,
                  height: AppSize.size35,
                  width: AppSize.size35,
                  colorFilter: context.isDarkMode
                      ? const ColorFilter.mode(AppColor.colorBlack5, BlendMode.srcIn)
                      : null,
                ),
              ),
              filled: true,
              fillColor: context.isDarkMode?AppColor.colorBGBlack: AppColor.colorWhite,
            ),
          ),
        );
      },
    );
  }
}