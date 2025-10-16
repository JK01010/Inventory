//
//  KDCFirmwareValidator.h
//  KDCReader
//
//  Created by koamtac on 2022/07/05.
//  Copyright © 2022 AISolution. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDCFirmwareValidator : NSObject

/*!
 * Get firmware type from firmware data buffer.
 *
 * @param data firmware data
 * @return Firmware type if successful. Otherwise null.
 */
- (NSString *) GetType:(NSData *) data;

/*!
 * Get firmware version from firmware data buffer.
 *
 * @param data firmware data
 * @return Firmware type if successful. Otherwise null.
 */
- (NSString *) GetVersion:(NSData *) data;


/*!
 * Get firmware build version from firmware data buffer.
 *
 * @param data firmware data
 * @return Firmware type if successful. Otherwise null.
 */
- (NSString *) GetBuildVersion: (NSData *) data;

/*!
 * Validate firmware data. Check Koamtac signature and CRC.
 *
 * @param data firmware data
 * @return True if successful. Otherwise false.
 */
- (BOOL) Validate: (NSData *) data;

@end

NS_ASSUME_NONNULL_END
