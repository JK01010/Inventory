//
//  KDCSWConstants.h
//  KDCReader
//
//  Created by koamtac on 2020/03/03.
//  Copyright © 2020 AISolution. All rights reserved.
//

#ifndef KDCSWConstants_h
#define KDCSWConstants_h

/*!
 * @enum SWDecoderCameraType
 */
typedef NS_ENUM(NSInteger, SWDecoderCameraType)
{
    /*! The first rear facing camera found */
    CAMERA_TYPE_REAR_FACING,
    
    /*! The first front facing camera found */
    CAMERA_TYPE_FRONT_FACING,
};

/*!
 * @enum SWDecoderWindowMode
 */
typedef NS_ENUM(NSInteger, SWDecoderWindowMode)
{
    /*! Windowing disabled, full image is decoded */
    WINDOW_MODE_OFF,
    
    /*! Only barcodes that are within or crossing the defined window will be decoded  */
    WINDOW_MODE_CENTERING,
    
    /*! Only barcodes completely within the defined window will be decoded */
    WINDOW_MODE_WINDOWING
};

static const int OCR_ACTIVE_USER_TEMPLATE = 1;
static const int OCR_ACTIVE_PASSPORT_TEMPLATE = 2;
static const int OCR_ACTIVE_ISBN_TEMPLATE = 4;
static const int OCR_ACTIVE_PRICE_FIELD_TEMPLATE = 8;
static const int OCR_ACTIVE_MICR_TEMPLATE = 16;


#endif /* KDCSWConstants_h */
