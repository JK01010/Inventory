//
//  KDCSWData.h
//  KDCReader
//
//  Created by koamtac on 2022/05/12.
//  Copyright © 2022 AISolution. All rights reserved.
//

#import "KDCData.h"
#import "KDCDataBounds.h"

@interface KDCSWData : KDCData

/*!
 * @description  Tell if the received barcode matches the filter
 * @return       true if the received barcode matches the filter, otherwise false.
 */
- (BOOL) IsBarcodeMatching;

/*!
 * @description This property contains the bounds of the decoded barcode within the image.
 *
 * @note
 * It is only available when software decoder is used.
 *
 * @return The bounds information of the location of the barcode within the image, otherwise null.
 */
- (KDCDataBounds *) GetBounds;
@end
