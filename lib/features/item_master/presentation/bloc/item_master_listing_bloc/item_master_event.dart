part of 'item_master_bloc.dart';

 class ItemMasterEvent extends Equatable {

   const ItemMasterEvent();

  @override
  List<Object?> get props => [];
}

class InsertItemMasterEvent extends ItemMasterEvent {}

class FetchAllDataItemMasterEvent extends ItemMasterEvent {}

class LazyLoadingItemMasterEvent extends ItemMasterEvent {}

class ApplyFilterItemMasterEvent extends ItemMasterEvent {

  ApplyFilterItemMasterEvent(
     this.itemName,
     this.equipmentName,
     this.partNo,
     this.articleNo
  );

  final String itemName;
  final String equipmentName;
  final String partNo;
  final String articleNo;
}

class ItemMasterSearchEvent extends ItemMasterEvent {

  const ItemMasterSearchEvent({required this.searchText,required this.isSearch});

  final String searchText;
  final bool isSearch;
}




class KdcReaderUpdateRangeEvent extends ItemMasterEvent{
  const KdcReaderUpdateRangeEvent({required this.range});
  final double range;
}
class KdcReaderDisposeEvent extends ItemMasterEvent{}
class KdcReaderInitEvent extends ItemMasterEvent {
   const KdcReaderInitEvent({required this.screenType});
   final String screenType;
}
class KdcReaderStartScanEvent extends ItemMasterEvent{
  const KdcReaderStartScanEvent({required this.screenType});
  final String screenType;
}
class KdcReaderStopScanEvent extends ItemMasterEvent{

  const KdcReaderStopScanEvent({required this.selectedItemId,required this.screenType});

  final int selectedItemId;
  final String screenType;
}

class RfidSaveByItemIdEvent extends ItemMasterEvent{
   const RfidSaveByItemIdEvent({required this.selectedItemId,required this.rfidList});

   final int selectedItemId;
   final List<String> rfidList;
}

class RfidSelectionEvent extends ItemMasterEvent{
   const RfidSelectionEvent({required this.isSelected,required this.rfidName});
   final bool isSelected;
   final String rfidName;
}






