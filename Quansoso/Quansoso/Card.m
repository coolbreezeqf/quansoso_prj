//
//  Card.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Card.h"


NSString *const kCardStocks = @"stocks";
NSString *const kCardTimeType = @"time_type";
NSString *const kCardUseCount = @"use_count";
NSString *const kCardId = @"id";
NSString *const kCardItemRange = @"item_range";
NSString *const kCardSourceId = @"source_id";
NSString *const kCardDiscountRate = @"discount_rate";
NSString *const kCardStart = @"start";
NSString *const kCardDenomination = @"denomination";
NSString *const kCardMerchantId = @"merchant_id";
NSString *const kCardSold = @"sold";
NSString *const kCardLikeCount = @"like_count";
NSString *const kCardExpression = @"expression";
NSString *const kCardMoneyCondition = @"money_condition";
NSString *const kCardPeriod = @"period";
NSString *const kCardLastModified = @"last_modified";
NSString *const kCardEnd = @"end";
NSString *const kCardChannel = @"channel";
NSString *const kCardShopType = @"shop_type";
NSString *const kCardQuantityCondition = @"quantity_condition";
NSString *const kCardSetData = @"set_data";
NSString *const kCardArea = @"area";
NSString *const kCardSource = @"source";
NSString *const kCardPicUrl = @"pic_url";
NSString *const kCardName = @"name";
NSString *const kCardGmtCreated = @"gmt_created";
NSString *const kCardCooperationItem = @"cooperation_item";
NSString *const kCardCategoryCode = @"category_code";
NSString *const kCardIsCrazy = @"is_crazy";
NSString *const kCardStatus = @"status";
NSString *const kCardPic2Url = @"pic2_url";
NSString *const kCardCooperation = @"cooperation";
NSString *const kCardCardType = @"card_type";
NSString *const kCardMerchant = @"merchant";
NSString *const kCardRecommend = @"recommend";
NSString *const kCardCategoryId = @"category_id";
NSString *const kCardExchangeType = @"exchange_type";
NSString *const kCardGmtModified = @"gmt_modified";
NSString *const kCardLimited = @"limited";


@interface Card ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Card

@synthesize stocks = _stocks;
@synthesize timeType = _timeType;
@synthesize useCount = _useCount;
@synthesize cardIdentifier = _cardIdentifier;
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
            self.stocks = [self objectOrNilForKey:kCardStocks fromDictionary:dict];
            self.timeType = [self objectOrNilForKey:kCardTimeType fromDictionary:dict];
            self.useCount = [self objectOrNilForKey:kCardUseCount fromDictionary:dict];
            self.cardIdentifier = [self objectOrNilForKey:kCardId fromDictionary:dict];
            self.itemRange = [self objectOrNilForKey:kCardItemRange fromDictionary:dict];
            self.sourceId = [self objectOrNilForKey:kCardSourceId fromDictionary:dict];
            self.discountRate = [self objectOrNilForKey:kCardDiscountRate fromDictionary:dict];
            self.start = [self objectOrNilForKey:kCardStart fromDictionary:dict];
            self.denomination = [self objectOrNilForKey:kCardDenomination fromDictionary:dict];
            self.merchantId = [self objectOrNilForKey:kCardMerchantId fromDictionary:dict];
            self.sold = [self objectOrNilForKey:kCardSold fromDictionary:dict];
            self.likeCount = [self objectOrNilForKey:kCardLikeCount fromDictionary:dict];
            self.expression = [self objectOrNilForKey:kCardExpression fromDictionary:dict];
            self.moneyCondition = [self objectOrNilForKey:kCardMoneyCondition fromDictionary:dict];
            self.period = [self objectOrNilForKey:kCardPeriod fromDictionary:dict];
            self.lastModified = [self objectOrNilForKey:kCardLastModified fromDictionary:dict];
            self.endProperty = [self objectOrNilForKey:kCardEnd fromDictionary:dict];
            self.channel = [self objectOrNilForKey:kCardChannel fromDictionary:dict];
            self.shopType = [self objectOrNilForKey:kCardShopType fromDictionary:dict];
            self.quantityCondition = [self objectOrNilForKey:kCardQuantityCondition fromDictionary:dict];
            self.setData = [self objectOrNilForKey:kCardSetData fromDictionary:dict];
            self.area = [self objectOrNilForKey:kCardArea fromDictionary:dict];
            self.source = [self objectOrNilForKey:kCardSource fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kCardPicUrl fromDictionary:dict];
            self.name = [self objectOrNilForKey:kCardName fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kCardGmtCreated fromDictionary:dict];
            self.cooperationItem = [self objectOrNilForKey:kCardCooperationItem fromDictionary:dict];
            self.categoryCode = [self objectOrNilForKey:kCardCategoryCode fromDictionary:dict];
            self.isCrazy = [self objectOrNilForKey:kCardIsCrazy fromDictionary:dict];
            self.status = [self objectOrNilForKey:kCardStatus fromDictionary:dict];
            self.pic2Url = [self objectOrNilForKey:kCardPic2Url fromDictionary:dict];
            self.cooperation = [self objectOrNilForKey:kCardCooperation fromDictionary:dict];
            self.cardType = [self objectOrNilForKey:kCardCardType fromDictionary:dict];
            self.merchant = [self objectOrNilForKey:kCardMerchant fromDictionary:dict];
            self.recommend = [self objectOrNilForKey:kCardRecommend fromDictionary:dict];
            self.categoryId = [self objectOrNilForKey:kCardCategoryId fromDictionary:dict];
            self.exchangeType = [self objectOrNilForKey:kCardExchangeType fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kCardGmtModified fromDictionary:dict];
            self.limited = [self objectOrNilForKey:kCardLimited fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stocks forKey:kCardStocks];
    [mutableDict setValue:self.timeType forKey:kCardTimeType];
    [mutableDict setValue:self.useCount forKey:kCardUseCount];
    [mutableDict setValue:self.cardIdentifier forKey:kCardId];
    [mutableDict setValue:self.itemRange forKey:kCardItemRange];
    [mutableDict setValue:self.sourceId forKey:kCardSourceId];
    [mutableDict setValue:self.discountRate forKey:kCardDiscountRate];
    [mutableDict setValue:self.start forKey:kCardStart];
    [mutableDict setValue:self.denomination forKey:kCardDenomination];
    [mutableDict setValue:self.merchantId forKey:kCardMerchantId];
    [mutableDict setValue:self.sold forKey:kCardSold];
    [mutableDict setValue:self.likeCount forKey:kCardLikeCount];
    [mutableDict setValue:self.expression forKey:kCardExpression];
    [mutableDict setValue:self.moneyCondition forKey:kCardMoneyCondition];
    [mutableDict setValue:self.period forKey:kCardPeriod];
    [mutableDict setValue:self.lastModified forKey:kCardLastModified];
    [mutableDict setValue:self.endProperty forKey:kCardEnd];
    [mutableDict setValue:self.channel forKey:kCardChannel];
    [mutableDict setValue:self.shopType forKey:kCardShopType];
    [mutableDict setValue:self.quantityCondition forKey:kCardQuantityCondition];
    [mutableDict setValue:self.setData forKey:kCardSetData];
    [mutableDict setValue:self.area forKey:kCardArea];
    [mutableDict setValue:self.source forKey:kCardSource];
    [mutableDict setValue:self.picUrl forKey:kCardPicUrl];
    [mutableDict setValue:self.name forKey:kCardName];
    [mutableDict setValue:self.gmtCreated forKey:kCardGmtCreated];
    [mutableDict setValue:self.cooperationItem forKey:kCardCooperationItem];
    [mutableDict setValue:self.categoryCode forKey:kCardCategoryCode];
    [mutableDict setValue:self.isCrazy forKey:kCardIsCrazy];
    [mutableDict setValue:self.status forKey:kCardStatus];
    [mutableDict setValue:self.pic2Url forKey:kCardPic2Url];
    [mutableDict setValue:self.cooperation forKey:kCardCooperation];
    [mutableDict setValue:self.cardType forKey:kCardCardType];
    [mutableDict setValue:self.merchant forKey:kCardMerchant];
    [mutableDict setValue:self.recommend forKey:kCardRecommend];
    [mutableDict setValue:self.categoryId forKey:kCardCategoryId];
    [mutableDict setValue:self.exchangeType forKey:kCardExchangeType];
    [mutableDict setValue:self.gmtModified forKey:kCardGmtModified];
    [mutableDict setValue:self.limited forKey:kCardLimited];

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

    self.stocks = [aDecoder decodeObjectForKey:kCardStocks];
    self.timeType = [aDecoder decodeObjectForKey:kCardTimeType];
    self.useCount = [aDecoder decodeObjectForKey:kCardUseCount];
    self.cardIdentifier = [aDecoder decodeObjectForKey:kCardId];
    self.itemRange = [aDecoder decodeObjectForKey:kCardItemRange];
    self.sourceId = [aDecoder decodeObjectForKey:kCardSourceId];
    self.discountRate = [aDecoder decodeObjectForKey:kCardDiscountRate];
    self.start = [aDecoder decodeObjectForKey:kCardStart];
    self.denomination = [aDecoder decodeObjectForKey:kCardDenomination];
    self.merchantId = [aDecoder decodeObjectForKey:kCardMerchantId];
    self.sold = [aDecoder decodeObjectForKey:kCardSold];
    self.likeCount = [aDecoder decodeObjectForKey:kCardLikeCount];
    self.expression = [aDecoder decodeObjectForKey:kCardExpression];
    self.moneyCondition = [aDecoder decodeObjectForKey:kCardMoneyCondition];
    self.period = [aDecoder decodeObjectForKey:kCardPeriod];
    self.lastModified = [aDecoder decodeObjectForKey:kCardLastModified];
    self.endProperty = [aDecoder decodeObjectForKey:kCardEnd];
    self.channel = [aDecoder decodeObjectForKey:kCardChannel];
    self.shopType = [aDecoder decodeObjectForKey:kCardShopType];
    self.quantityCondition = [aDecoder decodeObjectForKey:kCardQuantityCondition];
    self.setData = [aDecoder decodeObjectForKey:kCardSetData];
    self.area = [aDecoder decodeObjectForKey:kCardArea];
    self.source = [aDecoder decodeObjectForKey:kCardSource];
    self.picUrl = [aDecoder decodeObjectForKey:kCardPicUrl];
    self.name = [aDecoder decodeObjectForKey:kCardName];
    self.gmtCreated = [aDecoder decodeObjectForKey:kCardGmtCreated];
    self.cooperationItem = [aDecoder decodeObjectForKey:kCardCooperationItem];
    self.categoryCode = [aDecoder decodeObjectForKey:kCardCategoryCode];
    self.isCrazy = [aDecoder decodeObjectForKey:kCardIsCrazy];
    self.status = [aDecoder decodeObjectForKey:kCardStatus];
    self.pic2Url = [aDecoder decodeObjectForKey:kCardPic2Url];
    self.cooperation = [aDecoder decodeObjectForKey:kCardCooperation];
    self.cardType = [aDecoder decodeObjectForKey:kCardCardType];
    self.merchant = [aDecoder decodeObjectForKey:kCardMerchant];
    self.recommend = [aDecoder decodeObjectForKey:kCardRecommend];
    self.categoryId = [aDecoder decodeObjectForKey:kCardCategoryId];
    self.exchangeType = [aDecoder decodeObjectForKey:kCardExchangeType];
    self.gmtModified = [aDecoder decodeObjectForKey:kCardGmtModified];
    self.limited = [aDecoder decodeObjectForKey:kCardLimited];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stocks forKey:kCardStocks];
    [aCoder encodeObject:_timeType forKey:kCardTimeType];
    [aCoder encodeObject:_useCount forKey:kCardUseCount];
    [aCoder encodeObject:_cardIdentifier forKey:kCardId];
    [aCoder encodeObject:_itemRange forKey:kCardItemRange];
    [aCoder encodeObject:_sourceId forKey:kCardSourceId];
    [aCoder encodeObject:_discountRate forKey:kCardDiscountRate];
    [aCoder encodeObject:_start forKey:kCardStart];
    [aCoder encodeObject:_denomination forKey:kCardDenomination];
    [aCoder encodeObject:_merchantId forKey:kCardMerchantId];
    [aCoder encodeObject:_sold forKey:kCardSold];
    [aCoder encodeObject:_likeCount forKey:kCardLikeCount];
    [aCoder encodeObject:_expression forKey:kCardExpression];
    [aCoder encodeObject:_moneyCondition forKey:kCardMoneyCondition];
    [aCoder encodeObject:_period forKey:kCardPeriod];
    [aCoder encodeObject:_lastModified forKey:kCardLastModified];
    [aCoder encodeObject:_endProperty forKey:kCardEnd];
    [aCoder encodeObject:_channel forKey:kCardChannel];
    [aCoder encodeObject:_shopType forKey:kCardShopType];
    [aCoder encodeObject:_quantityCondition forKey:kCardQuantityCondition];
    [aCoder encodeObject:_setData forKey:kCardSetData];
    [aCoder encodeObject:_area forKey:kCardArea];
    [aCoder encodeObject:_source forKey:kCardSource];
    [aCoder encodeObject:_picUrl forKey:kCardPicUrl];
    [aCoder encodeObject:_name forKey:kCardName];
    [aCoder encodeObject:_gmtCreated forKey:kCardGmtCreated];
    [aCoder encodeObject:_cooperationItem forKey:kCardCooperationItem];
    [aCoder encodeObject:_categoryCode forKey:kCardCategoryCode];
    [aCoder encodeObject:_isCrazy forKey:kCardIsCrazy];
    [aCoder encodeObject:_status forKey:kCardStatus];
    [aCoder encodeObject:_pic2Url forKey:kCardPic2Url];
    [aCoder encodeObject:_cooperation forKey:kCardCooperation];
    [aCoder encodeObject:_cardType forKey:kCardCardType];
    [aCoder encodeObject:_merchant forKey:kCardMerchant];
    [aCoder encodeObject:_recommend forKey:kCardRecommend];
    [aCoder encodeObject:_categoryId forKey:kCardCategoryId];
    [aCoder encodeObject:_exchangeType forKey:kCardExchangeType];
    [aCoder encodeObject:_gmtModified forKey:kCardGmtModified];
    [aCoder encodeObject:_limited forKey:kCardLimited];
}

- (id)copyWithZone:(NSZone *)zone
{
    Card *copy = [[Card alloc] init];
    
    if (copy) {

        copy.stocks = [self.stocks copyWithZone:zone];
        copy.timeType = [self.timeType copyWithZone:zone];
        copy.useCount = [self.useCount copyWithZone:zone];
        copy.cardIdentifier = [self.cardIdentifier copyWithZone:zone];
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
