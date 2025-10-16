/* HONEYWELL CONFIDENTIAL AND PROPRIETARY!
 *
 * SwiftDecoder Mobile Decoding Software
 * 2015 Hand Held Products, Inc. d/b/a
 * Honeywell Scanning and Mobility
 * Patent(s): https://www.honeywellaidc.com/Pages/patents.aspx
 */

//
//  CameraManager.h
//  HSMDecoderAPI
//
//  Created by eltodesc on 11/13/13.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import "DecodeManager.h"
#import "CameraManagerEventListener.h"
#import "ActiveCamera.h"

typedef void (^Handler)(UIImage *fullResolutionImage);
typedef enum {
    /** @brief HD resolution for AVcapture Video Output */
    HD720p,
    /** @brief  Full HD resolution for AVcapture Video Output */
    FullHD1080p

}ImageResolution;
@interface CameraManager : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate,AVCapturePhotoCaptureDelegate>
{
    @private
    AVCaptureSession *captureSession;
	AVCaptureVideoPreviewLayer *previewLayer;
    AVCaptureDeviceInput *videoIn;
    AVCaptureVideoDataOutput *videoOutPreview;
    int cameraFocusMode;
    bool isAutoFocusing, isFlashEnabled,ARPluginRegistered;
    unsigned char *lastDecodedPtr, *lastImgPtrCropped ,*lastProcessedImgPtr;
    int lastDecodedImgHeight;
    int lastDecodedImgWidth;
    int lastProcessedImgHeight;
    int lastProcessedImgWidth;
    unsigned char savedImage[2073600];//supports up to 1920x1080 resolutions, may need to be increased in the future
    NSMutableArray *eventListeners;
    DecodeManager* decodeMgr;
    HSMDecodeResultArray *results;
}

@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCapturePhotoOutput *stillImageOutput;

@property (retain) NSString* videoResolution;
@property (assign) unsigned char* lastDecodedPtr;
@property (assign) unsigned char* lastProcessedImgPtr;
@property (assign) unsigned char* lastImgPtrCropped;
@property (assign) int lastDecodedImgHeight;
@property (assign) int lastDecodedImgWidth;
@property (assign) int lastProcessedImgHeight;
@property (assign) int lastProcessedImgWidth;
@property int cameraFocusMode;
@property (assign) Boolean keepCameraInitialized;
@property (copy, nonatomic) Handler handler;
@property BOOL shouldDecodeFrames;

//static singelton methods
+ (CameraManager*) getInstance;
+ (void) disposeInstance;

//instance methods
- (void) focusCamera;
- (Boolean) isAutoFocusing;
- (Boolean) isFrontCameraActive;
- (void) setVideoFrameDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate>)delegate;
- (void) removeVideoDataOutput;
- (UIImage*) getLastBarcodeImage:(BarcodeBounds*)bounds;
- (UIImage*) getLastProcessedImage;
- (UIImage*) getLastDecodedImage;
- (void)getHighResolutionImageWithCompletionHandler:(void (^)(UIImage *image))handler;
- (void) enableFlash:(Boolean)enable;
- (Boolean) enableFlashWithLevel:(float)torchLevel;
- (Boolean) isFlashEnabled;
- (void) addOnEventListener:(id<CameraManagerEventListener>)eventListener;
- (void) removeOnEventListener:(id<CameraManagerEventListener>)eventListener;
- (void) switchCameraPosition:(ActiveCamera)camera;
- (Boolean) setTorchMode:(int)mode;
- (Boolean) setFocusMode:(int)mode;
- (Boolean) setExposureMode:(int)mode;
- (Boolean) setWhiteBalanceMode:(int)mode;
- (void)startPreview;
- (void)stopPreview;
- (void) openCameraSession;
- (void) closeCameraSession;
- (Boolean)isCameraSessionOpen;
-(CGFloat) getZoomRatio;
-(void) setZoomRatio: (CGFloat)zoomRatio;
-(void)setImageResolution:(ImageResolution)resolution;
-(ImageResolution)getImageResolution;
-(Boolean) ARPluginRegistered;
- (void) RegisterARPlugin:(Boolean)isRegister;
@end
