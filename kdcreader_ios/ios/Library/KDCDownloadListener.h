//
//  KDCDownloadListener.h
//  KDCReader
//
//  Created by koamtac on 2022/07/04.
//  Copyright © 2022 AISolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KDCDownloadListener <NSObject>

/*!
 * @description Firmware upgrade is prepared.
 */
- (void) onPrepare;

/*!
 * @description Firmware upgrade is started. The KDC goes into firmware download mode.
 */
- (void) onStart;

/*!
 * @description Sending firmware data is finished. It is required more time for the upgrade to complete.
 *
 * @note Depending on the firmware, the connection will be lost and the KDC may reboot.
 */
- (void) onFinish;

/*!
 * @description Notify current status of sending firmware data
 * @param   total total page count
 * @param   current current page count to be sent
 */
- (void) onStatus:(int)total current:(int)current;

/*!
 * @description Error is occurred. Please refer to RCODE_DOWNLOAD_XX
 * @param   errCode error reason code
 */
- (void) onError:(int)errCode;

@end
