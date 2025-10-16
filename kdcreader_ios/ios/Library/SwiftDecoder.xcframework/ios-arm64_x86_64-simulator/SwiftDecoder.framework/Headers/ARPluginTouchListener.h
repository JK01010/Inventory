//
//  ARPluginTouchListener.h
//  SwiftDecoder
//
//  Created by K N, Vinod K N on 11/05/22.
//

#import <Foundation/Foundation.h>
#import "PluginResultListener.h"

@protocol ARPluginTouchListener <PluginResultListener>

-(void)onResultSelected:(NSDictionary*)arPluginResult;
@end

