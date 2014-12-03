//
//  QSDayRecommends.h
//
//  Created by  C陈政旭 on 14/11/24
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QSActivity;
@class QSCards;

@interface QSDayRecommends : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *externalId;
@property (nonatomic, strong) QSCards *card;
@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *externalShopId;
@property (nonatomic, strong) NSString *couponType;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) QSActivity *activity;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
