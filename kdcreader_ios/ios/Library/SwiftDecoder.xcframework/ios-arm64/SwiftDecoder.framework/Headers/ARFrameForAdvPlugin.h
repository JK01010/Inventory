//
//  ARFrameForAdvPlugin.h
//  HSMDecoderAPI
//
//  Created by H454944 on 17/10/22.
//

#import "HSMDecodeResult.h"

@interface ARFrameForAdvPlugin : NSObject

@property (nonatomic, strong) HSMDecodeResult *result;
@property (nonatomic, assign) CGPoint tl;
@property (nonatomic, assign) CGPoint tr;
@property (nonatomic, assign) CGPoint bl;
@property (nonatomic, assign) CGPoint br;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isFrameBarcode;

- (instancetype)initWithResult:(HSMDecodeResult*)result
                       topLeft:(CGPoint)tl
                      topRight:(CGPoint)tr
                    bottomLeft:(CGPoint)bl
                   bottomRight:(CGPoint)br
                        number:(int)number;

- (CGPoint)getCentroid;
- (BOOL)isPointWithin:(CGPoint)point;

@end

