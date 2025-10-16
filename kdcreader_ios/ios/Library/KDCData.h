//
//  KDCData.h
//  KDCReader
//
//  Created by KoamTac on 10/21/14.
//  Copyright (c) 2014 AISolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDCConstants.h"

@interface KDCData : NSObject

/*!
 * @description  Returns data type
 * @return       enum DataType
 */
- (enum DataType)GetDataType;

/*!
 * @description  Returns NFC tag type
 * @return       enum NFCTag
 */
- (enum NFCTag) GetNFCTagType;

/*!
 * @description  Returns payload data(Barcode or NFC or GPS or MSR)
 * @return       NSString data
 */
- (NSString *)GetData;

/*!
 * @description  Returns raw(payload) data(Barcode or NFC or GPS or MSR)
 * @return       Binary data
 */
- (Byte *)GetDataBytes;

/*!
 * @description  Returns raw(payload) data length
 * @return       Int raw data length
 */
- (int)GetDataBytesLength;

/*!
 * @description  Returns NFC UID data
 * @return       NSString data of NFC UID
 */
- (NSString *)GetNFCUID;

/*!
 * @description  Returns NFC UID reversed data
 * @return       NSString data of NFC UID reversed
 */
- (NSString *)GetNFCUIDReversed;

/*!
 * @description  Returns NFC payload data
 * @return       NSString data of NFC payload data
 */
- (NSString *)GetNFCData;

/*!
 * @description  Returns NFC payload data
 * @return       Binary data of NFC payload data
 */
- (Byte *)GetNFCDataBytes;

/*!
 * @description  Returns NFC payload data length
 * @return       The length of binary data of NFC data
 */
- (int)GetNFCDataBytesLength;

/*!
 * @description  Returns NFC data with Base64 format
 * @return       NSString data of NFC data with Base64
 */
- (NSString *)GetNFCDataBase64;

/*!
 * @description  Returns UHF tag list
 * @note it is available only when data type is UHF_LIST.
 * @return       The array of UHF tag data
 */
- (NSArray *)GetUHFList;

/*!
 * @description  Returns UHF tag data type in UHF tag list
 * @note it is available only when data type is UHF_LIST.
 * @return       UHF tag data type
 */
- (enum UHFDataType)GetUHFListDataType;

/*!
 * @description  Returns UHF rssi list [0, 100]
 * @note it is available only when data type is UHF_LIST.
 * @return       The array of UHF rssi data
 */
- (NSArray *)GetUHFRssiList;

/*!
 * @description  Returns barcode data
 * @return       NSString data
 */
- (NSString *)GetBarcodeData;

/*!
 * @description  Returns barcode data
 * @return       Binary data
 */
- (Byte *)GetBarcodeDataBytes;

/*!
 * @description  Returns barcode  data length
 * @return       The length of binary data of barcode
 */
- (int)GetBarcodeDataBytesLength;

/*!
 * @description  Returns barcode data symbology
 * @return       NSString data of barcode symbology
 */
- (NSString *)GetBarcodeSymbology;

/*!
 * @description  Returns MSR payload data
 * @return       NSString data of MSR data
 */
- (NSString *)GetMSRData;

/*!
 * @description  Returns MSR payload data
 * @return       Binary data of MSR data
 */
- (Byte *)GetMSRDataBytes;

/*!
 * @description  Returns MSR payload data length
 * @return       The length of binary data of MSR data
 */
- (int)GetMSRDataBytesLength;

/*!
 * @description  Returns GPS data
 * @return       GPS data of decimal format
 */
- (NSString *)GetGPSData;

/*!
 * @description  Returns payload data(Barcode or NFC or GPS or MSR) with record format
 * @return       NSString data with record format
 */
- (NSString *)GetRecord;

/*!
 * @description  Returns timestamp
 * @return       Timestamp as NSDateComponents
 */
- (NSDateComponents *)GetTimestamp;

/*!
 * @description  Returns Key Event
 * @return       Key Event as NSString
 */
- (NSString *)GetKeyEvent;

/*!
 * @description  Returns application step
 * @note         It is available when KDCMode is APPLICATION
 * @return       application step
 */
- (int)GetAppStep;

/*!
 * @description  Returns application data type
 * @note         It is available when KDCMode is APPLICATION
 * @return       application data type
 */
- (enum AppDataType)GetAppDataType;

/*!
 * @description  Returns application quantity
 * @note         It is available when KDCMode is APPLICATION
 * @return       application quantity
 */
- (int)GetAppQuantity;

@end
