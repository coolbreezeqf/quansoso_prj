//
//  Card.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//卡券详情

@interface Card : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *stocks;
@property (nonatomic, strong) NSString *timeType;
@property (nonatomic, strong) NSString *useCount;
@property (nonatomic, strong) NSString *cardIdentifier;
@property (nonatomic, assign) id itemRange;
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *discountRate;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *denomination;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *sold;
@property (nonatomic, strong) NSString *likeCount;
@property (nonatomic, strong) NSString *expression;
@property (nonatomic, strong) NSString *moneyCondition;
@property (nonatomic, assign) id period;
@property (nonatomic, strong) NSString *lastModified;
@property (nonatomic, strong) NSString *endProperty;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *shopType;
@property (nonatomic, strong) NSString *quantityCondition;
@property (nonatomic, assign) id setData;
@property (nonatomic, assign) id area;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) id picUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, assign) id cooperationItem;
@property (nonatomic, assign) id categoryCode;
@property (nonatomic, assign) id isCrazy;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) id pic2Url;
@property (nonatomic, assign) id cooperation;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, assign) id recommend;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *exchangeType;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *limited;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
