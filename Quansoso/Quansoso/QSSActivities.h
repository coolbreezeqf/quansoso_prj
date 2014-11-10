//
//  QSSActivities.h
//
//  Created by   on 14/11/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QSSActivities : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *sourceType;
@property (nonatomic, assign) id quantityCondition;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, assign) id period;
@property (nonatomic, assign) id payType;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *timeType;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *moneyCondition;
@property (nonatomic, strong) NSString *activitiesIdentifier;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, assign) id areas;
@property (nonatomic, assign) id itemIids;
@property (nonatomic, strong) NSString *endProperty;
@property (nonatomic, assign) id describe;
@property (nonatomic, assign) id denomination;
@property (nonatomic, assign) id picUrl;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, assign) id discountRate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
