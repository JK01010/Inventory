import '../../../../core/constants/app_enum.dart';

class StockUpdateListModel {

  StockUpdateListModel(
      {this.itemName,
        this.rOB,
        this.actualQty,
        this.articleNo,
        this.articleCode,
        this.storageLocation,
        this.installedOnLocation,
        this.remarks,
        required this.syncStatus,
        this.isSelected
      });

  String? itemName;
  String? rOB;
  String? actualQty;
  String? articleNo;
  String? articleCode;
  String? storageLocation;
  String? installedOnLocation;
  String? remarks;
  List<ChipStatus> syncStatus;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['ROB'] = this.rOB;
    data['consumedQty'] = this.actualQty;
    data['articleNo'] = this.articleNo;
    data['articleCode'] = this.articleCode;
    data['storageLocation'] = this.storageLocation;
    data['installedOnLocation'] = this.installedOnLocation;
    data['remarks'] = this.remarks;
    return data;
  }
}
