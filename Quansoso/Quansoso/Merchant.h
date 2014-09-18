//
//  Merchant.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//商家信息

@interface Merchant : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *merchantDescription;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *websiteUrl;
@property (nonatomic, assign) id tagExpression;
@property (nonatomic, assign) id brand;
@property (nonatomic, strong) NSString *shopScore;
@property (nonatomic, strong) NSString *externalLevel;
@property (nonatomic, strong) NSString *externalShopId;
@property (nonatomic, assign) id keywords;
@property (nonatomic, assign) id memo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *merchantIdentifier;
@property (nonatomic, assign) id saleVolume;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *isEnter;
@property (nonatomic, strong) NSString *externalId;
@property (nonatomic, strong) NSString *ekpCategory;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, assign) id sellerId;
@property (nonatomic, assign) id externalCategory;
@property (nonatomic, strong) NSString *externalCid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
