//
//  PriceLabelPlugin.h
//  SwiftDecoder
//
//  Created by H504285 on 13/05/22.
//

#import "DecodeBasePlugin.h"
#import "PriceLabelListener.h"
#import "ARPluginTouchListener.h"
NS_ASSUME_NONNULL_BEGIN

@interface PriceLabelPlugin : DecodeBasePlugin <PriceLabelListener> {

@private
HSMDecodeResultArray *ARresults;
}

@property (nonatomic, strong) UIColor *frameColor;
@property (nonatomic, strong) UIColor *touchColor;


/**
@brief This method changes the color of the Accent(frame and number text)

@param color accent color that has to be set
*/
- (void)setAccentColor:(UIColor *)color;

/**
@brief  Only override drawRect: if you perform custom drawing. An empty implementation adversely affects performance during animation.

@param rect The portion of the view’s bounds that needs to be updated.
*/
-(void)drawRect:(CGRect)rect;

/**
* @brief Called when video preview comes to the foreground. This should be used to initialize the plug-in on each scan attempt.
*/
- (void)onStart;

/**
* @brief Called when a barcode(s) has been decoded in the image
*
* @param results
*      An array results for all decode barcodes
*/
-(void)onDecode:(HSMDecodeResultArray *)results;

/**
* @brief Called each time a frame cannot be successfully decoded
*/
-(void)onDecodeFailed;

/**
* @brief sets the  image icon for price plugin view
*
* @param image
*      UIImage that needs to be set as icon.
*/

-(void)setPriceLabelIcon:(UIImage*)image;

/**
 * @brief Adds a listener for plug-in results/notifications
 *
 * @param resultListener
 *      This listener that will be notified of any results/notifications on clicking on stock
 *
 */
- (void)addOnPricePluginTouchListener:(id<ARPluginTouchListener>)resultListener;

/**
 * @brief This method returns the type of label.
 *
 * @return
 *  Returns integer indicating the type of label
 */
- (int)getLabelType;

/**
* @brief sets the  label type for price plugin for OCR detection
*
* @param labelType
*      Integer value that indicates the type of label
*/
-(void)setLabelType:(int)labelType;

/**
* @brief sets the display time  for price plugin
*
* @param displayTime
*      boolean value that sets display time
*/
-(void)setDisplayTime:(Boolean)displayTime;

@end

NS_ASSUME_NONNULL_END

