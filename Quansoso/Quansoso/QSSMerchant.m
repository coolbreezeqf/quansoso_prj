//
//  QSSMerchant.m
//
//  Created by   on 14/11/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSSMerchant.h"


NSString *const kQSSMerchantDescription = @"description";
NSString *const kQSSMerchantStatus = @"status";
NSString *const kQSSMerchantWebsiteUrl = @"website_url";
NSString *const kQSSMerchantTagExpression = @"tag_expression";
NSString *const kQSSMerchantBrand = @"brand";
NSString *const kQSSMerchantShopScore = @"shop_score";
NSString *const kQSSMerchantExternalLevel = @"external_level";
NSString *const kQSSMerchantExternalShopId = @"external_shop_id";
NSString *const kQSSMerchantKeywords = @"keywords";
NSString *const kQSSMerchantMemo = @"memo";
NSString *const kQSSMerchantName = @"name";
NSString *const kQSSMerchantGmtModified = @"gmt_modified";
NSString *const kQSSMerchantType = @"type";
NSString *const kQSSMerchantId = @"id";
NSString *const kQSSMerchantSaleVolume = @"sale_volume";
NSString *const kQSSMerchantGmtCreated = @"gmt_created";
NSString *const kQSSMerchantGrade = @"grade";
NSString *const kQSSMerchantIsEnter = @"is_enter";
NSString *const kQSSMerchantExternalId = @"external_id";
NSString *const kQSSMerchantEkpCategory = @"ekp_category";
NSString *const kQSSMerchantPicUrl = @"pic_url";
NSString *const kQSSMerchantSellerId = @"seller_id";
NSString *const kQSSMerchantExternalCategory = @"external_category";
NSString *const kQSSMerchantExternalCid = @"external_cid";


@interface QSSMerchant ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSSMerchant

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
            self.merchantDescription = [self objectOrNilForKey:kQSSMerchantDescription fromDictionary:dict];
            self.status = [self objectOrNilForKey:kQSSMerchantStatus fromDictionary:dict];
            self.websiteUrl = [self objectOrNilForKey:kQSSMerchantWebsiteUrl fromDictionary:dict];
            self.tagExpression = [self objectOrNilForKey:kQSSMerchantTagExpression fromDictionary:dict];
            self.brand = [self objectOrNilForKey:kQSSMerchantBrand fromDictionary:dict];
            self.shopScore = [self objectOrNilForKey:kQSSMerchantShopScore fromDictionary:dict];
            self.externalLevel = [self objectOrNilForKey:kQSSMerchantExternalLevel fromDictionary:dict];
            self.externalShopId = [self objectOrNilForKey:kQSSMerchantExternalShopId fromDictionary:dict];
            self.keywords = [self objectOrNilForKey:kQSSMerchantKeywords fromDictionary:dict];
            self.memo = [self objectOrNilForKey:kQSSMerchantMemo fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQSSMerchantName fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSSMerchantGmtModified fromDictionary:dict];
            self.type = [self objectOrNilForKey:kQSSMerchantType fromDictionary:dict];
            self.merchantIdentifier = [self objectOrNilForKey:kQSSMerchantId fromDictionary:dict];
            self.saleVolume = [self objectOrNilForKey:kQSSMerchantSaleVolume fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kQSSMerchantGmtCreated fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kQSSMerchantGrade fromDictionary:dict];
            self.isEnter = [self objectOrNilForKey:kQSSMerchantIsEnter fromDictionary:dict];
            self.externalId = [self objectOrNilForKey:kQSSMerchantExternalId fromDictionary:dict];
            self.ekpCategory = [self objectOrNilForKey:kQSSMerchantEkpCategory fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSSMerchantPicUrl fromDictionary:dict];
            self.sellerId = [self objectOrNilForKey:kQSSMerchantSellerId fromDictionary:dict];
            self.externalCategory = [self objectOrNilForKey:kQSSMerchantExternalCategory fromDictionary:dict];
            self.externalCid = [self objectOrNilForKey:kQSSMerchantExternalCid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.merchantDescription forKey:kQSSMerchantDescription];
    [mutableDict setValue:self.status forKey:kQSSMerchantStatus];
    [mutableDict setValue:self.websiteUrl forKey:kQSSMerchantWebsiteUrl];
    [mutableDict setValue:self.tagExpression forKey:kQSSMerchantTagExpression];
    [mutableDict setValue:self.brand forKey:kQSSMerchantBrand];
    [mutableDict setValue:self.shopScore forKey:kQSSMerchantShopScore];
    [mutableDict setValue:self.externalLevel forKey:kQSSMerchantExternalLevel];
    [mutableDict setValue:self.externalShopId forKey:kQSSMerchantExternalShopId];
    [mutableDict setValue:self.keywords forKey:kQSSMerchantKeywords];
    [mutableDict setValue:self.memo forKey:kQSSMerchantMemo];
    [mutableDict setValue:self.name forKey:kQSSMerchantName];
    [mutableDict setValue:self.gmtModified forKey:kQSSMerchantGmtModified];
    [mutableDict setValue:self.type forKey:kQSSMerchantType];
    [mutableDict setValue:self.merchantIdentifier forKey:kQSSMerchantId];
    [mutableDict setValue:self.saleVolume forKey:kQSSMerchantSaleVolume];
    [mutableDict setValue:self.gmtCreated forKey:kQSSMerchantGmtCreated];
    [mutableDict setValue:self.grade forKey:kQSSMerchantGrade];
    [mutableDict setValue:self.isEnter forKey:kQSSMerchantIsEnter];
    [mutableDict setValue:self.externalId forKey:kQSSMerchantExternalId];
    [mutableDict setValue:self.ekpCategory forKey:kQSSMerchantEkpCategory];
    [mutableDict setValue:self.picUrl forKey:kQSSMerchantPicUrl];
    [mutableDict setValue:self.sellerId forKey:kQSSMerchantSellerId];
    [mutableDict setValue:self.externalCategory forKey:kQSSMerchantExternalCategory];
    [mutableDict setValue:self.externalCid forKey:kQSSMerchantExternalCid];

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

    self.merchantDescription = [aDecoder decodeObjectForKey:kQSSMerchantDescription];
    self.status = [aDecoder decodeObjectForKey:kQSSMerchantStatus];
    self.websiteUrl = [aDecoder decodeObjectForKey:kQSSMerchantWebsiteUrl];
    self.tagExpression = [aDecoder decodeObjectForKey:kQSSMerchantTagExpression];
    self.brand = [aDecoder decodeObjectForKey:kQSSMerchantBrand];
    self.shopScore = [aDecoder decodeObjectForKey:kQSSMerchantShopScore];
    self.externalLevel = [aDecoder decodeObjectForKey:kQSSMerchantExternalLevel];
    self.externalShopId = [aDecoder decodeObjectForKey:kQSSMerchantExternalShopId];
    self.keywords = [aDecoder decodeObjectForKey:kQSSMerchantKeywords];
    self.memo = [aDecoder decodeObjectForKey:kQSSMerchantMemo];
    self.name = [aDecoder decodeObjectForKey:kQSSMerchantName];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSSMerchantGmtModified];
    self.type = [aDecoder decodeObjectForKey:kQSSMerchantType];
    self.merchantIdentifier = [aDecoder decodeObjectForKey:kQSSMerchantId];
    self.saleVolume = [aDecoder decodeObjectForKey:kQSSMerchantSaleVolume];
    self.gmtCreated = [aDecoder decodeObjectForKey:kQSSMerchantGmtCreated];
    self.grade = [aDecoder decodeObjectForKey:kQSSMerchantGrade];
    self.isEnter = [aDecoder decodeObjectForKey:kQSSMerchantIsEnter];
    self.externalId = [aDecoder decodeObjectForKey:kQSSMerchantExternalId];
    self.ekpCategory = [aDecoder decodeObjectForKey:kQSSMerchantEkpCategory];
    self.picUrl = [aDecoder decodeObjectForKey:kQSSMerchantPicUrl];
    self.sellerId = [aDecoder decodeObjectForKey:kQSSMerchantSellerId];
    self.externalCategory = [aDecoder decodeObjectForKey:kQSSMerchantExternalCategory];
    self.externalCid = [aDecoder decodeObjectForKey:kQSSMerchantExternalCid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_merchantDescription forKey:kQSSMerchantDescription];
    [aCoder encodeObject:_status forKey:kQSSMerchantStatus];
    [aCoder encodeObject:_websiteUrl forKey:kQSSMerchantWebsiteUrl];
    [aCoder encodeObject:_tagExpression forKey:kQSSMerchantTagExpression];
    [aCoder encodeObject:_brand forKey:kQSSMerchantBrand];
    [aCoder encodeObject:_shopScore forKey:kQSSMerchantShopScore];
    [aCoder encodeObject:_externalLevel forKey:kQSSMerchantExternalLevel];
    [aCoder encodeObject:_externalShopId forKey:kQSSMerchantExternalShopId];
    [aCoder encodeObject:_keywords forKey:kQSSMerchantKeywords];
    [aCoder encodeObject:_memo forKey:kQSSMerchantMemo];
    [aCoder encodeObject:_name forKey:kQSSMerchantName];
    [aCoder encodeObject:_gmtModified forKey:kQSSMerchantGmtModified];
    [aCoder encodeObject:_type forKey:kQSSMerchantType];
    [aCoder encodeObject:_merchantIdentifier forKey:kQSSMerchantId];
    [aCoder encodeObject:_saleVolume forKey:kQSSMerchantSaleVolume];
    [aCoder encodeObject:_gmtCreated forKey:kQSSMerchantGmtCreated];
    [aCoder encodeObject:_grade forKey:kQSSMerchantGrade];
    [aCoder encodeObject:_isEnter forKey:kQSSMerchantIsEnter];
    [aCoder encodeObject:_externalId forKey:kQSSMerchantExternalId];
    [aCoder encodeObject:_ekpCategory forKey:kQSSMerchantEkpCategory];
    [aCoder encodeObject:_picUrl forKey:kQSSMerchantPicUrl];
    [aCoder encodeObject:_sellerId forKey:kQSSMerchantSellerId];
    [aCoder encodeObject:_externalCategory forKey:kQSSMerchantExternalCategory];
    [aCoder encodeObject:_externalCid forKey:kQSSMerchantExternalCid];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSSMerchant *copy = [[QSSMerchant alloc] init];
    
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
