//
//  SwiftDecoder.h
//  SwiftDecoder
//
//

#import <Foundation/Foundation.h>

//! Project version number for HSMDecoderBAPI.
FOUNDATION_EXPORT double HSMDecoderBAPIVersionNumber;

//! Project version string for HSMDecoderBAPI.
FOUNDATION_EXPORT const unsigned char HSMDecoderBAPIVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SwiftDecoder/PublicHeader.h>
#import <SwiftDecoder/ActivationManager.h>
#import <SwiftDecoder/ActivationResult.h>
#import <SwiftDecoder/CameraManagerEventListener.h>
#import <SwiftDecoder/CameraManager.h>
#import <SwiftDecoder/HSMCameraPreview.h>
#import <SwiftDecoder/CameraConfig.h>
#import <SwiftDecoder/PluginResultListener.h>
#import <SwiftDecoder/SwiftPlugin.h>
#import <SwiftDecoder/PluginMonitorEventListener.h>
#import <SwiftDecoder/PluginManager.h>
#import <SwiftDecoder/PluginHelper.h>
#import <SwiftDecoder/PluginUILayer.h>
#import <SwiftDecoder/DecodeBasePlugin.h>
#import <SwiftDecoder/ARFrame.h>
#import <SwiftDecoder/AugmentedRealityPlugin.h>
#import <SwiftDecoder/PanoramicDecodePlugin.h>
#import <SwiftDecoder/PanoramicDecodePluginResultListener.h>
#import <SwiftDecoder/WindowingPlugin.h>
#import <SwiftDecoder/DecodeResultListener.h>
#import <SwiftDecoder/DefaultDecodePlugin.h>
#import <SwiftDecoder/HSMDecodeResult.h>
#import <SwiftDecoder/DecoderInterface.h>
#import <SwiftDecoder/DecoderSettings.h>
#import <SwiftDecoder/SwiftSettings.h>
#import <SwiftDecoder/Symbology.h>
#import <SwiftDecoder/BarcodeBounds.h>
#import <SwiftDecoder/HSMDecodeResultArray.h>
#import <SwiftDecoder/HSMDecoder.h>
#import <SwiftDecoder/WindowMode.h>
#import <SwiftDecoder/DecodeManager.h>
#import <SwiftDecoder/ActiveCamera.h>
#import <SwiftDecoder/OCRActiveTemplate.h>
#import <SwiftDecoder/APIVersion.h>
#import <SwiftDecoder/ActivationResponseListener.h>
#import <SwiftDecoder/MRZData.h>
#import <SwiftDecoder/MRZParser.h>
#import <SwiftDecoder/LicenseData.h>
#import <SwiftDecoder/LicenseParser.h>
#import <SwiftDecoder/MotorVehicleData.h>
#import <SwiftDecoder/MotorVehicleParser.h>
#import <SwiftDecoder/BoardingPassData.h>
#import <SwiftDecoder/BoardingPassParser.h>
#import <SwiftDecoder/StockPlugin.h>
#import <SwiftDecoder/StockListener.h>
#import <SwiftDecoder/ARPluginTouchListener.h>
#import <SwiftDecoder/PriceLabelPlugin.h>
#import <SwiftDecoder/PriceLabelListener.h>
#import <SwiftDecoder/OCRTemplateModel.h>
#import <SwiftDecoder/OCRTemplateManager.h>
#import <SwiftDecoder/OCRResult.h>
#import <SwiftDecoder/OCRBounds.h>
#import <SwiftDecoder/AdvOCRPlugin.h>
#import <SwiftDecoder/ARFrameForAdvPlugin.h>
#import <SwiftDecoder/FreezeFrameListener.h>


