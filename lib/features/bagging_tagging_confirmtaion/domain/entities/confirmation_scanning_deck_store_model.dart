

import '../../data/model/confirmation_scanning_deck_store_item_options_model.dart';

class ConfirmationScanningDeckStore{

  ConfirmationScanningDeckStore({
      required this.grnNo,
      required this.storageLocation,
      required this.isSelected,
      required this.deckStoreItemOptionList});
  final String grnNo;
  final String storageLocation;
  late bool isSelected;
  final List<ConfirmationScanningDeckStoreItemOptions> deckStoreItemOptionList;
}