//
//  QSMerchant.h
//
//  Created by qf  on 14/10/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QSMerchant : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *merchantDescription;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *websiteUrl;
@property (nonatomic, strong) NSString *tagExpression;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *shopScore;
@property (nonatomic, strong) NSString *externalLevel;
@property (nonatomic, strong) NSString *externalShopId;
@property (nonatomic, assign) id keywords;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *merchantIdentifier;
@property (nonatomic, strong) NSString *saleVolume;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *isEnter;
@property (nonatomic, strong) NSString *externalId;
@property (nonatomic, strong) NSString *ekpCategory;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *sellerId;
@property (nonatomic, strong) NSString *externalCategory;
@property (nonatomic, strong) NSString *externalCid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
