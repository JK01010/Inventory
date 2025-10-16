part of 'rfid_view_bloc.dart';

class RfidViewEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class ItemMasterRfidListingInsertEvent extends RfidViewEvent{}
class ItemMasterRfidListingFetchEvent extends RfidViewEvent{
   ItemMasterRfidListingFetchEvent({required this.selectedItemId});
  final int selectedItemId;
}



