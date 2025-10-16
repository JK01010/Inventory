//
//  KPOSData.h
//  KDCReader
//
//  Created by Jude on 2015. 4. 6..
//  Copyright (c) 2015년 AISolution. All rights reserved.
//

#ifndef KDCReader_KPOSData_h
#define KDCReader_KPOSData_h

#import "KPOSEMVApplication.h"
#import "KPOSEMVTagList.h"

@interface KPOSData : NSObject

- (id)initWithData:(Byte *)data length:(int)length;
- (BOOL) ParseData;

/*!
 * This method returns the command code
 * @return command code.
 */
- (short) GetCommandCode;

/*!
 * This method returns the event code
 * @return command code.
 */
- (short) GetEventCode;

/*!
 * This method returns the byte array representation of barcode data received from the KDC500 series.
 * @return The byte aray of the barcode data.
 */
- (Byte *) GetBarcodeBytes;

/*!
 * This method returns the length of barcode data.
 * @return The length of barcode data.
 */
- (int) GetBarcodeLength;

/*!
 * This method returns the hexadecimal string representation of NFC UID received from the KDC500 series.
 * @return The hexadecimal string representation of NFC UID.
 */
- (NSString *) GetNFCUID;

/*!
 * This method returns the byte array representation of NFC Data received from the KDC500 series.
 * @return The byte aray of the nfc data.
 */
- (NSData *) GetNFCDataBytes;

/*!
 * This method returns the hexadecimal string representation of NFC Data received from the KDC500 series.
 * @return The hexadecimal string representation of NFC Data.
 */
- (NSString *) GetNFCData;

/*!
 * This method returns the string representation of track1 data received from the KDC500 series.
 * @return The track1 data converted into a NSString format.
 */
- (NSString *) GetTrack1;

/*!
 * This method returns the string representation of track2 data received from the KDC500 series.
 * @return The track2 data converted into a NSString format.
 */
- (NSString *) GetTrack2;

/*!
 * This method returns the string representation of track3 data received from the KDC500 series.
 * @return The track3 data converted into a NSString format.
 */
- (NSString *) GetTrack3;

- (short) GetPOSEntryMode;

- (short) GetEncryptionSpec;
- (short) GetEncryptionType;
- (short) GetEncryptedDataSize;

/*!
 * This method returns the length of unencrypted track1 data. This length is used for the decryption of the encrypted track1 data.
 * @return The length of unencrypted track1 data.
 */
- (short) GetUnencryptedTrack1Length;

/*!
 * This method returns the length of unencrypted track2 data. This length is used for the decryption of the encrypted track2 data.
 * @return The length of unencrypted track2 data.
 */
- (short) GetUnencryptedTrack2Length;

/*!
 * This method returns the length of unencrypted track3 data. This length is used for the decryption of the encrypted track3 data.
 * @return The length of unencrypted track3 data.
 */
- (short) GetUnencryptedTrack3Length;

/*!
 * This method returns the length of unencrypted PAN data. This length is used for the decryption of the encrypted PAN data.
 * @return The length of unencrypted PAN data.
 */
- (short) GetUnencryptedPANLength;

/*!
 * This method returns the length of encrypted track1 data.
 * @return The length of encrypted track1 data.
 */
- (short) GetEncryptedTrack1Length;

/*!
 * This method returns the length of encrypted track2 data.
 * @return The length of encrypted track2 data.
 */
- (short) GetEncryptedTrack2Length;

/*!
 * This method returns the length of encrypted track3 data.
 * @return The length of encrypted track3 data.
 */
- (short) GetEncryptedTrack3Length;

/*!
 * This method returns the length of encrypted PAN data.
 * @return The length of encrypted PAN data.
 */
- (short) GetEncryptedPANLength;

/*!
 * This method returns the byte array representation of the encrypted track1 data received from the KDC500 series.
 * @return The byte array of the encrypted track1 data.
 */
- (Byte *) GetEncryptedTrack1Bytes;

/*!
 * This method returns the byte array representation of the encrypted track2 data received from the KDC500 series.
 * @return The byte array of the encrypted track2 data.
 */
- (Byte *) GetEncryptedTrack2Bytes;

/*!
 * This method returns the byte array representation of the encrypted track3 data received from the KDC500 series.
 * @return The byte array of the encrypted track3 data.
 */
- (Byte *) GetEncryptedTrack3Bytes;

/*!
 * This method returns the byte array representation of the encrypted PAN data received from the KDC500 series.
 * @return The byte array of the encrypted PAN data.
 */
- (Byte *) GetEncryptedPANBytes;

- (short) GetDigestType;
- (short) GetTrack1DigestLength;
- (short) GetTrack2DigestLength;
- (short) GetTrack3DigestLength;
- (short) GetPANDigestLength;

- (Byte *) GetTrack1DigestBytes;
- (Byte *) GetTrack2DigestBytes;
- (Byte *) GetTrack3DigestBytes;
- (Byte *) GetPANDigestBytes;

- (NSString *) GetCardDataKSN;
- (NSString *) GetDeviceSerialNumber;

/*!
 * This method returns the Automatic Application Selection flag
 * @return boolean
 */
- (BOOL) IsAutoAppSelection;

/*!
 * This method returns the number of EMV Applications supported by the KDC500 and inserted IC Card
 * @return number of EMV Applications
 */
- (short) GetNumberOfAIDs;

/*!
 * This method returns the NSMutableArray representation of EMV Application list
 * @return KPOSEMVApplication array
 */
- (NSMutableArray *) GetEMVApplicationList;

/*!
 * This method returns the EMV Tag list
 * @return TLV list
 */
- (KPOSEMVTagList *) GetEMVTagList;

/*!
 * This method returns the EMV result code
 * @return EMV Result code
 */
- (short) GetEMVResultCode;
- (short) GetEMVFallbackType;
- (short) GetErrorCode;

/*!
 * This method returns the byte array representation of PinBlock data received from the KDC500 series.
 * @return The PinBlock data.
 */
- (Byte *) GetPinBlockBytes;
- (short) GetPinBlockLength;

/*!
 * This method returns the string representation of KSN data received from the KDC500 series.
 * @return The KSN data converted into a NSString format.
 */
- (NSString *) GetPinBlockKSN;

/*!
 * This method returns the string representation of data, which is entered via Keypad.
 * @return value entered via keypad
 */
- (NSString *) GetValueEntered;
- (char) GetPressedKey;
- (short) GetBatteryStatus;

/*!
 * This method returns selected item index
 * @return 0 - not selected 1 ~ N - selected item index
 */
- (short) GetSelectedItemIndex;

@end

#endif
