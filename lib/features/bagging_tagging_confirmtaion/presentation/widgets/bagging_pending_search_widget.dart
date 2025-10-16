import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../domain/entities/pending_list_model.dart';
import '../bloc/bagging_tagging_pending_search_bloc/bagging_pending_search_bloc.dart';

class BaggingPendingSearchWidget extends StatefulWidget {
  const BaggingPendingSearchWidget({super.key});

  @override
  State<BaggingPendingSearchWidget> createState() =>
      _BaggingPendingSearchWidgetState();
}

class _BaggingPendingSearchWidgetState extends State<BaggingPendingSearchWidget>
    with WidgetsBindingObserver {
  Timer? _debounce;
  final TextEditingController searchTextController = TextEditingController();

  void _onSearchChanged({required String query}) {
    if (query.isEmpty) {
      context.read<BaggingPendingSearchBloc>().add(
        BaggingTaggingPendingNoChangedEvent(query: ''),
      );
      return;
    }
    if (query.length <= 2) {
      return;
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<BaggingPendingSearchBloc>().add(
        BaggingTaggingPendingNoChangedEvent(query: query),
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    searchTextController.addListener(() {
      _onSearchChanged(query: searchTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: BlocBuilder<BaggingPendingSearchBloc, BaggingPendingSearchState>(
          builder: (context, state) {
            state is BaggingTaggingPendingPoSearchLoaded;
            return Scaffold(
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Icon(Icons.arrow_back_ios),
                            ),
                            Expanded(
                              child: AppDecoratedBoxShadowWidget(
                                borderRadius: AppBorderRadius.borderRadius30,
                                child: AppSearchWidget<
                                  BaggingTaggingPendingEntity
                                >(
                                  itemToString: (p0) => p0.poCode,
                                  items:
                                      state is BaggingTaggingPendingPoSearchLoaded
                                          ? state.baggingPendingPoList
                                          : [],
                                  suffixIcon: SpeechToTextMicWidget(),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color:
                                        context.isDarkMode
                                            ? AppColor.colorWhite
                                            : AppColor.colorBlack3,
                                  ),
                                  controller: searchTextController,
                                  onSelected: (data) {
                                    // context.push(
                                    //   AppRoute.baggingPendingSearch.path,
                                    //   extra: {"selectedPOIndex": 1},
                                    // );
                                    context.push(
                                      AppRoute.baggingTaggingDetails.path,
                                      extra: data,
                                    );
                                  },
                                  suggestionsCallback: (search) async {
                                    final lower = search.toLowerCase();
                                    if (state
                                        is BaggingTaggingPendingPoSearchLoaded) {
                                      return state.baggingPendingPoList.where((
                                        item,
                                      ) {
                                        final String poCode =
                                            (item).poCode.toLowerCase();
                                        final String grnNo =
                                            item.grnNo.toString().toLowerCase();
                                        final String poId =
                                            item.poId.toLowerCase();
                                        return poCode.contains(lower) ||
                                            grnNo.contains(lower) ||
                                            poId.contains(lower);
                                      }).toList();
                                    } else {
                                      return [];
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (state is BaggingTaggingPendingPoSearchLoaded &&
                            state.baggingPendingPoList.isEmpty)
                          commonNoDataFound(context),
                      ],
                    ),
                  ),

                  ///widget for showing microphone interaction
                  SpeechToTextListeningWidget(
                    textEditingController: searchTextController,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppSearchWidget<T> extends StatelessWidget {
  const AppSearchWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.items,
    required this.itemToString,
    this.onSelected,
    this.suffixIcon,
    this.suffixIconBoxConstraints,
    this.prefixIcon,
    this.onChanged,
    required this.suggestionsCallback,
  });

  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final List<T>? items;
  final String Function(T) itemToString;
  final void Function(T)? onSelected;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? suffixIconBoxConstraints;
  final void Function(String)? onChanged;
  final Future<List<T>> Function(String) suggestionsCallback;

  static final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius30),
    borderSide: BorderSide(color: AppColor.colorTransparent),
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TypeAheadField<T>(
      controller: controller,
      decorationBuilder: (context, child) {
        return Material(
          color: AppColor.colorTransparent,
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.borderRadius30),
          ),
          child: child,
        );
      },
      suggestionsCallback: suggestionsCallback,
      builder: (context, textEditingController, focusNode) {
        return TextField(
          autofocus: true,
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle: textTheme.titleMedium,
            fillColor:
                context.isDarkMode
                    ? AppColor.colorDarkProfileContainer
                    : AppColor.colorWhite,
            filled: true,
            border: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            suffixIconConstraints: suffixIconBoxConstraints,
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return Padding(
          padding: const EdgeInsets.all(AppPadding.padding4),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color:
                    context.isDarkMode
                        ? AppColor.colorWhite
                        : AppColor.colorBlack3,
              ),
              SizedBox(width: AppSize.size6),
              Text(
                itemToString(suggestion),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        );
      },
      onSelected: onSelected,
      emptyBuilder: (context) => const SizedBox.shrink(),
    );
  }
}
