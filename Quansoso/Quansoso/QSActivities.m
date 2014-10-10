//
//  QSActivities.m
//
//  Created by qf  on 14/10/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSActivities.h"


NSString *const kQSActivitiesStatus = @"status";
NSString *const kQSActivitiesSourceType = @"source_type";
NSString *const kQSActivitiesQuantityCondition = @"quantity_condition";
NSString *const kQSActivitiesSite = @"site";
NSString *const kQSActivitiesPeriod = @"period";
NSString *const kQSActivitiesPayType = @"pay_type";
NSString *const kQSActivitiesMerchantId = @"merchant_id";
NSString *const kQSActivitiesTimeType = @"time_type";
NSString *const kQSActivitiesName = @"name";
NSString *const kQSActivitiesGmtModified = @"gmt_modified";
NSString *const kQSActivitiesType = @"type";
NSString *const kQSActivitiesMoneyCondition = @"money_condition";
NSString *const kQSActivitiesId = @"id";
NSString *const kQSActivitiesGmtCreated = @"gmt_created";
NSString *const kQSActivitiesAreas = @"areas";
NSString *const kQSActivitiesItemIids = @"item_iids";
NSString *const kQSActivitiesEnd = @"end";
NSString *const kQSActivitiesDescribe = @"describe";
NSString *const kQSActivitiesDenomination = @"denomination";
NSString *const kQSActivitiesPicUrl = @"pic_url";
NSString *const kQSActivitiesStart = @"start";
NSString *const kQSActivitiesMerchant = @"merchant";
NSString *const kQSActivitiesDiscountRate = @"discount_rate";


@interface QSActivities ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSActivities

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
@synthesize activitiesIdentifier = _activitiesIdentifier;
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
            self.status = [self objectOrNilForKey:kQSActivitiesStatus fromDictionary:dict];
            self.sourceType = [self objectOrNilForKey:kQSActivitiesSourceType fromDictionary:dict];
            self.quantityCondition = [self objectOrNilForKey:kQSActivitiesQuantityCondition fromDictionary:dict];
            self.site = [self objectOrNilForKey:kQSActivitiesSite fromDictionary:dict];
            self.period = [self objectOrNilForKey:kQSActivitiesPeriod fromDictionary:dict];
            self.payType = [self objectOrNilForKey:kQSActivitiesPayType fromDictionary:dict];
            self.merchantId = [self objectOrNilForKey:kQSActivitiesMerchantId fromDictionary:dict];
            self.timeType = [self objectOrNilForKey:kQSActivitiesTimeType fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQSActivitiesName fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSActivitiesGmtModified fromDictionary:dict];
            self.type = [self objectOrNilForKey:kQSActivitiesType fromDictionary:dict];
            self.moneyCondition = [self objectOrNilForKey:kQSActivitiesMoneyCondition fromDictionary:dict];
            self.activitiesIdentifier = [self objectOrNilForKey:kQSActivitiesId fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kQSActivitiesGmtCreated fromDictionary:dict];
            self.areas = [self objectOrNilForKey:kQSActivitiesAreas fromDictionary:dict];
            self.itemIids = [self objectOrNilForKey:kQSActivitiesItemIids fromDictionary:dict];
            self.endProperty = [self objectOrNilForKey:kQSActivitiesEnd fromDictionary:dict];
            self.describe = [self objectOrNilForKey:kQSActivitiesDescribe fromDictionary:dict];
            self.denomination = [self objectOrNilForKey:kQSActivitiesDenomination fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSActivitiesPicUrl fromDictionary:dict];
            self.start = [self objectOrNilForKey:kQSActivitiesStart fromDictionary:dict];
            self.merchant = [self objectOrNilForKey:kQSActivitiesMerchant fromDictionary:dict];
            self.discountRate = [self objectOrNilForKey:kQSActivitiesDiscountRate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kQSActivitiesStatus];
    [mutableDict setValue:self.sourceType forKey:kQSActivitiesSourceType];
    [mutableDict setValue:self.quantityCondition forKey:kQSActivitiesQuantityCondition];
    [mutableDict setValue:self.site forKey:kQSActivitiesSite];
    [mutableDict setValue:self.period forKey:kQSActivitiesPeriod];
    [mutableDict setValue:self.payType forKey:kQSActivitiesPayType];
    [mutableDict setValue:self.merchantId forKey:kQSActivitiesMerchantId];
    [mutableDict setValue:self.timeType forKey:kQSActivitiesTimeType];
    [mutableDict setValue:self.name forKey:kQSActivitiesName];
    [mutableDict setValue:self.gmtModified forKey:kQSActivitiesGmtModified];
    [mutableDict setValue:self.type forKey:kQSActivitiesType];
    [mutableDict setValue:self.moneyCondition forKey:kQSActivitiesMoneyCondition];
    [mutableDict setValue:self.activitiesIdentifier forKey:kQSActivitiesId];
    [mutableDict setValue:self.gmtCreated forKey:kQSActivitiesGmtCreated];
    [mutableDict setValue:self.areas forKey:kQSActivitiesAreas];
    [mutableDict setValue:self.itemIids forKey:kQSActivitiesItemIids];
    [mutableDict setValue:self.endProperty forKey:kQSActivitiesEnd];
    [mutableDict setValue:self.describe forKey:kQSActivitiesDescribe];
    [mutableDict setValue:self.denomination forKey:kQSActivitiesDenomination];
    [mutableDict setValue:self.picUrl forKey:kQSActivitiesPicUrl];
    [mutableDict setValue:self.start forKey:kQSActivitiesStart];
    [mutableDict setValue:self.merchant forKey:kQSActivitiesMerchant];
    [mutableDict setValue:self.discountRate forKey:kQSActivitiesDiscountRate];

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

    self.status = [aDecoder decodeObjectForKey:kQSActivitiesStatus];
    self.sourceType = [aDecoder decodeObjectForKey:kQSActivitiesSourceType];
    self.quantityCondition = [aDecoder decodeObjectForKey:kQSActivitiesQuantityCondition];
    self.site = [aDecoder decodeObjectForKey:kQSActivitiesSite];
    self.period = [aDecoder decodeObjectForKey:kQSActivitiesPeriod];
    self.payType = [aDecoder decodeObjectForKey:kQSActivitiesPayType];
    self.merchantId = [aDecoder decodeObjectForKey:kQSActivitiesMerchantId];
    self.timeType = [aDecoder decodeObjectForKey:kQSActivitiesTimeType];
    self.name = [aDecoder decodeObjectForKey:kQSActivitiesName];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSActivitiesGmtModified];
    self.type = [aDecoder decodeObjectForKey:kQSActivitiesType];
    self.moneyCondition = [aDecoder decodeObjectForKey:kQSActivitiesMoneyCondition];
    self.activitiesIdentifier = [aDecoder decodeObjectForKey:kQSActivitiesId];
    self.gmtCreated = [aDecoder decodeObjectForKey:kQSActivitiesGmtCreated];
    self.areas = [aDecoder decodeObjectForKey:kQSActivitiesAreas];
    self.itemIids = [aDecoder decodeObjectForKey:kQSActivitiesItemIids];
    self.endProperty = [aDecoder decodeObjectForKey:kQSActivitiesEnd];
    self.describe = [aDecoder decodeObjectForKey:kQSActivitiesDescribe];
    self.denomination = [aDecoder decodeObjectForKey:kQSActivitiesDenomination];
    self.picUrl = [aDecoder decodeObjectForKey:kQSActivitiesPicUrl];
    self.start = [aDecoder decodeObjectForKey:kQSActivitiesStart];
    self.merchant = [aDecoder decodeObjectForKey:kQSActivitiesMerchant];
    self.discountRate = [aDecoder decodeObjectForKey:kQSActivitiesDiscountRate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kQSActivitiesStatus];
    [aCoder encodeObject:_sourceType forKey:kQSActivitiesSourceType];
    [aCoder encodeObject:_quantityCondition forKey:kQSActivitiesQuantityCondition];
    [aCoder encodeObject:_site forKey:kQSActivitiesSite];
    [aCoder encodeObject:_period forKey:kQSActivitiesPeriod];
    [aCoder encodeObject:_payType forKey:kQSActivitiesPayType];
    [aCoder encodeObject:_merchantId forKey:kQSActivitiesMerchantId];
    [aCoder encodeObject:_timeType forKey:kQSActivitiesTimeType];
    [aCoder encodeObject:_name forKey:kQSActivitiesName];
    [aCoder encodeObject:_gmtModified forKey:kQSActivitiesGmtModified];
    [aCoder encodeObject:_type forKey:kQSActivitiesType];
    [aCoder encodeObject:_moneyCondition forKey:kQSActivitiesMoneyCondition];
    [aCoder encodeObject:_activitiesIdentifier forKey:kQSActivitiesId];
    [aCoder encodeObject:_gmtCreated forKey:kQSActivitiesGmtCreated];
    [aCoder encodeObject:_areas forKey:kQSActivitiesAreas];
    [aCoder encodeObject:_itemIids forKey:kQSActivitiesItemIids];
    [aCoder encodeObject:_endProperty forKey:kQSActivitiesEnd];
    [aCoder encodeObject:_describe forKey:kQSActivitiesDescribe];
    [aCoder encodeObject:_denomination forKey:kQSActivitiesDenomination];
    [aCoder encodeObject:_picUrl forKey:kQSActivitiesPicUrl];
    [aCoder encodeObject:_start forKey:kQSActivitiesStart];
    [aCoder encodeObject:_merchant forKey:kQSActivitiesMerchant];
    [aCoder encodeObject:_discountRate forKey:kQSActivitiesDiscountRate];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSActivities *copy = [[QSActivities alloc] init];
    
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
        copy.activitiesIdentifier = [self.activitiesIdentifier copyWithZone:zone];
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
