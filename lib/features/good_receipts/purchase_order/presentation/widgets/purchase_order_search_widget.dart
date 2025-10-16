import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../../bagging_tagging_confirmtaion/presentation/widgets/bagging_pending_search_widget.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../domain/entity/purchase_order_entity.dart';
import '../bloc/purchase_order_search_bloc/purchase_order_search_bloc.dart';

class PurchaseOrderSearchWidget extends StatefulWidget {
  const PurchaseOrderSearchWidget({super.key});

  @override
  State<PurchaseOrderSearchWidget> createState() =>
      _PurchaseOrderSearchWidgetState();
}

class _PurchaseOrderSearchWidgetState extends State<PurchaseOrderSearchWidget>
    with WidgetsBindingObserver {
  Timer? _debounce;
  final TextEditingController searchTextEditingController =
      TextEditingController();

  void _onSearchChanged({required String query}) {
    if (query.isEmpty) {
      context.read<PurchaseOrderSearchBloc>().add(
        PurchaseOrderItemSearchEvent(query: ''),
      );
      return;
    }
    if (query.length <= 3) {
      return;
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 100), () {
      context.read<PurchaseOrderSearchBloc>().add(
        PurchaseOrderItemSearchEvent(query: query),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    searchTextEditingController.addListener(() {
      _onSearchChanged(query: searchTextEditingController.text);
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
        child: BlocBuilder<PurchaseOrderSearchBloc, PurchaseOrderSearchState>(
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
                                child: AppSearchWidget<PurchaseOrderEntity>(
                                  itemToString: (p0) => p0.poCode,
                                  items:
                                      state is PurchaseOrderSearchLoaded
                                          ? state.purchaseOrderEntityList
                                          : [],
                                  suffixIcon: SpeechToTextMicWidget(),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColor.colorBlack3,
                                  ),
                                  suggestionsCallback: (search) async {
                                    final lower = search.toLowerCase();
                                    if (state is PurchaseOrderSearchLoaded) {
                                      return state.purchaseOrderEntityList
                                          .where((item) {
                                            final String poNo =
                                                (item).poCode.toLowerCase();
                                            final String grnId =
                                                item.grnId
                                                    .toString()
                                                    .toLowerCase();
                                            final String title =
                                                item.title.toLowerCase();
                                            return poNo.contains(lower) ||
                                                grnId.contains(lower) ||
                                                title.contains(lower);
                                          })
                                          .toList();
                                    } else {
                                      return [];
                                    }
                                  },
                                  controller: searchTextEditingController,
                                  onSelected: (data) {
                                    context.push(
                                      AppRoute.purchaseOrderDetailPage.path,
                                      extra: data,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (state is PurchaseOrderSearchLoaded &&
                            state.purchaseOrderEntityList.isEmpty)
                          commonNoDataFound(context),
                      ],
                    ),
                  ),

                  ///widget for showing microphone interaction
                  SpeechToTextListeningWidget(
                    textEditingController: searchTextEditingController,
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
