//
//  QSActivity.m
//
//  Created by qf  on 14/11/29
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSActivity.h"


NSString *const kQSActivityStatus = @"status";
NSString *const kQSActivitySourceType = @"source_type";
NSString *const kQSActivityQuantityCondition = @"quantity_condition";
NSString *const kQSActivitySite = @"site";
NSString *const kQSActivityPeriod = @"period";
NSString *const kQSActivityPayType = @"pay_type";
NSString *const kQSActivityMerchantId = @"merchant_id";
NSString *const kQSActivityTimeType = @"time_type";
NSString *const kQSActivityName = @"name";
NSString *const kQSActivityGmtModified = @"gmt_modified";
NSString *const kQSActivityType = @"type";
NSString *const kQSActivityMoneyCondition = @"money_condition";
NSString *const kQSActivityId = @"id";
NSString *const kQSActivityGmtCreated = @"gmt_created";
NSString *const kQSActivityAreas = @"areas";
NSString *const kQSActivityItemIids = @"item_iids";
NSString *const kQSActivityEnd = @"end";
NSString *const kQSActivityDescribe = @"describe";
NSString *const kQSActivityDenomination = @"denomination";
NSString *const kQSActivityPicUrl = @"pic_url";
NSString *const kQSActivityStart = @"start";
NSString *const kQSActivityMerchant = @"merchant";
NSString *const kQSActivityDiscountRate = @"discount_rate";


@interface QSActivity ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSActivity

@synthesize status = _status;
@synthesize sourceType = _sourceType;
@synthesize quantityCondition = _quantityCondition;
@synthesize site = _site;
@synthesize period = _period;
@synthesize payType = _payType;
@synthesize merchantId = _merchantId;
@synthesize timeType = _timeType;
@synthesize name = _name;
@synthesize gmtModified = _gmtModified;
@synthesize type = _type;
@synthesize moneyCondition = _moneyCondition;
@synthesize activityIdentifier = _activityIdentifier;
@synthesize gmtCreated = _gmtCreated;
@synthesize areas = _areas;
@synthesize itemIids = _itemIids;
@synthesize endProperty = _endProperty;
@synthesize describe = _describe;
@synthesize denomination = _denomination;
@synthesize picUrl = _picUrl;
@synthesize start = _start;
@synthesize merchant = _merchant;
@synthesize discountRate = _discountRate;


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
            self.status = [self objectOrNilForKey:kQSActivityStatus fromDictionary:dict];
            self.sourceType = [self objectOrNilForKey:kQSActivitySourceType fromDictionary:dict];
            self.quantityCondition = [self objectOrNilForKey:kQSActivityQuantityCondition fromDictionary:dict];
            self.site = [self objectOrNilForKey:kQSActivitySite fromDictionary:dict];
            self.period = [self objectOrNilForKey:kQSActivityPeriod fromDictionary:dict];
            self.payType = [self objectOrNilForKey:kQSActivityPayType fromDictionary:dict];
            self.merchantId = [self objectOrNilForKey:kQSActivityMerchantId fromDictionary:dict];
            self.timeType = [self objectOrNilForKey:kQSActivityTimeType fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQSActivityName fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSActivityGmtModified fromDictionary:dict];
            self.type = [self objectOrNilForKey:kQSActivityType fromDictionary:dict];
            self.moneyCondition = [self objectOrNilForKey:kQSActivityMoneyCondition fromDictionary:dict];
            self.activityIdentifier = [self objectOrNilForKey:kQSActivityId fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kQSActivityGmtCreated fromDictionary:dict];
            self.areas = [self objectOrNilForKey:kQSActivityAreas fromDictionary:dict];
            self.itemIids = [self objectOrNilForKey:kQSActivityItemIids fromDictionary:dict];
            self.endProperty = [self objectOrNilForKey:kQSActivityEnd fromDictionary:dict];
            self.describe = [self objectOrNilForKey:kQSActivityDescribe fromDictionary:dict];
            self.denomination = [self objectOrNilForKey:kQSActivityDenomination fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSActivityPicUrl fromDictionary:dict];
            self.start = [self objectOrNilForKey:kQSActivityStart fromDictionary:dict];
            self.merchant = [self objectOrNilForKey:kQSActivityMerchant fromDictionary:dict];
            self.discountRate = [self objectOrNilForKey:kQSActivityDiscountRate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kQSActivityStatus];
    [mutableDict setValue:self.sourceType forKey:kQSActivitySourceType];
    [mutableDict setValue:self.quantityCondition forKey:kQSActivityQuantityCondition];
    [mutableDict setValue:self.site forKey:kQSActivitySite];
    [mutableDict setValue:self.period forKey:kQSActivityPeriod];
    [mutableDict setValue:self.payType forKey:kQSActivityPayType];
    [mutableDict setValue:self.merchantId forKey:kQSActivityMerchantId];
    [mutableDict setValue:self.timeType forKey:kQSActivityTimeType];
    [mutableDict setValue:self.name forKey:kQSActivityName];
    [mutableDict setValue:self.gmtModified forKey:kQSActivityGmtModified];
    [mutableDict setValue:self.type forKey:kQSActivityType];
    [mutableDict setValue:self.moneyCondition forKey:kQSActivityMoneyCondition];
    [mutableDict setValue:self.activityIdentifier forKey:kQSActivityId];
    [mutableDict setValue:self.gmtCreated forKey:kQSActivityGmtCreated];
    [mutableDict setValue:self.areas forKey:kQSActivityAreas];
    [mutableDict setValue:self.itemIids forKey:kQSActivityItemIids];
    [mutableDict setValue:self.endProperty forKey:kQSActivityEnd];
    [mutableDict setValue:self.describe forKey:kQSActivityDescribe];
    [mutableDict setValue:self.denomination forKey:kQSActivityDenomination];
    [mutableDict setValue:self.picUrl forKey:kQSActivityPicUrl];
    [mutableDict setValue:self.start forKey:kQSActivityStart];
    [mutableDict setValue:self.merchant forKey:kQSActivityMerchant];
    [mutableDict setValue:self.discountRate forKey:kQSActivityDiscountRate];

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

    self.status = [aDecoder decodeObjectForKey:kQSActivityStatus];
    self.sourceType = [aDecoder decodeObjectForKey:kQSActivitySourceType];
    self.quantityCondition = [aDecoder decodeObjectForKey:kQSActivityQuantityCondition];
    self.site = [aDecoder decodeObjectForKey:kQSActivitySite];
    self.period = [aDecoder decodeObjectForKey:kQSActivityPeriod];
    self.payType = [aDecoder decodeObjectForKey:kQSActivityPayType];
    self.merchantId = [aDecoder decodeObjectForKey:kQSActivityMerchantId];
    self.timeType = [aDecoder decodeObjectForKey:kQSActivityTimeType];
    self.name = [aDecoder decodeObjectForKey:kQSActivityName];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSActivityGmtModified];
    self.type = [aDecoder decodeObjectForKey:kQSActivityType];
    self.moneyCondition = [aDecoder decodeObjectForKey:kQSActivityMoneyCondition];
    self.activityIdentifier = [aDecoder decodeObjectForKey:kQSActivityId];
    self.gmtCreated = [aDecoder decodeObjectForKey:kQSActivityGmtCreated];
    self.areas = [aDecoder decodeObjectForKey:kQSActivityAreas];
    self.itemIids = [aDecoder decodeObjectForKey:kQSActivityItemIids];
    self.endProperty = [aDecoder decodeObjectForKey:kQSActivityEnd];
    self.describe = [aDecoder decodeObjectForKey:kQSActivityDescribe];
    self.denomination = [aDecoder decodeObjectForKey:kQSActivityDenomination];
    self.picUrl = [aDecoder decodeObjectForKey:kQSActivityPicUrl];
    self.start = [aDecoder decodeObjectForKey:kQSActivityStart];
    self.merchant = [aDecoder decodeObjectForKey:kQSActivityMerchant];
    self.discountRate = [aDecoder decodeObjectForKey:kQSActivityDiscountRate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kQSActivityStatus];
    [aCoder encodeObject:_sourceType forKey:kQSActivitySourceType];
    [aCoder encodeObject:_quantityCondition forKey:kQSActivityQuantityCondition];
    [aCoder encodeObject:_site forKey:kQSActivitySite];
    [aCoder encodeObject:_period forKey:kQSActivityPeriod];
    [aCoder encodeObject:_payType forKey:kQSActivityPayType];
    [aCoder encodeObject:_merchantId forKey:kQSActivityMerchantId];
    [aCoder encodeObject:_timeType forKey:kQSActivityTimeType];
    [aCoder encodeObject:_name forKey:kQSActivityName];
    [aCoder encodeObject:_gmtModified forKey:kQSActivityGmtModified];
    [aCoder encodeObject:_type forKey:kQSActivityType];
    [aCoder encodeObject:_moneyCondition forKey:kQSActivityMoneyCondition];
    [aCoder encodeObject:_activityIdentifier forKey:kQSActivityId];
    [aCoder encodeObject:_gmtCreated forKey:kQSActivityGmtCreated];
    [aCoder encodeObject:_areas forKey:kQSActivityAreas];
    [aCoder encodeObject:_itemIids forKey:kQSActivityItemIids];
    [aCoder encodeObject:_endProperty forKey:kQSActivityEnd];
    [aCoder encodeObject:_describe forKey:kQSActivityDescribe];
    [aCoder encodeObject:_denomination forKey:kQSActivityDenomination];
    [aCoder encodeObject:_picUrl forKey:kQSActivityPicUrl];
    [aCoder encodeObject:_start forKey:kQSActivityStart];
    [aCoder encodeObject:_merchant forKey:kQSActivityMerchant];
    [aCoder encodeObject:_discountRate forKey:kQSActivityDiscountRate];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSActivity *copy = [[QSActivity alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.sourceType = [self.sourceType copyWithZone:zone];
        copy.quantityCondition = [self.quantityCondition copyWithZone:zone];
        copy.site = [self.site copyWithZone:zone];
        copy.period = [self.period copyWithZone:zone];
        copy.payType = [self.payType copyWithZone:zone];
        copy.merchantId = [self.merchantId copyWithZone:zone];
        copy.timeType = [self.timeType copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.gmtModified = [self.gmtModified copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.moneyCondition = [self.moneyCondition copyWithZone:zone];
        copy.activityIdentifier = [self.activityIdentifier copyWithZone:zone];
        copy.gmtCreated = [self.gmtCreated copyWithZone:zone];
        copy.areas = [self.areas copyWithZone:zone];
        copy.itemIids = [self.itemIids copyWithZone:zone];
        copy.endProperty = [self.endProperty copyWithZone:zone];
        copy.describe = [self.describe copyWithZone:zone];
        copy.denomination = [self.denomination copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.start = [self.start copyWithZone:zone];
        copy.merchant = [self.merchant copyWithZone:zone];
        copy.discountRate = [self.discountRate copyWithZone:zone];
    }
    
    return copy;
}


@end
