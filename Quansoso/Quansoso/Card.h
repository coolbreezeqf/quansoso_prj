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
@property (nonatomic, strong) NSString *cardIdentifier; //id
@property (nonatomic, strong) NSString *itemRange;
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *discountRate;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *denomination;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *sold;
@property (nonatomic, strong) NSString *likeCount;
@property (nonatomic, strong) NSString *expression;
@property (nonatomic, strong) NSString *moneyCondition;
@property (nonatomic, strong) NSString *period;
@property (nonatomic, strong) NSString *lastModified;
@property (nonatomic, strong) NSString *endProperty;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *shopType;
@property (nonatomic, strong) NSString *quantityCondition;
@property (nonatomic, strong) NSString *setData;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, strong) NSString *cooperationItem;
@property (nonatomic, strong) NSString *categoryCode;
@property (nonatomic, strong) NSString *isCrazy;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *pic2Url;
@property (nonatomic, strong) NSString *cooperation;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSString *merchant;
@property (nonatomic, strong) NSString *recommend;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *exchangeType;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *limited;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
