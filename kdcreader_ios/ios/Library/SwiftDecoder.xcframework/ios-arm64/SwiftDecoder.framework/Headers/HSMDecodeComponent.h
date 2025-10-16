/* HONEYWELL CONFIDENTIAL AND PROPRIETARY!
 *
 * SwiftDecoder Mobile Decoding Software
 * 2015 Hand Held Products, Inc. d/b/a
 * Honeywell Scanning and Mobility
 * Patent(s): https://www.honeywellaidc.com/Pages/patents.aspx
 */

//
//  HSMDecodeComponent.h
//  HSMDecoderAPI
//
//  Created by eltodesc on 11/14/13.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CameraManagerEventListener.h"

@interface HSMDecodeComponent : UIView <CameraManagerEventListener>
{
    @private
    Boolean isComponentEnabled;
}

-(void) enable:(Boolean)enable;
-(Boolean) isEnabled;
/**
 *  @brief This call will set  freeze mode (applicable only for AR plugin) .
 *
 *  @param mode
 *  Enable or disable freeze frame mode
 *
 */
-(void) setFreezeMode:(Boolean)mode;
-(void)dispose;
@end
