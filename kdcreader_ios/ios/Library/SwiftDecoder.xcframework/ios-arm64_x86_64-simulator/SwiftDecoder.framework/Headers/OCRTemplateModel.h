//
//  OCRTemplateModel.h
//  HSMDecoderAPI
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenOCRExtended : NSObject
@property(assign) int typeCnt;
@property(retain) NSMutableArray *typeArray;
@end

@interface OpenOCRExtendedType : NSObject
@property(assign) int type;
@property(assign) int subtypeCnt;
@property(retain) NSArray *subtypeArray;
@end

@interface Tags : NSObject <NSCoding>
@property(assign) int xCoord;

@property(assign) int yCoord;

@property(assign) int height;

@property(assign) int width;

@property(assign) int tagType;

@property(retain) NSString *label;

@property(retain) NSString *whiteList;

@property(retain) NSString *ignorepercentage;

@property(assign) int suppress;

@property(assign) int align;

@property(retain) OpenOCRExtended *extendedType;

@end


@interface OCRTemplateModel : NSObject <NSCoding>
@property(retain) NSString *version;
@property(retain) NSArray *tags;
@property(retain) NSString *uniqueKey;

+(OCRTemplateModel *)deserializeJSONintoTemplateData:(NSString*)jsonString;

@end

NS_ASSUME_NONNULL_END
