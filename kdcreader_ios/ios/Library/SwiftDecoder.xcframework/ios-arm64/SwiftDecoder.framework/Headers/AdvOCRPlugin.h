//
//  AdvOCRPlugin.h
//  HSMDecoderAPI
//
//

#import <UIKit/UIKit.h>
#import "DecodeBasePlugin.h"
#import "ARFrameForAdvPlugin.h"
NS_ASSUME_NONNULL_BEGIN

@interface AdvOCRPlugin : DecodeBasePlugin {
    
@private
HSMDecodeResultArray *ARresults;
}
@property (nonatomic, strong) UIColor *frameColor;
@property (nonatomic, strong) UIColor *touchColor;
@property (assign) BOOL isTouched;
@end

NS_ASSUME_NONNULL_END
