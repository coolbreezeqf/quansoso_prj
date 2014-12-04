//
//  QSMerchant.m
//
//  Created by qf  on 14/10/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSMerchant.h"


NSString *const kQSMerchantDescription = @"description";
NSString *const kQSMerchantStatus = @"status";
NSString *const kQSMerchantWebsiteUrl = @"website_url";
NSString *const kQSMerchantTagExpression = @"tag_expression";
NSString *const kQSMerchantBrand = @"brand";
NSString *const kQSMerchantShopScore = @"shop_score";
NSString *const kQSMerchantExternalLevel = @"external_level";
NSString *const kQSMerchantExternalShopId = @"external_shop_id";
NSString *const kQSMerchantKeywords = @"keywords";
NSString *const kQSMerchantMemo = @"memo";
NSString *const kQSMerchantName = @"name";
NSString *const kQSMerchantGmtModified = @"gmt_modified";
NSString *const kQSMerchantType = @"type";
NSString *const kQSMerchantId = @"id";
NSString *const kQSMerchantSaleVolume = @"sale_volume";
NSString *const kQSMerchantGmtCreated = @"gmt_created";
NSString *const kQSMerchantGrade = @"grade";
NSString *const kQSMerchantIsEnter = @"is_enter";
NSString *const kQSMerchantExternalId = @"external_id";
NSString *const kQSMerchantEkpCategory = @"ekp_category";
NSString *const kQSMerchantPicUrl = @"pic_url";
NSString *const kQSMerchantSellerId = @"seller_id";
NSString *const kQSMerchantExternalCategory = @"external_category";
NSString *const kQSMerchantExternalCid = @"external_cid";
NSString *const kQSMerchantHasModified = @"hasModified";


@interface QSMerchant ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSMerchant

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
@synthesize hasModified = _hasModified;


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
        self.hasModified = [self objectOrNilForKey:kQSMerchantHasModified fromDictionary:dict];
            self.merchantDescription = [self objectOrNilForKey:kQSMerchantDescription fromDictionary:dict];
            self.status = [self objectOrNilForKey:kQSMerchantStatus fromDictionary:dict];
            self.websiteUrl = [self objectOrNilForKey:kQSMerchantWebsiteUrl fromDictionary:dict];
            self.tagExpression = [self objectOrNilForKey:kQSMerchantTagExpression fromDictionary:dict];
            self.brand = [self objectOrNilForKey:kQSMerchantBrand fromDictionary:dict];
            self.shopScore = [self objectOrNilForKey:kQSMerchantShopScore fromDictionary:dict];
            self.externalLevel = [self objectOrNilForKey:kQSMerchantExternalLevel fromDictionary:dict];
            self.externalShopId = [self objectOrNilForKey:kQSMerchantExternalShopId fromDictionary:dict];
            self.keywords = [self objectOrNilForKey:kQSMerchantKeywords fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kQSMerchantMemo fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQSMerchantName fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSMerchantGmtModified fromDictionary:dict];
            self.type = [self objectOrNilForKey:kQSMerchantType fromDictionary:dict];
            self.merchantIdentifier = [self objectOrNilForKey:kQSMerchantId fromDictionary:dict];
            self.saleVolume = [self objectOrNilForKey:kQSMerchantSaleVolume fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kQSMerchantGmtCreated fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kQSMerchantGrade fromDictionary:dict];
            self.isEnter = [self objectOrNilForKey:kQSMerchantIsEnter fromDictionary:dict];
            self.externalId = [self objectOrNilForKey:kQSMerchantExternalId fromDictionary:dict];
            self.ekpCategory = [self objectOrNilForKey:kQSMerchantEkpCategory fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSMerchantPicUrl fromDictionary:dict];
            self.sellerId = [self objectOrNilForKey:kQSMerchantSellerId fromDictionary:dict];
            self.externalCategory = [self objectOrNilForKey:kQSMerchantExternalCategory fromDictionary:dict];
            self.externalCid = [self objectOrNilForKey:kQSMerchantExternalCid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.hasModified forKey:kQSMerchantHasModified];
    [mutableDict setValue:self.merchantDescription forKey:kQSMerchantDescription];
    [mutableDict setValue:self.status forKey:kQSMerchantStatus];
    [mutableDict setValue:self.websiteUrl forKey:kQSMerchantWebsiteUrl];
    [mutableDict setValue:self.tagExpression forKey:kQSMerchantTagExpression];
    [mutableDict setValue:self.brand forKey:kQSMerchantBrand];
    [mutableDict setValue:self.shopScore forKey:kQSMerchantShopScore];
    [mutableDict setValue:self.externalLevel forKey:kQSMerchantExternalLevel];
    [mutableDict setValue:self.externalShopId forKey:kQSMerchantExternalShopId];
    [mutableDict setValue:self.keywords forKey:kQSMerchantKeywords];
    [mutableDict setValue:self.memo forKey:kQSMerchantMemo];
    [mutableDict setValue:self.name forKey:kQSMerchantName];
    [mutableDict setValue:self.gmtModified forKey:kQSMerchantGmtModified];
    [mutableDict setValue:self.type forKey:kQSMerchantType];
    [mutableDict setValue:self.merchantIdentifier forKey:kQSMerchantId];
    [mutableDict setValue:self.saleVolume forKey:kQSMerchantSaleVolume];
    [mutableDict setValue:self.gmtCreated forKey:kQSMerchantGmtCreated];
    [mutableDict setValue:self.grade forKey:kQSMerchantGrade];
    [mutableDict setValue:self.isEnter forKey:kQSMerchantIsEnter];
    [mutableDict setValue:self.externalId forKey:kQSMerchantExternalId];
    [mutableDict setValue:self.ekpCategory forKey:kQSMerchantEkpCategory];
    [mutableDict setValue:self.picUrl forKey:kQSMerchantPicUrl];
    [mutableDict setValue:self.sellerId forKey:kQSMerchantSellerId];
    [mutableDict setValue:self.externalCategory forKey:kQSMerchantExternalCategory];
    [mutableDict setValue:self.externalCid forKey:kQSMerchantExternalCid];

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

    self.merchantDescription = [aDecoder decodeObjectForKey:kQSMerchantDescription];
    self.status = [aDecoder decodeObjectForKey:kQSMerchantStatus];
    self.websiteUrl = [aDecoder decodeObjectForKey:kQSMerchantWebsiteUrl];
    self.tagExpression = [aDecoder decodeObjectForKey:kQSMerchantTagExpression];
    self.brand = [aDecoder decodeObjectForKey:kQSMerchantBrand];
    self.shopScore = [aDecoder decodeObjectForKey:kQSMerchantShopScore];
    self.externalLevel = [aDecoder decodeObjectForKey:kQSMerchantExternalLevel];
    self.externalShopId = [aDecoder decodeObjectForKey:kQSMerchantExternalShopId];
    self.keywords = [aDecoder decodeObjectForKey:kQSMerchantKeywords];
    self.memo = [aDecoder decodeObjectForKey:kQSMerchantMemo];
    self.name = [aDecoder decodeObjectForKey:kQSMerchantName];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSMerchantGmtModified];
    self.type = [aDecoder decodeObjectForKey:kQSMerchantType];
    self.merchantIdentifier = [aDecoder decodeObjectForKey:kQSMerchantId];
    self.saleVolume = [aDecoder decodeObjectForKey:kQSMerchantSaleVolume];
    self.gmtCreated = [aDecoder decodeObjectForKey:kQSMerchantGmtCreated];
    self.grade = [aDecoder decodeObjectForKey:kQSMerchantGrade];
    self.isEnter = [aDecoder decodeObjectForKey:kQSMerchantIsEnter];
    self.externalId = [aDecoder decodeObjectForKey:kQSMerchantExternalId];
    self.ekpCategory = [aDecoder decodeObjectForKey:kQSMerchantEkpCategory];
    self.picUrl = [aDecoder decodeObjectForKey:kQSMerchantPicUrl];
    self.sellerId = [aDecoder decodeObjectForKey:kQSMerchantSellerId];
    self.externalCategory = [aDecoder decodeObjectForKey:kQSMerchantExternalCategory];
    self.externalCid = [aDecoder decodeObjectForKey:kQSMerchantExternalCid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_merchantDescription forKey:kQSMerchantDescription];
    [aCoder encodeObject:_status forKey:kQSMerchantStatus];
    [aCoder encodeObject:_websiteUrl forKey:kQSMerchantWebsiteUrl];
    [aCoder encodeObject:_tagExpression forKey:kQSMerchantTagExpression];
    [aCoder encodeObject:_brand forKey:kQSMerchantBrand];
    [aCoder encodeObject:_shopScore forKey:kQSMerchantShopScore];
    [aCoder encodeObject:_externalLevel forKey:kQSMerchantExternalLevel];
    [aCoder encodeObject:_externalShopId forKey:kQSMerchantExternalShopId];
    [aCoder encodeObject:_keywords forKey:kQSMerchantKeywords];
    [aCoder encodeObject:_memo forKey:kQSMerchantMemo];
    [aCoder encodeObject:_name forKey:kQSMerchantName];
    [aCoder encodeObject:_gmtModified forKey:kQSMerchantGmtModified];
    [aCoder encodeObject:_type forKey:kQSMerchantType];
    [aCoder encodeObject:_merchantIdentifier forKey:kQSMerchantId];
    [aCoder encodeObject:_saleVolume forKey:kQSMerchantSaleVolume];
    [aCoder encodeObject:_gmtCreated forKey:kQSMerchantGmtCreated];
    [aCoder encodeObject:_grade forKey:kQSMerchantGrade];
    [aCoder encodeObject:_isEnter forKey:kQSMerchantIsEnter];
    [aCoder encodeObject:_externalId forKey:kQSMerchantExternalId];
    [aCoder encodeObject:_ekpCategory forKey:kQSMerchantEkpCategory];
    [aCoder encodeObject:_picUrl forKey:kQSMerchantPicUrl];
    [aCoder encodeObject:_sellerId forKey:kQSMerchantSellerId];
    [aCoder encodeObject:_externalCategory forKey:kQSMerchantExternalCategory];
    [aCoder encodeObject:_externalCid forKey:kQSMerchantExternalCid];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSMerchant *copy = [[QSMerchant alloc] init];
    
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
