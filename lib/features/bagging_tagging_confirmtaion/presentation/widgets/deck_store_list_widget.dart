import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:pal_ng_inventory/core/constants/app_size.dart';
import 'package:pal_ng_inventory/features/bagging_tagging_confirmtaion/domain/entities/confirmation_scanning_deck_store_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/rounded_check_box_widget.dart';
import '../../data/model/confirmation_scanning_deck_store_item_options_model.dart';
import '../../domain/entities/bagging_confirmation_list_entity.dart';
import '../../model/confirmation_selection_model.dart';
import '../bloc/bagging_confirmation_list/bagging_confirmation_list_bloc.dart';

class DeckStorePage extends StatelessWidget {

  const DeckStorePage({super.key});

  @override
  Widget build(BuildContext context) {
/*    final stores = [
      ConfirmationScanningDeckStore(
        grnNo: "GRN001",
        storageLocation: storageLocation,
        isSelected: true,
        deckStoreItemOptionList: [
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Deck Store A",
            isSelected: false,
          ),
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "ACCA DK",
            isSelected: false,
          ),
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "CBNSTR",
            isSelected: false,
          ),
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Deck A",
            isSelected: false,
          ),
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Shelf A",
            isSelected: false,
          ),
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Rack 1",
            isSelected: false,
          ),
        ],
      ),
      ConfirmationScanningDeckStore(
        grnNo: "GRN002",
        storageLocation: "Deck Store B",
        isSelected: false,
        deckStoreItemOptionList: [
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Deck Store B",
            isSelected: false,
          ),
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Rack 2",
            isSelected: false,
          ),
        ],
      ),
      ConfirmationScanningDeckStore(
        grnNo: "GRN003",
        storageLocation: "Deck Store C",
        isSelected: false,
        deckStoreItemOptionList: [
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Deck Store C",
            isSelected: false,
          ),
          ConfirmationScanningDeckStoreItemOptions(
            storageLocation: "Rack 3",
            isSelected: false,
          ),
        ],
      ),
    ];*/

    return Scaffold(
      body: BlocBuilder<BaggingConfirmationListBloc,
        BaggingConfirmationListState
      >(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.locList.length,
            itemBuilder: (context, index) {
              return DeckStoreCard(
                // store: [],
                index: index,
                // entity: state.baggingConfirmationListEntity[index],
                locName: state.locList[index],
              );
            },
          );
        },
      ),
    );
  }
}

class DeckStoreCard extends StatefulWidget {
  // final ConfirmationScanningDeckStore store;
  // final BaggingConfirmationListEntity entity;
  final int index;
  final LocationModelForConfirmation locName;

  const DeckStoreCard({
    super.key,
    // required this.store,
    // required this.entity,
    required this.index,
    required this.locName
  });

  @override
  State<DeckStoreCard> createState() => _DeckStoreCardState();
}

class _DeckStoreCardState extends State<DeckStoreCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
  /*  final path =
        widget.store.deckStoreItemOptionList
            .map((e) => e.storageLocation)
            .toList();*/

    return BlocBuilder<
      BaggingConfirmationListBloc,
      BaggingConfirmationListState
    >(
      builder: (context, state) {
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(AppPadding.padding12),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            /*onTap:
                path.length > 2
                    ? () => setState(() => isExpanded = !isExpanded)
                    : null,*/
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.padding15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Checkbox
                  // CustomCheckButton(
                  //   checkBoxName: '',
                  //   enableButton: widget.store.isSelected,
                  //   onItemUpdate: (bool newValue) {
                  //     setState(() {
                  //       widget.store.isSelected = newValue;
                  //     });
                  //   },
                  // ),
                  RoundedCheckBoxWidget(
                    value: widget.locName.isSelected,
                    onTap: () {
                      context.read<BaggingConfirmationListBloc>().add(
                        IsCheckBoxSelectedEvent(
                          index: widget.index,
                          isSelectedValue: widget.locName.isSelected,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: AppSize.size8),

                  /// Column with Title + Breadcrumb
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        Text(
                          widget.locName.locName,
                          style: textTheme.titleSmall?.copyWith(
                            fontSize: AppFontSize.fontSize16,
                          ),
                        ),

                        const SizedBox(height: AppSize.size4),

                        /// Breadcrumb
                        // _buildBreadcrumb(path),
                      ],
                    ),
                  ),

                  /// Expand Arrow (only if path > 2)
                  // if (path.length > 2)
                  //   Icon(
                  //     isExpanded
                  //         ? Icons.keyboard_arrow_up
                  //         : Icons.keyboard_arrow_right,
                  //     color: AppColor.colorGrey,
                  //   ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Truncated breadcrumb widget

  Widget _buildBreadcrumb(List<String> path) {
    if (path.isEmpty) return const SizedBox();

    List<String> visiblePath;
    if (isExpanded || path.length <= 2) {
      visiblePath = path;
    } else {
      visiblePath = [path.first, "...", path.last];
    }

    return BreadCrumb(
      items:
          visiblePath.map((e) {
            return BreadCrumbItem(
              content: Text(
                e,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: AppFontSize.fontSize12,
                ),
              ),
            );
          }).toList(),
      divider: const Icon(
        Icons.chevron_right,
        size: AppSize.size16,
      ),
    );
  }
}
