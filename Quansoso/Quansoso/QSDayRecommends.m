//
//  QSDayRecommends.m
//
//  Created by  C陈政旭 on 14/11/24
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSDayRecommends.h"
#import "QSCards.h"
#import "QSActivity.h"


NSString *const kQSDayRecommendsName = @"name";
NSString *const kQSDayRecommendsGmtCreated = @"gmt_created";
NSString *const kQSDayRecommendsPicUrl = @"pic_url";
NSString *const kQSDayRecommendsExternalId = @"external_id";
NSString *const kQSDayRecommendsCard = @"card";
NSString *const kQSDayRecommendsCouponId = @"coupon_id";
NSString *const kQSDayRecommendsDate = @"date";
NSString *const kQSDayRecommendsExternalShopId = @"external_shop_id";
NSString *const kQSDayRecommendsCouponType = @"coupon_type";
NSString *const kQSDayRecommendsGmtModified = @"gmt_modified";
NSString *const kQSDayRecommendsActivity = @"activity";


@interface QSDayRecommends ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSDayRecommends

@synthesize name = _name;
@synthesize gmtCreated = _gmtCreated;
@synthesize picUrl = _picUrl;
@synthesize externalId = _externalId;
@synthesize card = _card;
@synthesize couponId = _couponId;
@synthesize date = _date;
@synthesize externalShopId = _externalShopId;
@synthesize couponType = _couponType;
@synthesize gmtModified = _gmtModified;
@synthesize activity = _activity;


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
            self.name = [self objectOrNilForKey:kQSDayRecommendsName fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kQSDayRecommendsGmtCreated fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSDayRecommendsPicUrl fromDictionary:dict];
            self.externalId = [self objectOrNilForKey:kQSDayRecommendsExternalId fromDictionary:dict];
            self.card = [QSCards modelObjectWithDictionary:[dict objectForKey:kQSDayRecommendsCard]];
            self.couponId = [self objectOrNilForKey:kQSDayRecommendsCouponId fromDictionary:dict];
            self.date = [self objectOrNilForKey:kQSDayRecommendsDate fromDictionary:dict];
            self.externalShopId = [self objectOrNilForKey:kQSDayRecommendsExternalShopId fromDictionary:dict];
            self.couponType = [self objectOrNilForKey:kQSDayRecommendsCouponType fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSDayRecommendsGmtModified fromDictionary:dict];
            self.activity = [QSActivity modelObjectWithDictionary:[dict objectForKey:kQSDayRecommendsActivity]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.activity dictionaryRepresentation] forKey:kQSDayRecommendsActivity];
    [mutableDict setValue:self.name forKey:kQSDayRecommendsName];
    [mutableDict setValue:self.gmtCreated forKey:kQSDayRecommendsGmtCreated];
    [mutableDict setValue:self.picUrl forKey:kQSDayRecommendsPicUrl];
    [mutableDict setValue:self.externalId forKey:kQSDayRecommendsExternalId];
    [mutableDict setValue:[self.card dictionaryRepresentation] forKey:kQSDayRecommendsCard];
    [mutableDict setValue:self.couponId forKey:kQSDayRecommendsCouponId];
    [mutableDict setValue:self.date forKey:kQSDayRecommendsDate];
    [mutableDict setValue:self.externalShopId forKey:kQSDayRecommendsExternalShopId];
    [mutableDict setValue:self.couponType forKey:kQSDayRecommendsCouponType];
    [mutableDict setValue:self.gmtModified forKey:kQSDayRecommendsGmtModified];

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

    self.name = [aDecoder decodeObjectForKey:kQSDayRecommendsName];
    self.gmtCreated = [aDecoder decodeObjectForKey:kQSDayRecommendsGmtCreated];
    self.picUrl = [aDecoder decodeObjectForKey:kQSDayRecommendsPicUrl];
    self.externalId = [aDecoder decodeObjectForKey:kQSDayRecommendsExternalId];
    self.card = [aDecoder decodeObjectForKey:kQSDayRecommendsCard];
    self.couponId = [aDecoder decodeObjectForKey:kQSDayRecommendsCouponId];
    self.date = [aDecoder decodeObjectForKey:kQSDayRecommendsDate];
    self.externalShopId = [aDecoder decodeObjectForKey:kQSDayRecommendsExternalShopId];
    self.couponType = [aDecoder decodeObjectForKey:kQSDayRecommendsCouponType];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSDayRecommendsGmtModified];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kQSDayRecommendsName];
    [aCoder encodeObject:_gmtCreated forKey:kQSDayRecommendsGmtCreated];
    [aCoder encodeObject:_picUrl forKey:kQSDayRecommendsPicUrl];
    [aCoder encodeObject:_externalId forKey:kQSDayRecommendsExternalId];
    [aCoder encodeObject:_card forKey:kQSDayRecommendsCard];
    [aCoder encodeObject:_couponId forKey:kQSDayRecommendsCouponId];
    [aCoder encodeObject:_date forKey:kQSDayRecommendsDate];
    [aCoder encodeObject:_externalShopId forKey:kQSDayRecommendsExternalShopId];
    [aCoder encodeObject:_couponType forKey:kQSDayRecommendsCouponType];
    [aCoder encodeObject:_gmtModified forKey:kQSDayRecommendsGmtModified];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSDayRecommends *copy = [[QSDayRecommends alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.gmtCreated = [self.gmtCreated copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.externalId = [self.externalId copyWithZone:zone];
        copy.card = [self.card copyWithZone:zone];
        copy.couponId = [self.couponId copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.externalShopId = [self.externalShopId copyWithZone:zone];
        copy.couponType = [self.couponType copyWithZone:zone];
        copy.gmtModified = [self.gmtModified copyWithZone:zone];
    }
    
    return copy;
}


@end
