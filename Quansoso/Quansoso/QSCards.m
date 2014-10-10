//
//  QSCards.m
//
//  Created by qf  on 14/10/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSCards.h"


NSString *const kQSCardsStocks = @"stocks";
NSString *const kQSCardsTimeType = @"time_type";
NSString *const kQSCardsUseCount = @"use_count";
NSString *const kQSCardsId = @"id";
NSString *const kQSCardsItemRange = @"item_range";
NSString *const kQSCardsSourceId = @"source_id";
NSString *const kQSCardsDiscountRate = @"discount_rate";
NSString *const kQSCardsStart = @"start";
NSString *const kQSCardsDenomination = @"denomination";
NSString *const kQSCardsMerchantId = @"merchant_id";
NSString *const kQSCardsSold = @"sold";
NSString *const kQSCardsLikeCount = @"like_count";
NSString *const kQSCardsExpression = @"expression";
NSString *const kQSCardsMoneyCondition = @"money_condition";
NSString *const kQSCardsPeriod = @"period";
NSString *const kQSCardsLastModified = @"last_modified";
NSString *const kQSCardsEnd = @"end";
NSString *const kQSCardsChannel = @"channel";
NSString *const kQSCardsShopType = @"shop_type";
NSString *const kQSCardsQuantityCondition = @"quantity_condition";
NSString *const kQSCardsSetData = @"set_data";
NSString *const kQSCardsArea = @"area";
NSString *const kQSCardsSource = @"source";
NSString *const kQSCardsPicUrl = @"pic_url";
NSString *const kQSCardsName = @"name";
NSString *const kQSCardsGmtCreated = @"gmt_created";
NSString *const kQSCardsCooperationItem = @"cooperation_item";
NSString *const kQSCardsCategoryCode = @"category_code";
NSString *const kQSCardsIsCrazy = @"is_crazy";
NSString *const kQSCardsStatus = @"status";
NSString *const kQSCardsPic2Url = @"pic2_url";
NSString *const kQSCardsCooperation = @"cooperation";
NSString *const kQSCardsCardType = @"card_type";
NSString *const kQSCardsMerchant = @"merchant";
NSString *const kQSCardsRecommend = @"recommend";
NSString *const kQSCardsCategoryId = @"category_id";
NSString *const kQSCardsExchangeType = @"exchange_type";
NSString *const kQSCardsGmtModified = @"gmt_modified";
NSString *const kQSCardsLimited = @"limited";


@interface QSCards ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSCards

@synthesize stocks = _stocks;
@synthesize timeType = _timeType;
@synthesize useCount = _useCount;
@synthesize cardsIdentifier = _cardsIdentifier;
@synthesize itemRange = _itemRange;
@synthesize sourceId = _sourceId;
@synthesize discountRate = _discountRate;
@synthesize start = _start;
@synthesize denomination = _denomination;
@synthesize merchantId = _merchantId;
@synthesize sold = _sold;
@synthesize likeCount = _likeCount;
@synthesize expression = _expression;
@synthesize moneyCondition = _moneyCondition;
@synthesize period = _period;
@synthesize lastModified = _lastModified;
@synthesize endProperty = _endProperty;
@synthesize channel = _channel;
@synthesize shopType = _shopType;
@synthesize quantityCondition = _quantityCondition;
@synthesize setData = _setData;
@synthesize area = _area;
@synthesize source = _source;
@synthesize picUrl = _picUrl;
@synthesize name = _name;
@synthesize gmtCreated = _gmtCreated;
@synthesize cooperationItem = _cooperationItem;
@synthesize categoryCode = _categoryCode;
@synthesize isCrazy = _isCrazy;
@synthesize status = _status;
@synthesize pic2Url = _pic2Url;
@synthesize cooperation = _cooperation;
@synthesize cardType = _cardType;
@synthesize merchant = _merchant;
@synthesize recommend = _recommend;
@synthesize categoryId = _categoryId;
@synthesize exchangeType = _exchangeType;
@synthesize gmtModified = _gmtModified;
@synthesize limited = _limited;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.stocks = [self objectOrNilForKey:kQSCardsStocks fromDictionary:dict];
            self.timeType = [self objectOrNilForKey:kQSCardsTimeType fromDictionary:dict];
            self.useCount = [self objectOrNilForKey:kQSCardsUseCount fromDictionary:dict];
            self.cardsIdentifier = [self objectOrNilForKey:kQSCardsId fromDictionary:dict];
            self.itemRange = [self objectOrNilForKey:kQSCardsItemRange fromDictionary:dict];
            self.sourceId = [self objectOrNilForKey:kQSCardsSourceId fromDictionary:dict];
            self.discountRate = [self objectOrNilForKey:kQSCardsDiscountRate fromDictionary:dict];
            self.start = [self objectOrNilForKey:kQSCardsStart fromDictionary:dict];
            self.denomination = [self objectOrNilForKey:kQSCardsDenomination fromDictionary:dict];
            self.merchantId = [self objectOrNilForKey:kQSCardsMerchantId fromDictionary:dict];
            self.sold = [self objectOrNilForKey:kQSCardsSold fromDictionary:dict];
            self.likeCount = [self objectOrNilForKey:kQSCardsLikeCount fromDictionary:dict];
            self.expression = [self objectOrNilForKey:kQSCardsExpression fromDictionary:dict];
            self.moneyCondition = [self objectOrNilForKey:kQSCardsMoneyCondition fromDictionary:dict];
            self.period = [self objectOrNilForKey:kQSCardsPeriod fromDictionary:dict];
            self.lastModified = [self objectOrNilForKey:kQSCardsLastModified fromDictionary:dict];
            self.endProperty = [self objectOrNilForKey:kQSCardsEnd fromDictionary:dict];
            self.channel = [self objectOrNilForKey:kQSCardsChannel fromDictionary:dict];
            self.shopType = [self objectOrNilForKey:kQSCardsShopType fromDictionary:dict];
            self.quantityCondition = [self objectOrNilForKey:kQSCardsQuantityCondition fromDictionary:dict];
            self.setData = [self objectOrNilForKey:kQSCardsSetData fromDictionary:dict];
            self.area = [self objectOrNilForKey:kQSCardsArea fromDictionary:dict];
            self.source = [self objectOrNilForKey:kQSCardsSource fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSCardsPicUrl fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQSCardsName fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kQSCardsGmtCreated fromDictionary:dict];
            self.cooperationItem = [self objectOrNilForKey:kQSCardsCooperationItem fromDictionary:dict];
            self.categoryCode = [self objectOrNilForKey:kQSCardsCategoryCode fromDictionary:dict];
            self.isCrazy = [self objectOrNilForKey:kQSCardsIsCrazy fromDictionary:dict];
            self.status = [self objectOrNilForKey:kQSCardsStatus fromDictionary:dict];
            self.pic2Url = [self objectOrNilForKey:kQSCardsPic2Url fromDictionary:dict];
            self.cooperation = [self objectOrNilForKey:kQSCardsCooperation fromDictionary:dict];
            self.cardType = [self objectOrNilForKey:kQSCardsCardType fromDictionary:dict];
            self.merchant = [self objectOrNilForKey:kQSCardsMerchant fromDictionary:dict];
            self.recommend = [self objectOrNilForKey:kQSCardsRecommend fromDictionary:dict];
            self.categoryId = [self objectOrNilForKey:kQSCardsCategoryId fromDictionary:dict];
            self.exchangeType = [self objectOrNilForKey:kQSCardsExchangeType fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSCardsGmtModified fromDictionary:dict];
            self.limited = [self objectOrNilForKey:kQSCardsLimited fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stocks forKey:kQSCardsStocks];
    [mutableDict setValue:self.timeType forKey:kQSCardsTimeType];
    [mutableDict setValue:self.useCount forKey:kQSCardsUseCount];
    [mutableDict setValue:self.cardsIdentifier forKey:kQSCardsId];
    [mutableDict setValue:self.itemRange forKey:kQSCardsItemRange];
    [mutableDict setValue:self.sourceId forKey:kQSCardsSourceId];
    [mutableDict setValue:self.discountRate forKey:kQSCardsDiscountRate];
    [mutableDict setValue:self.start forKey:kQSCardsStart];
    [mutableDict setValue:self.denomination forKey:kQSCardsDenomination];
    [mutableDict setValue:self.merchantId forKey:kQSCardsMerchantId];
    [mutableDict setValue:self.sold forKey:kQSCardsSold];
    [mutableDict setValue:self.likeCount forKey:kQSCardsLikeCount];
    [mutableDict setValue:self.expression forKey:kQSCardsExpression];
    [mutableDict setValue:self.moneyCondition forKey:kQSCardsMoneyCondition];
    [mutableDict setValue:self.period forKey:kQSCardsPeriod];
    [mutableDict setValue:self.lastModified forKey:kQSCardsLastModified];
    [mutableDict setValue:self.endProperty forKey:kQSCardsEnd];
    [mutableDict setValue:self.channel forKey:kQSCardsChannel];
    [mutableDict setValue:self.shopType forKey:kQSCardsShopType];
    [mutableDict setValue:self.quantityCondition forKey:kQSCardsQuantityCondition];
    [mutableDict setValue:self.setData forKey:kQSCardsSetData];
    [mutableDict setValue:self.area forKey:kQSCardsArea];
    [mutableDict setValue:self.source forKey:kQSCardsSource];
    [mutableDict setValue:self.picUrl forKey:kQSCardsPicUrl];
    [mutableDict setValue:self.name forKey:kQSCardsName];
    [mutableDict setValue:self.gmtCreated forKey:kQSCardsGmtCreated];
    [mutableDict setValue:self.cooperationItem forKey:kQSCardsCooperationItem];
    [mutableDict setValue:self.categoryCode forKey:kQSCardsCategoryCode];
    [mutableDict setValue:self.isCrazy forKey:kQSCardsIsCrazy];
    [mutableDict setValue:self.status forKey:kQSCardsStatus];
    [mutableDict setValue:self.pic2Url forKey:kQSCardsPic2Url];
    [mutableDict setValue:self.cooperation forKey:kQSCardsCooperation];
    [mutableDict setValue:self.cardType forKey:kQSCardsCardType];
    [mutableDict setValue:self.merchant forKey:kQSCardsMerchant];
    [mutableDict setValue:self.recommend forKey:kQSCardsRecommend];
    [mutableDict setValue:self.categoryId forKey:kQSCardsCategoryId];
    [mutableDict setValue:self.exchangeType forKey:kQSCardsExchangeType];
    [mutableDict setValue:self.gmtModified forKey:kQSCardsGmtModified];
    [mutableDict setValue:self.limited forKey:kQSCardsLimited];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.stocks = [aDecoder decodeObjectForKey:kQSCardsStocks];
    self.timeType = [aDecoder decodeObjectForKey:kQSCardsTimeType];
    self.useCount = [aDecoder decodeObjectForKey:kQSCardsUseCount];
    self.cardsIdentifier = [aDecoder decodeObjectForKey:kQSCardsId];
    self.itemRange = [aDecoder decodeObjectForKey:kQSCardsItemRange];
    self.sourceId = [aDecoder decodeObjectForKey:kQSCardsSourceId];
    self.discountRate = [aDecoder decodeObjectForKey:kQSCardsDiscountRate];
    self.start = [aDecoder decodeObjectForKey:kQSCardsStart];
    self.denomination = [aDecoder decodeObjectForKey:kQSCardsDenomination];
    self.merchantId = [aDecoder decodeObjectForKey:kQSCardsMerchantId];
    self.sold = [aDecoder decodeObjectForKey:kQSCardsSold];
    self.likeCount = [aDecoder decodeObjectForKey:kQSCardsLikeCount];
    self.expression = [aDecoder decodeObjectForKey:kQSCardsExpression];
    self.moneyCondition = [aDecoder decodeObjectForKey:kQSCardsMoneyCondition];
    self.period = [aDecoder decodeObjectForKey:kQSCardsPeriod];
    self.lastModified = [aDecoder decodeObjectForKey:kQSCardsLastModified];
    self.endProperty = [aDecoder decodeObjectForKey:kQSCardsEnd];
    self.channel = [aDecoder decodeObjectForKey:kQSCardsChannel];
    self.shopType = [aDecoder decodeObjectForKey:kQSCardsShopType];
    self.quantityCondition = [aDecoder decodeObjectForKey:kQSCardsQuantityCondition];
    self.setData = [aDecoder decodeObjectForKey:kQSCardsSetData];
    self.area = [aDecoder decodeObjectForKey:kQSCardsArea];
    self.source = [aDecoder decodeObjectForKey:kQSCardsSource];
    self.picUrl = [aDecoder decodeObjectForKey:kQSCardsPicUrl];
    self.name = [aDecoder decodeObjectForKey:kQSCardsName];
    self.gmtCreated = [aDecoder decodeObjectForKey:kQSCardsGmtCreated];
    self.cooperationItem = [aDecoder decodeObjectForKey:kQSCardsCooperationItem];
    self.categoryCode = [aDecoder decodeObjectForKey:kQSCardsCategoryCode];
    self.isCrazy = [aDecoder decodeObjectForKey:kQSCardsIsCrazy];
    self.status = [aDecoder decodeObjectForKey:kQSCardsStatus];
    self.pic2Url = [aDecoder decodeObjectForKey:kQSCardsPic2Url];
    self.cooperation = [aDecoder decodeObjectForKey:kQSCardsCooperation];
    self.cardType = [aDecoder decodeObjectForKey:kQSCardsCardType];
    self.merchant = [aDecoder decodeObjectForKey:kQSCardsMerchant];
    self.recommend = [aDecoder decodeObjectForKey:kQSCardsRecommend];
    self.categoryId = [aDecoder decodeObjectForKey:kQSCardsCategoryId];
    self.exchangeType = [aDecoder decodeObjectForKey:kQSCardsExchangeType];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSCardsGmtModified];
    self.limited = [aDecoder decodeObjectForKey:kQSCardsLimited];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stocks forKey:kQSCardsStocks];
    [aCoder encodeObject:_timeType forKey:kQSCardsTimeType];
    [aCoder encodeObject:_useCount forKey:kQSCardsUseCount];
    [aCoder encodeObject:_cardsIdentifier forKey:kQSCardsId];
    [aCoder encodeObject:_itemRange forKey:kQSCardsItemRange];
    [aCoder encodeObject:_sourceId forKey:kQSCardsSourceId];
    [aCoder encodeObject:_discountRate forKey:kQSCardsDiscountRate];
    [aCoder encodeObject:_start forKey:kQSCardsStart];
    [aCoder encodeObject:_denomination forKey:kQSCardsDenomination];
    [aCoder encodeObject:_merchantId forKey:kQSCardsMerchantId];
    [aCoder encodeObject:_sold forKey:kQSCardsSold];
    [aCoder encodeObject:_likeCount forKey:kQSCardsLikeCount];
    [aCoder encodeObject:_expression forKey:kQSCardsExpression];
    [aCoder encodeObject:_moneyCondition forKey:kQSCardsMoneyCondition];
    [aCoder encodeObject:_period forKey:kQSCardsPeriod];
    [aCoder encodeObject:_lastModified forKey:kQSCardsLastModified];
    [aCoder encodeObject:_endProperty forKey:kQSCardsEnd];
    [aCoder encodeObject:_channel forKey:kQSCardsChannel];
    [aCoder encodeObject:_shopType forKey:kQSCardsShopType];
    [aCoder encodeObject:_quantityCondition forKey:kQSCardsQuantityCondition];
    [aCoder encodeObject:_setData forKey:kQSCardsSetData];
    [aCoder encodeObject:_area forKey:kQSCardsArea];
    [aCoder encodeObject:_source forKey:kQSCardsSource];
    [aCoder encodeObject:_picUrl forKey:kQSCardsPicUrl];
    [aCoder encodeObject:_name forKey:kQSCardsName];
    [aCoder encodeObject:_gmtCreated forKey:kQSCardsGmtCreated];
    [aCoder encodeObject:_cooperationItem forKey:kQSCardsCooperationItem];
    [aCoder encodeObject:_categoryCode forKey:kQSCardsCategoryCode];
    [aCoder encodeObject:_isCrazy forKey:kQSCardsIsCrazy];
    [aCoder encodeObject:_status forKey:kQSCardsStatus];
    [aCoder encodeObject:_pic2Url forKey:kQSCardsPic2Url];
    [aCoder encodeObject:_cooperation forKey:kQSCardsCooperation];
    [aCoder encodeObject:_cardType forKey:kQSCardsCardType];
    [aCoder encodeObject:_merchant forKey:kQSCardsMerchant];
    [aCoder encodeObject:_recommend forKey:kQSCardsRecommend];
    [aCoder encodeObject:_categoryId forKey:kQSCardsCategoryId];
    [aCoder encodeObject:_exchangeType forKey:kQSCardsExchangeType];
    [aCoder encodeObject:_gmtModified forKey:kQSCardsGmtModified];
    [aCoder encodeObject:_limited forKey:kQSCardsLimited];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSCards *copy = [[QSCards alloc] init];
    
    if (copy) {

        copy.stocks = [self.stocks copyWithZone:zone];
        copy.timeType = [self.timeType copyWithZone:zone];
        copy.useCount = [self.useCount copyWithZone:zone];
        copy.cardsIdentifier = [self.cardsIdentifier copyWithZone:zone];
        copy.itemRange = [self.itemRange copyWithZone:zone];
        copy.sourceId = [self.sourceId copyWithZone:zone];
        copy.discountRate = [self.discountRate copyWithZone:zone];
        copy.start = [self.start copyWithZone:zone];
        copy.denomination = [self.denomination copyWithZone:zone];
        copy.merchantId = [self.merchantId copyWithZone:zone];
        copy.sold = [self.sold copyWithZone:zone];
        copy.likeCount = [self.likeCount copyWithZone:zone];
        copy.expression = [self.expression copyWithZone:zone];
        copy.moneyCondition = [self.moneyCondition copyWithZone:zone];
        copy.period = [self.period copyWithZone:zone];
        copy.lastModified = [self.lastModified copyWithZone:zone];
        copy.endProperty = [self.endProperty copyWithZone:zone];
        copy.channel = [self.channel copyWithZone:zone];
        copy.shopType = [self.shopType copyWithZone:zone];
        copy.quantityCondition = [self.quantityCondition copyWithZone:zone];
        copy.setData = [self.setData copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.gmtCreated = [self.gmtCreated copyWithZone:zone];
        copy.cooperationItem = [self.cooperationItem copyWithZone:zone];
        copy.categoryCode = [self.categoryCode copyWithZone:zone];
        copy.isCrazy = [self.isCrazy copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.pic2Url = [self.pic2Url copyWithZone:zone];
        copy.cooperation = [self.cooperation copyWithZone:zone];
        copy.cardType = [self.cardType copyWithZone:zone];
        copy.merchant = [self.merchant copyWithZone:zone];
        copy.recommend = [self.recommend copyWithZone:zone];
        copy.categoryId = [self.categoryId copyWithZone:zone];
        copy.exchangeType = [self.exchangeType copyWithZone:zone];
        copy.gmtModified = [self.gmtModified copyWithZone:zone];
        copy.limited = [self.limited copyWithZone:zone];
    }
    
    return copy;
}


@end
