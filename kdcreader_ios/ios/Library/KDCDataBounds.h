//
//  KDCDataBounds.h
//  KDCReader
//
//  Created by koamtac on 8/23/24.
//  Copyright © 2024 AISolution. All rights reserved.
//

#import <SwiftDecoder/BarcodeBounds.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDCDataBounds : NSObject

/*!
 * @description The upper-left point of the barcode's bounds witin the image
 */
@property (assign) CGPoint upperLeft;

/*!
 * @description The upper-right point of the barcode's bounds witin the image
 */
@property (assign) CGPoint upperRight;

/*!
 * @description The bottom-left point of the barcode's bounds witin the image
 */
@property (assign) CGPoint bottomLeft;

/*!
 * @description The bottom-right point of the barcode's bounds witin the image
 */
@property (assign) CGPoint bottomRight;

/*!
 * @description The size of the image the barcode was found in
 */
@property (assign) CGSize imageSize;

/*!
 * @description Init with using BarcodeBounds instance
 */
- (id) initWithBarcodeBounds:(BarcodeBounds*)barcodeBounds;

/*!
 * @description Convert to BarcodeBounds instance
 */
- (BarcodeBounds *) ToBarcodeBounds;
@end

NS_ASSUME_NONNULL_END
