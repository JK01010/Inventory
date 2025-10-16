//
//  KDCLedState.h
//  KDCReader
//
//  Created by koamtac on 17/10/2019.
//  Copyright © 2019 AISolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDCConstants.h"

@interface KDCLedState : NSObject

/*! LED ID */
@property (nonatomic, readonly)enum LEDId id;

/*!
 * LED Color
 * @note If it is LED_COLOR_CUSTOM, RGB value is required. Blue is not supported yet.
 */
@property (nonatomic)enum LEDColor color;

/*! Turn on or off */
@property bool on;

/*! LED Brightness level [0, 255] */
@property uint8_t brightness;

/*!
 * LED RGB value
 * @note It effects only when LED Color type is LED_COLOR_CUSTOM. Blue is not supported yet.
 */
@property (nonatomic)uint32_t rgb;

- (id)initWithId:(LEDId) id;

@end
