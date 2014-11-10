//
//  QSSActivities.m
//
//  Created by   on 14/11/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSSActivities.h"


NSString *const kQSSActivitiesStatus = @"status";
NSString *const kQSSActivitiesSourceType = @"source_type";
NSString *const kQSSActivitiesQuantityCondition = @"quantity_condition";
NSString *const kQSSActivitiesSite = @"site";
NSString *const kQSSActivitiesPeriod = @"period";
NSString *const kQSSActivitiesPayType = @"pay_type";
NSString *const kQSSActivitiesMerchantId = @"merchant_id";
NSString *const kQSSActivitiesTimeType = @"time_type";
NSString *const kQSSActivitiesName = @"name";
NSString *const kQSSActivitiesGmtModified = @"gmt_modified";
NSString *const kQSSActivitiesType = @"type";
NSString *const kQSSActivitiesMoneyCondition = @"money_condition";
NSString *const kQSSActivitiesId = @"id";
NSString *const kQSSActivitiesGmtCreated = @"gmt_created";
NSString *const kQSSActivitiesAreas = @"areas";
NSString *const kQSSActivitiesItemIids = @"item_iids";
NSString *const kQSSActivitiesEnd = @"end";
NSString *const kQSSActivitiesDescribe = @"describe";
NSString *const kQSSActivitiesDenomination = @"denomination";
NSString *const kQSSActivitiesPicUrl = @"pic_url";
NSString *const kQSSActivitiesStart = @"start";
NSString *const kQSSActivitiesMerchant = @"merchant";
NSString *const kQSSActivitiesDiscountRate = @"discount_rate";


@interface QSSActivities ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSSActivities

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
            self.status = [self objectOrNilForKey:kQSSActivitiesStatus fromDictionary:dict];
            self.sourceType = [self objectOrNilForKey:kQSSActivitiesSourceType fromDictionary:dict];
            self.quantityCondition = [self objectOrNilForKey:kQSSActivitiesQuantityCondition fromDictionary:dict];
            self.site = [self objectOrNilForKey:kQSSActivitiesSite fromDictionary:dict];
            self.period = [self objectOrNilForKey:kQSSActivitiesPeriod fromDictionary:dict];
            self.payType = [self objectOrNilForKey:kQSSActivitiesPayType fromDictionary:dict];
            self.merchantId = [self objectOrNilForKey:kQSSActivitiesMerchantId fromDictionary:dict];
            self.timeType = [self objectOrNilForKey:kQSSActivitiesTimeType fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQSSActivitiesName fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSSActivitiesGmtModified fromDictionary:dict];
            self.type = [self objectOrNilForKey:kQSSActivitiesType fromDictionary:dict];
            self.moneyCondition = [self objectOrNilForKey:kQSSActivitiesMoneyCondition fromDictionary:dict];
            self.activitiesIdentifier = [self objectOrNilForKey:kQSSActivitiesId fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kQSSActivitiesGmtCreated fromDictionary:dict];
            self.areas = [self objectOrNilForKey:kQSSActivitiesAreas fromDictionary:dict];
            self.itemIids = [self objectOrNilForKey:kQSSActivitiesItemIids fromDictionary:dict];
            self.endProperty = [self objectOrNilForKey:kQSSActivitiesEnd fromDictionary:dict];
            self.describe = [self objectOrNilForKey:kQSSActivitiesDescribe fromDictionary:dict];
            self.denomination = [self objectOrNilForKey:kQSSActivitiesDenomination fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSSActivitiesPicUrl fromDictionary:dict];
            self.start = [self objectOrNilForKey:kQSSActivitiesStart fromDictionary:dict];
            self.merchant = [self objectOrNilForKey:kQSSActivitiesMerchant fromDictionary:dict];
            self.discountRate = [self objectOrNilForKey:kQSSActivitiesDiscountRate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kQSSActivitiesStatus];
    [mutableDict setValue:self.sourceType forKey:kQSSActivitiesSourceType];
    [mutableDict setValue:self.quantityCondition forKey:kQSSActivitiesQuantityCondition];
    [mutableDict setValue:self.site forKey:kQSSActivitiesSite];
    [mutableDict setValue:self.period forKey:kQSSActivitiesPeriod];
    [mutableDict setValue:self.payType forKey:kQSSActivitiesPayType];
    [mutableDict setValue:self.merchantId forKey:kQSSActivitiesMerchantId];
    [mutableDict setValue:self.timeType forKey:kQSSActivitiesTimeType];
    [mutableDict setValue:self.name forKey:kQSSActivitiesName];
    [mutableDict setValue:self.gmtModified forKey:kQSSActivitiesGmtModified];
    [mutableDict setValue:self.type forKey:kQSSActivitiesType];
    [mutableDict setValue:self.moneyCondition forKey:kQSSActivitiesMoneyCondition];
    [mutableDict setValue:self.activitiesIdentifier forKey:kQSSActivitiesId];
    [mutableDict setValue:self.gmtCreated forKey:kQSSActivitiesGmtCreated];
    [mutableDict setValue:self.areas forKey:kQSSActivitiesAreas];
    [mutableDict setValue:self.itemIids forKey:kQSSActivitiesItemIids];
    [mutableDict setValue:self.endProperty forKey:kQSSActivitiesEnd];
    [mutableDict setValue:self.describe forKey:kQSSActivitiesDescribe];
    [mutableDict setValue:self.denomination forKey:kQSSActivitiesDenomination];
    [mutableDict setValue:self.picUrl forKey:kQSSActivitiesPicUrl];
    [mutableDict setValue:self.start forKey:kQSSActivitiesStart];
    [mutableDict setValue:self.merchant forKey:kQSSActivitiesMerchant];
    [mutableDict setValue:self.discountRate forKey:kQSSActivitiesDiscountRate];

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

    self.status = [aDecoder decodeObjectForKey:kQSSActivitiesStatus];
    self.sourceType = [aDecoder decodeObjectForKey:kQSSActivitiesSourceType];
    self.quantityCondition = [aDecoder decodeObjectForKey:kQSSActivitiesQuantityCondition];
    self.site = [aDecoder decodeObjectForKey:kQSSActivitiesSite];
    self.period = [aDecoder decodeObjectForKey:kQSSActivitiesPeriod];
    self.payType = [aDecoder decodeObjectForKey:kQSSActivitiesPayType];
    self.merchantId = [aDecoder decodeObjectForKey:kQSSActivitiesMerchantId];
    self.timeType = [aDecoder decodeObjectForKey:kQSSActivitiesTimeType];
    self.name = [aDecoder decodeObjectForKey:kQSSActivitiesName];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSSActivitiesGmtModified];
    self.type = [aDecoder decodeObjectForKey:kQSSActivitiesType];
    self.moneyCondition = [aDecoder decodeObjectForKey:kQSSActivitiesMoneyCondition];
    self.activitiesIdentifier = [aDecoder decodeObjectForKey:kQSSActivitiesId];
    self.gmtCreated = [aDecoder decodeObjectForKey:kQSSActivitiesGmtCreated];
    self.areas = [aDecoder decodeObjectForKey:kQSSActivitiesAreas];
    self.itemIids = [aDecoder decodeObjectForKey:kQSSActivitiesItemIids];
    self.endProperty = [aDecoder decodeObjectForKey:kQSSActivitiesEnd];
    self.describe = [aDecoder decodeObjectForKey:kQSSActivitiesDescribe];
    self.denomination = [aDecoder decodeObjectForKey:kQSSActivitiesDenomination];
    self.picUrl = [aDecoder decodeObjectForKey:kQSSActivitiesPicUrl];
    self.start = [aDecoder decodeObjectForKey:kQSSActivitiesStart];
    self.merchant = [aDecoder decodeObjectForKey:kQSSActivitiesMerchant];
    self.discountRate = [aDecoder decodeObjectForKey:kQSSActivitiesDiscountRate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kQSSActivitiesStatus];
    [aCoder encodeObject:_sourceType forKey:kQSSActivitiesSourceType];
    [aCoder encodeObject:_quantityCondition forKey:kQSSActivitiesQuantityCondition];
    [aCoder encodeObject:_site forKey:kQSSActivitiesSite];
    [aCoder encodeObject:_period forKey:kQSSActivitiesPeriod];
    [aCoder encodeObject:_payType forKey:kQSSActivitiesPayType];
    [aCoder encodeObject:_merchantId forKey:kQSSActivitiesMerchantId];
    [aCoder encodeObject:_timeType forKey:kQSSActivitiesTimeType];
    [aCoder encodeObject:_name forKey:kQSSActivitiesName];
    [aCoder encodeObject:_gmtModified forKey:kQSSActivitiesGmtModified];
    [aCoder encodeObject:_type forKey:kQSSActivitiesType];
    [aCoder encodeObject:_moneyCondition forKey:kQSSActivitiesMoneyCondition];
    [aCoder encodeObject:_activitiesIdentifier forKey:kQSSActivitiesId];
    [aCoder encodeObject:_gmtCreated forKey:kQSSActivitiesGmtCreated];
    [aCoder encodeObject:_areas forKey:kQSSActivitiesAreas];
    [aCoder encodeObject:_itemIids forKey:kQSSActivitiesItemIids];
    [aCoder encodeObject:_endProperty forKey:kQSSActivitiesEnd];
    [aCoder encodeObject:_describe forKey:kQSSActivitiesDescribe];
    [aCoder encodeObject:_denomination forKey:kQSSActivitiesDenomination];
    [aCoder encodeObject:_picUrl forKey:kQSSActivitiesPicUrl];
    [aCoder encodeObject:_start forKey:kQSSActivitiesStart];
    [aCoder encodeObject:_merchant forKey:kQSSActivitiesMerchant];
    [aCoder encodeObject:_discountRate forKey:kQSSActivitiesDiscountRate];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSSActivities *copy = [[QSSActivities alloc] init];
    
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
