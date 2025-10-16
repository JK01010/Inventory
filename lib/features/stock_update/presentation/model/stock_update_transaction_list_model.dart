import '../../../../core/constants/app_enum.dart';

class StockUpdateTransactionListModel {

  StockUpdateTransactionListModel(
      {this.itemName,
        this.serialNumber,
        this.actualQty,
        this.articleNo,
        required this.syncStatus,
        this.remarks,
        this.storageLocation});


  String? itemName;
  List<String>? serialNumber;
  String? actualQty;
  String? articleNo;
  String? remarks;
  String? storageLocation;
  SyncStatus syncStatus;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemName'] = itemName;
    data['serialNumber'] = serialNumber;
    data['consumedQty'] = actualQty;
    data['articleNo'] = articleNo;
    data['remarks'] = remarks;
    return data;
  }
}
