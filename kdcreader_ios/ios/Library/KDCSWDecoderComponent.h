//
//  KDCSWDecoderComponent.h
//  KDCReader
//
//  Created by koamtac on 2020/07/30.
//  Copyright © 2020 AISolution. All rights reserved.
//

/* HSMDecodeComponent wrapper - It does not seem to start camera preview */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDCSWDecoderComponent : UIView

-(void) enable:(BOOL)enable;
-(BOOL) isEnabled;
-(void)dispose;
@end

NS_ASSUME_NONNULL_END
