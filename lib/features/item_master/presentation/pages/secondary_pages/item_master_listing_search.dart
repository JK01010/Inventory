import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/theme_extension.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_icon.dart';
import '../../../../../core/service/speech_to_text/presentation/speech_to_text_widgets/speech_to_text_listening_widget.dart';
import '../../../../bagging_tagging_confirmtaion/data/model/rfid_screen_type.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/common_app_search_widget_text_field.dart';
import '../../../../widgets/common_no_data_found_for_listing_widget.dart';
import '../../../../widgets/gradient_background_widget.dart';
import '../../bloc/item_master_listing_bloc/item_master_bloc.dart';
import '../../widgets/item_master_list.dart';
import '../../widgets/shimmer/item_master_list_shimmer.dart';

class ItemMasterSearchPage extends StatefulWidget {
  const ItemMasterSearchPage({super.key});

  @override
  State<ItemMasterSearchPage> createState() => _ItemMasterSearchPageState();
}

class _ItemMasterSearchPageState extends State<ItemMasterSearchPage>
    with WidgetsBindingObserver {
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    searchText.addListener(() {
      context.read<ItemMasterBloc>().add(
        ItemMasterSearchEvent(searchText: searchText.text, isSearch: true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: Scaffold(
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
                            context.read<ItemMasterBloc>().add(
                              ItemMasterSearchEvent(
                                searchText: '',
                                isSearch: false,
                              ),
                            );
                            context.pop();
                          },
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        SizedBox(width: 5),
                        //search field
                        Expanded(
                          child: AppDecoratedBoxShadowWidget(
                            borderRadius: AppBorderRadius.borderRadius30,
                            child: CommonAppSearchWidget(
                              controller: searchText,
                              hintText: 'Search by item name',
                              suffixIcon: SpeechToTextMicWidget(),
                              prefixIcon: Icon(
                                Icons.search,
                                color:
                                    context.isDarkMode
                                        ? AppColor.colorWhite
                                        : AppColor.colorBlack3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppPadding.bottomPaddingNoDataFound),
                    transactionListView(),
                  ],
                ),
              ),

              ///widget for showing microphone interaction
              SpeechToTextListeningWidget(textEditingController: searchText),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionListView() {
    return BlocBuilder<ItemMasterBloc, ItemMasterState>(
      builder: (context, state) {
        if (!state.isLoading && state.searchList.isEmpty) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppPadding.bottomPaddingNoDataFound,
              ),
              child: commonNoDataFoundTwo(context),
            ),
          );
        }
        return Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 100),
            shrinkWrap: true,
            itemCount: state.isLoading ? 5 : state.searchList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.padding4,
                ),
                child:
                    state.isLoading
                        ? ItemMasterListShimmer()
                        : ItemMasterList(
                          itemList: state.searchList[index],
                          onTap: () {
                            context.push(
                              AppRoute.itemMasterViewRfidListViewing.path,
                              extra: {
                                'selectedItemId': state.searchList[index].itemId,
                                'screenType': RfidScreenType.itemMaster,
                              },
                            );
                          },
                        ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox();
            },
          ),
        );
      },
    );
  }
}
