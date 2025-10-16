//
//  OCRResult.h
//  HSMDecoderAPI
//
//  Created by H454944 on 07/10/22.
//

#import <Foundation/Foundation.h>
#import "OCRBounds.h"
NS_ASSUME_NONNULL_BEGIN
/**
 *  @brief This class contains all the necessary information abount a decoded barcode
 */

@interface OCRResult : NSObject

/**
 * @brief This property contains the OCR data in bytes
 */
@property(strong) NSData *ocrByteData;
/**
 * @brief This property contains the OCR Recognition Time
 */
@property(assign) double ocrRecognitionTime;
/**
 * @brief This property contains the OCR Total Time
 */
@property(assign) double ocrTotalTime;
/**
 * @brief This property contains the OCR data Length
 */
@property(assign) int ocrDataLength;
/**
 * @brief This property contains the bounds of the decoded OCR within the image.
 */
@property(retain) OCRBounds *ocrBounds;

@end

NS_ASSUME_NONNULL_END
