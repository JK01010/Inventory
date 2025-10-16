//
//  KDCSWDecoderActivationResult.h
//  KDCReader
//
//  Created by koamtac on 2020/12/21.
//  Copyright © 2020 AISolution. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KDCSWDecoderActivationResult : NSObject

/*! Device Id */
@property (nonatomic, readonly)NSString* deviceId;

/*! Result Code */
@property (nonatomic, readonly)int resultCode;

/*! Result Message */
@property (nonatomic, readonly)NSString* resultMessage;

@end

NS_ASSUME_NONNULL_END
