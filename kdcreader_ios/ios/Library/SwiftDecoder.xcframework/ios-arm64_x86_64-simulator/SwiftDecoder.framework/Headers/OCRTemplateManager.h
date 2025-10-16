//
//  OCRTemplateManager.h
//  HSMDecoderAPI
//
//

#import <Foundation/Foundation.h>
#import "HSMDecodeResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface OCRTemplateManager : NSObject {
}

+ (OCRTemplateManager*) getInstance;

+ (void) disposeInstance;
-(HSMDecodeResult*)getHSMDecodeResult:(NSData*)imageData;
-(int)decryptStoreTemplate :(HSMDecodeResult*)result;
-(int)removeTemplateID:(int) templateID;
-(int)setActiveTemplateID:(int)templateID;
-(int)getActiveTemplateID;
-(void)setActiveTemplate:(int) activeTemplate;
-(int)getActiveTemplate;
@end

NS_ASSUME_NONNULL_END
