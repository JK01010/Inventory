import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../widgets/gradient_background_widget.dart';
import '../../domain/entities/bagging_confirmation_list_entity.dart';
import '../bloc/bagging_tagging_confirmation_search_bloc/bagging_confirmation_search_bloc.dart';
import 'bagging_pending_search_widget.dart';

class BaggingConfirmationSearchPageWidget extends StatefulWidget {
  const BaggingConfirmationSearchPageWidget({super.key});

  @override
  State<BaggingConfirmationSearchPageWidget> createState() =>
      _BaggingConfirmationSearchPageWidgetState();
}

class _BaggingConfirmationSearchPageWidgetState
    extends State<BaggingConfirmationSearchPageWidget>
    with WidgetsBindingObserver {
  Timer? _debounce;
  TextEditingController searchTextController = TextEditingController();

  void _onConfirmationSearchChanged({required String query}) {
    if (query.isEmpty) {
      context.read<BaggingConfirmationSearchBloc>().add(
        BaggingTaggingConfirmationNoChangedEvent(query: ''),
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
      context.read<BaggingConfirmationSearchBloc>().add(
        BaggingTaggingConfirmationNoChangedEvent(query: query),
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    searchTextController.addListener(() {
      _onConfirmationSearchChanged(query: searchTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: BlocBuilder<
          BaggingConfirmationSearchBloc,
          BaggingConfirmationSearchState
        >(
          builder: (context, state) {
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
                                  BaggingConfirmationListEntity
                                >(
                                  itemToString: (p0) => p0.poCode,

                                  items:
                                      state
                                              is BaggingTaggingConfirmationPoSearchLoaded
                                          ? state.baggingConfirmationPoList
                                          : [],
                                  suffixIcon: SpeechToTextMicWidget(),
                                  suggestionsCallback: (search) async {
                                    final lower = search.toLowerCase();
                                    if (state
                                        is BaggingTaggingConfirmationPoSearchLoaded) {
                                      return state.baggingConfirmationPoList
                                          .where((item) {
                                            final String poCode =
                                                (item).poCode.toLowerCase();
                                            final String grnNo =
                                                item.grnNo
                                                    .toString()
                                                    .toLowerCase();
                                            final String poId =
                                                item.poId.toLowerCase();
                                            return poCode.contains(lower) ||
                                                grnNo.contains(lower) ||
                                                poId.contains(lower);
                                          })
                                          .toList();
                                    } else {
                                      return [];
                                    }
                                  },
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColor.colorBlack3,
                                  ),
                                  controller: searchTextController,
                                  onSelected: (data) {
                                    data.syncStatus == 'Synced'
                                        ? showSuccessPopup(
                                          context.l.dataIsAlreadySynced,
                                          context,
                                        )
                                        : context.push(
                                          AppRoute
                                              .baggingTaggingConfirmationScanning
                                              .path,
                                          extra: data.storageLocationId,
                                        );
                                    log("passed grnID 2${ data.storageLocationId}");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (state is BaggingTaggingConfirmationPoSearchLoaded &&
                            state.baggingConfirmationPoList.isEmpty &&
                            state.searchKeyword.length > 2)
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

// class BaggingAppConfirmationSearchWidget<T> extends StatelessWidget {
//   const BaggingAppConfirmationSearchWidget({
//     super.key,
//     this.labelText,
//     this.hintText,
//     this.controller,
//     this.items,
//     required this.itemToString,
//     this.onSelected,
//     this.suffixIcon,
//     this.suffixIconBoxConstraints,
//     this.prefixIcon,
//     this.onChanged,
//   });
//
//   final String? labelText;
//   final String? hintText;
//   final TextEditingController? controller;
//   final List<T>? items;
//   final String Function(T) itemToString;
//   final void Function(T)? onSelected;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final BoxConstraints? suffixIconBoxConstraints;
//   final void Function(String)? onChanged;
//   final FutureOr<List<T>?> Function(String)? suggestionsCallback;
//
//   static final OutlineInputBorder _border = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius30),
//     borderSide: BorderSide(color: AppColor.colorTransparent),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final TextTheme textTheme = Theme.of(context).textTheme;
//     return TypeAheadField<T>(
//       controller: ,
//       decorationBuilder: (context, child) {
//         return Material(
//           color: AppColor.colorTransparent,
//           borderRadius: BorderRadius.all(
//             Radius.circular(AppBorderRadius.borderRadius30),
//           ),
//           child: child,
//         );
//       },
//       suggestionsCallback: (search) {
//         final lower = search.toLowerCase();
//         return items?.where((item) {
//           final String poCode =
//               (item as BaggingConfirmationListEntity).poCode.toLowerCase();
//           final String grnNo = item.grnNo.toString().toLowerCase();
//           final String poId = item.poId.toLowerCase();
//           return poCode.contains(lower) ||
//               grnNo.contains(lower) ||
//               poId.contains(lower);
//         }).toList();
//       },
//       builder: (context, textEditingController, focusNode) {
//         return TextField(
//           controller: textEditingController,
//           focusNode: focusNode,
//           onChanged: onChanged,
//           decoration: InputDecoration(
//             labelText: labelText,
//             hintText: hintText,
//             labelStyle: textTheme.titleMedium,
//             fillColor: AppColor.colorWhite,
//             filled: true,
//             border: _border,
//             enabledBorder: _border,
//             focusedBorder: _border,
//             suffixIcon: suffixIcon,
//             prefixIcon: prefixIcon,
//             suffixIconConstraints: suffixIconBoxConstraints,
//           ),
//         );
//       },
//       itemBuilder: (context, suggestion) {
//         return Padding(
//           padding: const EdgeInsets.all(AppPadding.padding4),
//           child: Row(
//             children: [
//               Icon(Icons.search, color: AppColor.colorBlack3),
//               SizedBox(width: AppSize.size6),
//               Text(
//                 itemToString(suggestion),
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//         );
//       },
//       onSelected: onSelected,
//       emptyBuilder: (context) => const SizedBox.shrink(),
//     );
//   }
// }
