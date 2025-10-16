//
//  KDCSWDecoderSetting.h
//  KDCReader
//
//  Created by koamtac on 2020/02/20.
//  Copyright © 2020 AISolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KDCSWConstants.h"

#if (1)
#if !defined(DEPRECATED)
#define DEPRECATED
#endif
#else
#if !defined(DEPRECATED)
#define DEPRECATED __deprecated
#endif
#endif

NS_ASSUME_NONNULL_BEGIN

@interface KDCSWDecoderSetting : NSObject

/*!
 *  Enable or disable the camera flash on a barcode scan attempt (if the device supports it)
 *
 *  @param isEnable Enable or disable flash
 */
- (void) EnableFlashOnDecode:(BOOL)isEnable;

/*!
 * Enable or disable an audible beep on a successful decode
 *
 * @param isEnable Enable or disable audio
 */
- (void) EnableSound:(BOOL)isEnable;

/*!
 * @deprecated This API is deprecated starting in version 3.06.00.SW15.
 * Enable or disable an aimer that will be displayed on the preview screen
 *
 * @param isEnable Enable or disable aimer
 */
- (void) EnableAimter: (BOOL)isEnable DEPRECATED;

/*!
 * Enable or disable an aimer that will be displayed on the preview screen
 *
 * @param isEnable Enable or disable aimer
 */
- (void) EnableAimer: (BOOL)isEnable;

/*!
 *  Set the color of the camera aimer graphic
 *
 *  @param color The desired color value of the aimer graphic (ex. Color.Red)
 */
- (void) SetAimerColor: (UIColor *) color;

/*!
 *  Set the text of the overlay on the camera preview screen
 *
 *  @param text The desired text
 */
- (void) SetOverlayText: (NSString *)text;

/*!
 *  Set the color of the text overlay
 *
 *  @param color The desired color value of the text overlay (ex. Color.Red)
 */
- (void) SetOverlayTextColor: (UIColor *) color;

/*!
 * Enable or disable decoding and is enabled by default (Note: The only affects the HSMDecodeComponent)
 *
 * @param isEnable The enable state of the decoder
 */
- (void) EnableDecoding: (BOOL) isEnable;

/*!
 * Set the camera that will be used for decoding
 *
 * @param type The camera type
 */
- (void) SetActiveCameraType: (SWDecoderCameraType) type;

/*!
 *  Immediately turns on/off the camera flash (if the device supports it)
 *
 *  @param isEnable Enable or disable flash
 */
- (void) ToggleFlash: (BOOL) isEnable;

/*!
 * Set the Active OCR Template
 *
 * @param activeTemplate The active OCR template
 */
- (void) SetOCRActiveTemplate: (int) activeTemplate;

/*!
 * Set the OCR user template
 *
 * @param userTemplate The OCR template used in USER mode
 */
- (void) SetOCRUserTemplate: (char *) userTemplate;

/*!
 *  Windowing allows you to define a specific region within the image that will be decoded
 *
 * @param windowMode This specifies the type of windowing that will be used
 *
 */
- (void) SetWindowMode: (SWDecoderWindowMode) windowMode;

/*!
 *  This allows you to define a subset of the image to decode.
 *  Only barcodes found within the defined region will be decoded.
 *  Note: These bounds are relative to the position of the camera sensor.
 *  Most devices have their camera sensor mounted in landscape mode so left=50, right=100, top=0, bottom=50 would mean the upper right quadrant of the screen.
 *
 * @param left This defines the left bound of the window as a percentage of the entire image.  (e.g. 15 would indicate: .15 * imgWidth)
 * @param right This defines the right bound of the window as a percentage of the entire image.  (e.g. 85 would indicate: .85 * imgWidth)
 * @param top This defines the top bound of the window as a percentage of the entire image.  (e.g. 15 would indicate: .15 * imgHeight)
 * @param bottom This defines the bottom bound of the window as a percentage of the entire image.  (e.g. 85 would indicate: .85 * imgHeight)
 */
- (void) SetWindowRect: (int) left right:(int) right top:(int) top bottom:(int) bottom;

/*!
 *  Set the zoom ratio of camera
 *
 *  @param zoomRatio The desired value of the zoom ratio (>=1.0)
 */
-(void) SetZoomRatio: (CGFloat)zoomRatio;

/*!
 * This method returns the enable state of the decoder (Note: The only pertains to the state of the HSMDecodeComponent)
 *
 * @return The enable state of the decoder
 */
- (BOOL) IsDecodingEnabled;

/*!
 *  Get the current state of the camera flash (if the device supports it)
 *
 *  @return flash state
 */
- (BOOL) IsFlashToggled;

/*!
 * This method returns whether or not the front camera is currently active.
 *
 * @return True if front camera is active and false otherwise.
 */
- (BOOL) IsFrontCameraActive;

/*!
 *  Get the current Windowing mode
 *
 *  @return Returns the Windowing mode that is currently set
 */
- (SWDecoderWindowMode) GetWindowMode;

/*!
 *  Get the defined subset of the image to decode.
 *  Only barcodes found within the defined region will be decoded.
 *
 *  @return Returns bounds (as a percentage) of the subset of the image to decode.  The returned array is length 4 where {left, right, top, bottom}
 */
- (NSArray *) GetWindowRect;

/*!
 * This method returns the zoom ratio of the camera.
 *
 * @return Zoom Ratio of camera.
 */
-(CGFloat) GetZoomRatio;

@end

NS_ASSUME_NONNULL_END
