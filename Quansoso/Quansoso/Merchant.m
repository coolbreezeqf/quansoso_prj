//
//  Merchant.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Merchant.h"


NSString *const kMerchantDescription = @"description";
NSString *const kMerchantStatus = @"status";
NSString *const kMerchantWebsiteUrl = @"website_url";
NSString *const kMerchantTagExpression = @"tag_expression";
NSString *const kMerchantBrand = @"brand";
NSString *const kMerchantShopScore = @"shop_score";
NSString *const kMerchantExternalLevel = @"external_level";
NSString *const kMerchantExternalShopId = @"external_shop_id";
NSString *const kMerchantKeywords = @"keywords";
NSString *const kMerchantMemo = @"memo";
NSString *const kMerchantName = @"name";
NSString *const kMerchantGmtModified = @"gmt_modified";
NSString *const kMerchantType = @"type";
NSString *const kMerchantId = @"id";
NSString *const kMerchantSaleVolume = @"sale_volume";
NSString *const kMerchantGmtCreated = @"gmt_created";
NSString *const kMerchantGrade = @"grade";
NSString *const kMerchantIsEnter = @"is_enter";
NSString *const kMerchantExternalId = @"external_id";
NSString *const kMerchantEkpCategory = @"ekp_category";
NSString *const kMerchantPicUrl = @"pic_url";
NSString *const kMerchantSellerId = @"seller_id";
NSString *const kMerchantExternalCategory = @"external_category";
NSString *const kMerchantExternalCid = @"external_cid";


@interface Merchant ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Merchant

@synthesize merchantDescription = _merchantDescription;
@synthesize status = _status;
@synthesize websiteUrl = _websiteUrl;
@synthesize tagExpression = _tagExpression;
@synthesize brand = _brand;
@synthesize shopScore = _shopScore;
@synthesize externalLevel = _externalLevel;
@synthesize externalShopId = _externalShopId;
@synthesize keywords = _keywords;
@synthesize memo = _memo;
@synthesize name = _name;
@synthesize gmtModified = _gmtModified;
@synthesize type = _type;
@synthesize merchantIdentifier = _merchantIdentifier;
@synthesize saleVolume = _saleVolume;
@synthesize gmtCreated = _gmtCreated;
@synthesize grade = _grade;
@synthesize isEnter = _isEnter;
@synthesize externalId = _externalId;
@synthesize ekpCategory = _ekpCategory;
@synthesize picUrl = _picUrl;
@synthesize sellerId = _sellerId;
@synthesize externalCategory = _externalCategory;
@synthesize externalCid = _externalCid;


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
            self.merchantDescription = [self objectOrNilForKey:kMerchantDescription fromDictionary:dict];
            self.status = [self objectOrNilForKey:kMerchantStatus fromDictionary:dict];
            self.websiteUrl = [self objectOrNilForKey:kMerchantWebsiteUrl fromDictionary:dict];
            self.tagExpression = [self objectOrNilForKey:kMerchantTagExpression fromDictionary:dict];
            self.brand = [self objectOrNilForKey:kMerchantBrand fromDictionary:dict];
            self.shopScore = [self objectOrNilForKey:kMerchantShopScore fromDictionary:dict];
            self.externalLevel = [self objectOrNilForKey:kMerchantExternalLevel fromDictionary:dict];
            self.externalShopId = [self objectOrNilForKey:kMerchantExternalShopId fromDictionary:dict];
            self.keywords = [self objectOrNilForKey:kMerchantKeywords fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kMerchantMemo fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMerchantName fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kMerchantGmtModified fromDictionary:dict];
            self.type = [self objectOrNilForKey:kMerchantType fromDictionary:dict];
            self.merchantIdentifier = [self objectOrNilForKey:kMerchantId fromDictionary:dict];
            self.saleVolume = [self objectOrNilForKey:kMerchantSaleVolume fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kMerchantGmtCreated fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kMerchantGrade fromDictionary:dict];
            self.isEnter = [self objectOrNilForKey:kMerchantIsEnter fromDictionary:dict];
            self.externalId = [self objectOrNilForKey:kMerchantExternalId fromDictionary:dict];
            self.ekpCategory = [self objectOrNilForKey:kMerchantEkpCategory fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kMerchantPicUrl fromDictionary:dict];
            self.sellerId = [self objectOrNilForKey:kMerchantSellerId fromDictionary:dict];
            self.externalCategory = [self objectOrNilForKey:kMerchantExternalCategory fromDictionary:dict];
            self.externalCid = [self objectOrNilForKey:kMerchantExternalCid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.merchantDescription forKey:kMerchantDescription];
    [mutableDict setValue:self.status forKey:kMerchantStatus];
    [mutableDict setValue:self.websiteUrl forKey:kMerchantWebsiteUrl];
    [mutableDict setValue:self.tagExpression forKey:kMerchantTagExpression];
    [mutableDict setValue:self.brand forKey:kMerchantBrand];
    [mutableDict setValue:self.shopScore forKey:kMerchantShopScore];
    [mutableDict setValue:self.externalLevel forKey:kMerchantExternalLevel];
    [mutableDict setValue:self.externalShopId forKey:kMerchantExternalShopId];
    [mutableDict setValue:self.keywords forKey:kMerchantKeywords];
    [mutableDict setValue:self.memo forKey:kMerchantMemo];
    [mutableDict setValue:self.name forKey:kMerchantName];
    [mutableDict setValue:self.gmtModified forKey:kMerchantGmtModified];
    [mutableDict setValue:self.type forKey:kMerchantType];
    [mutableDict setValue:self.merchantIdentifier forKey:kMerchantId];
    [mutableDict setValue:self.saleVolume forKey:kMerchantSaleVolume];
    [mutableDict setValue:self.gmtCreated forKey:kMerchantGmtCreated];
    [mutableDict setValue:self.grade forKey:kMerchantGrade];
    [mutableDict setValue:self.isEnter forKey:kMerchantIsEnter];
    [mutableDict setValue:self.externalId forKey:kMerchantExternalId];
    [mutableDict setValue:self.ekpCategory forKey:kMerchantEkpCategory];
    [mutableDict setValue:self.picUrl forKey:kMerchantPicUrl];
    [mutableDict setValue:self.sellerId forKey:kMerchantSellerId];
    [mutableDict setValue:self.externalCategory forKey:kMerchantExternalCategory];
    [mutableDict setValue:self.externalCid forKey:kMerchantExternalCid];

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

    self.merchantDescription = [aDecoder decodeObjectForKey:kMerchantDescription];
    self.status = [aDecoder decodeObjectForKey:kMerchantStatus];
    self.websiteUrl = [aDecoder decodeObjectForKey:kMerchantWebsiteUrl];
    self.tagExpression = [aDecoder decodeObjectForKey:kMerchantTagExpression];
    self.brand = [aDecoder decodeObjectForKey:kMerchantBrand];
    self.shopScore = [aDecoder decodeObjectForKey:kMerchantShopScore];
    self.externalLevel = [aDecoder decodeObjectForKey:kMerchantExternalLevel];
    self.externalShopId = [aDecoder decodeObjectForKey:kMerchantExternalShopId];
    self.keywords = [aDecoder decodeObjectForKey:kMerchantKeywords];
    self.memo = [aDecoder decodeObjectForKey:kMerchantMemo];
    self.name = [aDecoder decodeObjectForKey:kMerchantName];
    self.gmtModified = [aDecoder decodeObjectForKey:kMerchantGmtModified];
    self.type = [aDecoder decodeObjectForKey:kMerchantType];
    self.merchantIdentifier = [aDecoder decodeObjectForKey:kMerchantId];
    self.saleVolume = [aDecoder decodeObjectForKey:kMerchantSaleVolume];
    self.gmtCreated = [aDecoder decodeObjectForKey:kMerchantGmtCreated];
    self.grade = [aDecoder decodeObjectForKey:kMerchantGrade];
    self.isEnter = [aDecoder decodeObjectForKey:kMerchantIsEnter];
    self.externalId = [aDecoder decodeObjectForKey:kMerchantExternalId];
    self.ekpCategory = [aDecoder decodeObjectForKey:kMerchantEkpCategory];
    self.picUrl = [aDecoder decodeObjectForKey:kMerchantPicUrl];
    self.sellerId = [aDecoder decodeObjectForKey:kMerchantSellerId];
    self.externalCategory = [aDecoder decodeObjectForKey:kMerchantExternalCategory];
    self.externalCid = [aDecoder decodeObjectForKey:kMerchantExternalCid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_merchantDescription forKey:kMerchantDescription];
    [aCoder encodeObject:_status forKey:kMerchantStatus];
    [aCoder encodeObject:_websiteUrl forKey:kMerchantWebsiteUrl];
    [aCoder encodeObject:_tagExpression forKey:kMerchantTagExpression];
    [aCoder encodeObject:_brand forKey:kMerchantBrand];
    [aCoder encodeObject:_shopScore forKey:kMerchantShopScore];
    [aCoder encodeObject:_externalLevel forKey:kMerchantExternalLevel];
    [aCoder encodeObject:_externalShopId forKey:kMerchantExternalShopId];
    [aCoder encodeObject:_keywords forKey:kMerchantKeywords];
    [aCoder encodeObject:_memo forKey:kMerchantMemo];
    [aCoder encodeObject:_name forKey:kMerchantName];
    [aCoder encodeObject:_gmtModified forKey:kMerchantGmtModified];
    [aCoder encodeObject:_type forKey:kMerchantType];
    [aCoder encodeObject:_merchantIdentifier forKey:kMerchantId];
    [aCoder encodeObject:_saleVolume forKey:kMerchantSaleVolume];
    [aCoder encodeObject:_gmtCreated forKey:kMerchantGmtCreated];
    [aCoder encodeObject:_grade forKey:kMerchantGrade];
    [aCoder encodeObject:_isEnter forKey:kMerchantIsEnter];
    [aCoder encodeObject:_externalId forKey:kMerchantExternalId];
    [aCoder encodeObject:_ekpCategory forKey:kMerchantEkpCategory];
    [aCoder encodeObject:_picUrl forKey:kMerchantPicUrl];
    [aCoder encodeObject:_sellerId forKey:kMerchantSellerId];
    [aCoder encodeObject:_externalCategory forKey:kMerchantExternalCategory];
    [aCoder encodeObject:_externalCid forKey:kMerchantExternalCid];
}

- (id)copyWithZone:(NSZone *)zone
{
    Merchant *copy = [[Merchant alloc] init];
    
    if (copy) {

        copy.merchantDescription = [self.merchantDescription copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.websiteUrl = [self.websiteUrl copyWithZone:zone];
        copy.tagExpression = [self.tagExpression copyWithZone:zone];
        copy.brand = [self.brand copyWithZone:zone];
        copy.shopScore = [self.shopScore copyWithZone:zone];
        copy.externalLevel = [self.externalLevel copyWithZone:zone];
        copy.externalShopId = [self.externalShopId copyWithZone:zone];
        copy.keywords = [self.keywords copyWithZone:zone];
        copy.memo = [self.memo copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.gmtModified = [self.gmtModified copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.merchantIdentifier = [self.merchantIdentifier copyWithZone:zone];
        copy.saleVolume = [self.saleVolume copyWithZone:zone];
        copy.gmtCreated = [self.gmtCreated copyWithZone:zone];
        copy.grade = [self.grade copyWithZone:zone];
        copy.isEnter = [self.isEnter copyWithZone:zone];
        copy.externalId = [self.externalId copyWithZone:zone];
        copy.ekpCategory = [self.ekpCategory copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.sellerId = [self.sellerId copyWithZone:zone];
        copy.externalCategory = [self.externalCategory copyWithZone:zone];
        copy.externalCid = [self.externalCid copyWithZone:zone];
    }
    
    return copy;
}


@end
