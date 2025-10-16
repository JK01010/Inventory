part of 'consumption_rfid_scanning_bloc.dart';

class ConsumptionRfidScanningEvent extends Equatable{

  const ConsumptionRfidScanningEvent();

  @override
  List<Object?> get props => [];
}
//scanning events
class StartScanningEvent extends ConsumptionRfidScanningEvent{}
class StopScanningEvent extends ConsumptionRfidScanningEvent{}
class InitialScanningEvent extends ConsumptionRfidScanningEvent{}
class DisposeScanningEvent extends ConsumptionRfidScanningEvent{}
class UpdateRangeEvent extends ConsumptionRfidScanningEvent{
  const UpdateRangeEvent({required this.range});
  final double range;
}


class FetchRfidScanningListEvent extends ConsumptionRfidScanningEvent{}

class IsSelectedEvent extends ConsumptionRfidScanningEvent{
  IsSelectedEvent({
    required this.index,
    required this.isSelectedValue,
    required this.completeSelect,
  });

  final int index;
  final bool isSelectedValue;
  final bool completeSelect;
}

class StockUpdateListingSearchEvent extends ConsumptionRfidScanningEvent {

const StockUpdateListingSearchEvent({required this.searchText,required this.isSearch});

  final String searchText;
  final bool isSearch;
}