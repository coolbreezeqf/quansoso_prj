//
//  QSActivities.h
//
//  Created by qf  on 14/10/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QSActivities : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sourceType;
@property (nonatomic, assign) id quantityCondition;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *period;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *timeType;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *moneyCondition;
@property (nonatomic, strong) NSString *activitiesIdentifier;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, strong) NSString *areas;
@property (nonatomic, strong) NSString *itemIids;
@property (nonatomic, strong) NSString *endProperty;
@property (nonatomic, strong) NSString *describe;
@property (nonatomic, strong) NSString *denomination;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *discountRate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
