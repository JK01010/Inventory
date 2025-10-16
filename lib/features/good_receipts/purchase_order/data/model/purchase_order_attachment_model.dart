import 'package:equatable/equatable.dart';

import 'entity_validation_model.dart';

class PurchaseOrderAttachmentModelResponseModel extends Equatable {
  const PurchaseOrderAttachmentModelResponseModel({
    this.moduleCode,
    this.entityName,
    this.recordCount,
    this.reportData,
    this.entityValidation,
  });

  factory PurchaseOrderAttachmentModelResponseModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return PurchaseOrderAttachmentModelResponseModel(
      moduleCode:
          map['moduleCode'] != null ? map['moduleCode'] as String : null,
      entityName:
          map['entityName'] != null ? map['entityName'] as String : null,
      recordCount:
          map['recordCount'] != null ? map['recordCount'] as int : null,
      reportData:
          map['reportData'] != null
              ? List<PurchaseOrderAttachmentModel>.from(
                (map['reportData'] as List<dynamic>)
                    .map<PurchaseOrderAttachmentModel?>(
                      (x) => PurchaseOrderAttachmentModel.fromJson(
                        x as Map<String, dynamic>,
                      ),
                    ),
              )
              : null,
      entityValidation:
          map['entityValidation'] != null
              ? EntityValidationModel.fromJson(
                map['entityValidation'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  final String? moduleCode;
  final String? entityName;
  final int? recordCount;
  final List<PurchaseOrderAttachmentModel>? reportData;

  final EntityValidationModel? entityValidation;

  @override
  List<Object?> get props => [
    moduleCode,
    entityName,
    reportData,
    recordCount,
    entityValidation,
  ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'moduleCode': moduleCode,
      'entityName': entityName,
      'recordCount': recordCount,
      'reportData': reportData?.map((x) => x.toJson()).toList(),
      'entityValidation': entityValidation?.toJson(),
    };
  }
}

class PurchaseOrderAttachmentModel extends Equatable {
  const PurchaseOrderAttachmentModel({
    this.id,
    this.poHdId,
    this.applicationCode,
    this.pageCode,
    this.documentUniqueID,
    this.fileName,
    this.refName,
    this.chunkSize,
    this.totalChunk,
    this.fileSize,
    this.contentType,
    this.isDeleted,
    this.attachmentType,
    this.chunkIndex,
    this.fileExtension,
    this.fileHash,
    this.filePath,
    this.isFileSync,
    this.isSync,
    this.operationType,
  });

  factory PurchaseOrderAttachmentModel.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderAttachmentModel(
      id: map['id'] != null ? map['id'] as int : null,
      documentUniqueID:
          map['documentUniqueID'] != null
              ? map['documentUniqueID'] as String
              : null,
      poHdId: map['poHdId'] != null ? map['poHdId'] as int : null,
      attachmentType:
          map['attachmentType'] != null
              ? map['attachmentType'] as String
              : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      isSync: map['isSync'] != null ? map['isSync'] as bool : null,
      isFileSync: map['isFileSync'] != null ? map['isFileSync'] as bool : null,
      fileSize: map['fileSize'] != null ? map['fileSize'] as int : null,
      filePath: map['filePath'] != null ? map['filePath'] as String : null,
      fileExtension:
          map['fileExtension'] != null ? map['fileExtension'] as String : null,
      contentType:
          map['contentType'] != null ? map['contentType'] as String : null,
      operationType:
          map['operationType'] != null ? map['operationType'] as String : null,
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      chunkIndex: map['chunkIndex'] != null ? map['chunkIndex'] as int : null,
      chunkSize: map['chunkSize'] != null ? map['chunkSize'] as int : null,
      fileHash: map['fileHash'] != null ? map['fileHash'] as String : null,
      totalChunk: map['totalChunk'] != null ? map['totalChunk'] as int : null,
      applicationCode:
          map['applicationCode'] != null
              ? map['applicationCode'] as String
              : null,
      pageCode: map['pageCode'] != null ? map['pageCode'] as String : null,
      refName: map['refName'] != null ? map['refName'] as String : null,
    );
  }

  final int? id;
  final String? documentUniqueID;
  final int? poHdId;
  final String? attachmentType;
  final bool? isDeleted;
  final bool? isSync;
  final bool? isFileSync;
  final int? fileSize;
  final String? filePath;
  final String? fileExtension;
  final String? contentType;
  final String? operationType;
  final String? fileName;
  final int? chunkIndex;
  final int? chunkSize;
  final String? fileHash;
  final int? totalChunk;
  final String? applicationCode;
  final String? pageCode;
  final String? refName;

  @override
  List<Object?> get props => [
    id,
    poHdId,
    applicationCode,
    pageCode,
    documentUniqueID,
    fileName,
    refName,
    chunkSize,
    totalChunk,
    fileSize,
    contentType,
    isDeleted,
  ];

  PurchaseOrderAttachmentModel copyWith({
    int? id,
    String? documentUniqueID,
    int? poHdId,
    String? attachmentType,
    bool? isDeleted,
    bool? isSync,
    bool? isFileSync,
    int? fileSize,
    String? filePath,
    String? fileExtension,
    String? contentType,
    String? operationType,
    String? fileName,
    int? chunkIndex,
    int? chunkSize,
    String? fileHash,
    int? totalChunk,
    String? applicationCode,
    String? pageCode,
    String? refName,
  }) {
    return PurchaseOrderAttachmentModel(
      id: id ?? this.id,
      documentUniqueID: documentUniqueID ?? this.documentUniqueID,
      poHdId: poHdId ?? this.poHdId,
      attachmentType: attachmentType ?? this.attachmentType,
      isDeleted: isDeleted ?? this.isDeleted,
      isSync: isSync ?? this.isSync,
      isFileSync: isFileSync ?? this.isFileSync,
      fileSize: fileSize ?? this.fileSize,
      filePath: filePath ?? this.filePath,
      fileExtension: fileExtension ?? this.fileExtension,
      contentType: contentType ?? this.contentType,
      operationType: operationType ?? this.operationType,
      fileName: fileName ?? this.fileName,
      chunkIndex: chunkIndex ?? this.chunkIndex,
      chunkSize: chunkSize ?? this.chunkSize,
      fileHash: fileHash ?? this.fileHash,
      totalChunk: totalChunk ?? this.totalChunk,
      applicationCode: applicationCode ?? this.applicationCode,
      pageCode: pageCode ?? this.pageCode,
      refName: refName ?? this.refName,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'documentUniqueID': documentUniqueID,
      'poHdId': poHdId,
      'attachmentType': attachmentType,
      'isDeleted': isDeleted == true ? 1 : 0,
      'isSync': isSync == true ? 1 : 0,
      'isFileSync': isFileSync == true ? 1 : 0,
      'fileSize': fileSize,
      'filePath': filePath,
      'fileExtension': fileExtension,
      'contentType': contentType,
      'operationType': operationType,
      'fileName': fileName,
      'chunkIndex': chunkIndex,
      'chunkSize': chunkSize,
      'fileHash': fileHash,
      'totalChunk': totalChunk,
      'applicationCode': applicationCode,
      'pageCode': pageCode,
      'refName': refName,
    };
  }
}
