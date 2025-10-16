//
//  OCRBounds.h
//  HSMDecoderAPI
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/**
 *  @brief This class contains a ocrdata's location within an image by defining the four corners of the barcode's bounds as points within the image.
 */

@interface OCRBounds : NSObject {
@private
FixedPoint upperLeft, upperRight, bottomLeft, bottomRight;
}

- (id) init:(int*)barcodeBounds ImgWidth:(int)width ImgHeight:(int)height;

/**
* @brief The upper-left point of the barcode's bounds witin the image
*/
@property (assign) FixedPoint upperLeft;

/**
* @brief The upper-right point of the barcode's bounds witin the image
*/
@property (assign) FixedPoint upperRight;

/**
* @brief The bottom-left point of the barcode's bounds witin the image
*/
@property (assign) FixedPoint bottomLeft;

/**
* @brief The bottom-right point of the barcode's bounds witin the image
*/
@property (assign) FixedPoint bottomRight;

/**
* @brief The width of the image the barcode was found in
*/
@property (assign) int imageWidth;

/**
* @brief The height of the image the barcode was found in
*/
@property (assign) int imageHeight;
@end


NS_ASSUME_NONNULL_END
