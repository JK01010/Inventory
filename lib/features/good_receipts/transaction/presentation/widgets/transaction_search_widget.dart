import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../../bagging_tagging_confirmtaion/presentation/widgets/bagging_pending_search_widget.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../domain/entity/transaction_entity.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';
import '../bloc/transaction_search_bloc/transaction_search_bloc.dart';

class TransactionSearchWidget extends StatefulWidget {
  const TransactionSearchWidget({super.key});

  @override
  State<TransactionSearchWidget> createState() =>
      _TransactionSearchWidgetState();
}

class _TransactionSearchWidgetState extends State<TransactionSearchWidget>
    with WidgetsBindingObserver {
  Timer? _debounce;
  TextEditingController searchTextController = TextEditingController();

  void _onSearchChanged({required String query}) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<TransactionSearchBloc>().add(
        TransactionOnChangedEvent(query: query),
      );
    });
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
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: BlocBuilder<TransactionSearchBloc, TransactionSearchState>(
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
                            BlocBuilder<
                              TransactionSearchBloc,
                              TransactionSearchState
                            >(
                              builder: (context, state) {
                                return Expanded(
                                  child: AppDecoratedBoxShadowWidget(
                                    borderRadius:
                                        AppBorderRadius.borderRadius30,
                                    child: AppSearchWidget<TransactionEntity>(
                                      itemToString: (p0) => p0.poNo,
                                      items:
                                          state is TransactionSearchLoaded
                                              ? state.transactionList
                                              : [],
                                      suggestionsCallback: (search) async {
                                        if (state is TransactionSearchLoaded) {
                                          return state.transactionList
                                              .where(
                                                (item) => item.poNo
                                                    .toLowerCase()
                                                    .contains(
                                                      search.toLowerCase(),
                                                    ),
                                              )
                                              .toList();
                                        } else {
                                          return [];
                                        }
                                      },
                                      suffixIcon: SpeechToTextMicWidget(),
                                      controller: searchTextController,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: AppColor.colorBlack3,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        if (state is TransactionSearchLoaded &&
                            state.transactionList.isEmpty)
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

class AppTransactionSearchWidget<T> extends StatelessWidget {
  const AppTransactionSearchWidget({
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

  static final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius30),
    borderSide: BorderSide(color: AppColor.colorTransparent),
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TypeAheadField<T>(
      decorationBuilder: (context, child) {
        return Material(
          color: AppColor.colorTransparent,
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.borderRadius30),
          ),
          child: child,
        );
      },
      suggestionsCallback: (search) {
        return items
            ?.where(
              (item) => itemToString(
                item,
              ).toLowerCase().contains(search.toLowerCase()),
            )
            .toList();
      },
      builder: (context, textEditingController, focusNode) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle: textTheme.titleMedium,
            fillColor: AppColor.colorWhite,
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
              Icon(Icons.search, color: AppColor.colorBlack3),
              SizedBox(width: AppSize.size6),
              Text(
                itemToString(suggestion),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        );
      },
      onSelected: onSelected ?? (_) {},
    );
  }
}
