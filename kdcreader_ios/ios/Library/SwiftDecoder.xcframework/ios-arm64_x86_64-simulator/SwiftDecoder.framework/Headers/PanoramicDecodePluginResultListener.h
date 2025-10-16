//
//  PanoramicPluginResultListener.h
//  SwiftDecoderDemo
//
//  Created by Misra, Vaibhav on 10/21/15.
//  Copyright © 2015 Honeywell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PluginResultListener.h"

@protocol PanoramicDecodePluginResultListener <PluginResultListener>

@optional
- (void) onPanoramicPluginResults:(HSMDecodeResultArray*)results barcodeImages:(NSMutableArray*)barcodeImages;

@end
