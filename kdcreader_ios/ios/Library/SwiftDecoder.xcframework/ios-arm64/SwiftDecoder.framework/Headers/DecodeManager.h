/* HONEYWELL CONFIDENTIAL AND PROPRIETARY!
 *
 * SwiftDecoder Mobile Decoding Software
 * 2015 Hand Held Products, Inc. d/b/a
 * Honeywell Scanning and Mobility
 * Patent(s): https://www.honeywellaidc.com/Pages/patents.aspx
 */

//
//  DecodeManager.h
//  HSMDecoderAPI
//
//  Created by eltodesc on 11/13/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HSMDecodeResult.h"
#import "HSMDecodeResultArray.h"

@interface DecodeManager : NSObject
{
    @private
    HSMDecodeResultArray* decodeResults;
}

//static singelton methods
+ (DecodeManager*) getInstance;
+ (void) disposeInstance;

//member methods
- (int) hsmSetProperty:(int)property Value:(int) value;
- (int) hsmSetStringProperty:(int)property Value:(char*) value;
- (int) hsmGetProperty:(int)property;
- (NSString*) hsmGetStringProperty:(int)property;
- (NSString*) reportDecoderVersion:(int)decoder;
- (NSData*) dumpDecoderSettings;
- (void) enableDecoding:(Boolean)enable;
- (void) setFreezeFrame:(Boolean)enable;
- (Boolean) isDecodingEnabled;
- (Boolean) isFreezeFrame;
- (void) setFreezeFrameMode:(Boolean)enable;
- (Boolean) isFreezeFrameMode;
- (HSMDecodeResultArray*) decode:(unsigned char *)image Width:(int)previewWidth Height:(int)previewHeight;
-(void)setBoundCorrection:(int)boundCorrection;
-(void)enableOpenOCR:(BOOL)openOCREnable;
-(BOOL)isOpenOCREnabled;
-(void)setOpenOCRTemplate:(int)ocrTemplate withSubtype:(int)subtype withTemplateData :(id) templateData;
- (HSMDecodeResultArray*) decodeOCR:(unsigned char *)image Width:(int)previewWidth Height:(int)previewHeight barcodeCount:(int)barcodeCount;
-(int)getBarcodeCount:(unsigned char *)image Width:(int)previewWidth Height:(int)previewHeight;
-(NSString*)getTemplateData:(NSString*) barcodedata withLength:(int) barcodedataLen;
-(NSString*) getTemplateKey;
-(int)setCodabarLength:(NSArray*)array;
-(NSArray*)getCodabarLength;

@end
