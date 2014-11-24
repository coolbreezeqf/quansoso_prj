//
//  Results.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Result.h"
#import "ResultCard.h"


NSString *const kResultsDescription = @"description";
NSString *const kResultsCategory = @"category";
NSString *const kResultsHasPromotion = @"hasPromotion";
NSString *const kResultsPicUrl = @"picUrl";
NSString *const kResultsEkpCategory = @"ekpCategory";
NSString *const kResultsShopScore = @"shopScore";
NSString *const kResultsBrand = @"brand";
NSString *const kResultsTopId = @"topId";
NSString *const kResultsCid = @"cid";
NSString *const kResultsType = @"type";
NSString *const kResultsLevel = @"level";
NSString *const kResultsKeywords = @"keywords";
NSString *const kResultsCard = @"card";
NSString *const kResultsShopId = @"shopId";
NSString *const kResultsWebsiteUrl = @"websiteUrl";
NSString *const kResultsIsEnter = @"isEnter";
NSString *const kResultsName = @"name";


@interface Result ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Result

@synthesize resultsDescription = _resultsDescription;
@synthesize category = _category;
@synthesize hasPromotion = _hasPromotion;
@synthesize picUrl = _picUrl;
@synthesize ekpCategory = _ekpCategory;
@synthesize shopScore = _shopScore;
@synthesize brand = _brand;
@synthesize topId = _topId;
@synthesize cid = _cid;
@synthesize type = _type;
@synthesize level = _level;
@synthesize keywords = _keywords;
@synthesize card = _card;
@synthesize shopId = _shopId;
@synthesize websiteUrl = _websiteUrl;
@synthesize isEnter = _isEnter;
@synthesize name = _name;


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
            self.resultsDescription = [self objectOrNilForKey:kResultsDescription fromDictionary:dict];
            self.category = [self objectOrNilForKey:kResultsCategory fromDictionary:dict];
            self.hasPromotion = [[self objectOrNilForKey:kResultsHasPromotion fromDictionary:dict] doubleValue];
            self.picUrl = [self objectOrNilForKey:kResultsPicUrl fromDictionary:dict];
            self.ekpCategory = [[self objectOrNilForKey:kResultsEkpCategory fromDictionary:dict] doubleValue];
            self.shopScore = [self objectOrNilForKey:kResultsShopScore fromDictionary:dict];
            self.brand = [self objectOrNilForKey:kResultsBrand fromDictionary:dict];
            self.topId = [[self objectOrNilForKey:kResultsTopId fromDictionary:dict] doubleValue];
            self.cid = [[self objectOrNilForKey:kResultsCid fromDictionary:dict] doubleValue];
            self.type = [[self objectOrNilForKey:kResultsType fromDictionary:dict] doubleValue];
            self.level = [[self objectOrNilForKey:kResultsLevel fromDictionary:dict] doubleValue];
            self.keywords = [self objectOrNilForKey:kResultsKeywords fromDictionary:dict];
    NSObject *receivedCard = [dict objectForKey:kResultsCard];
    NSMutableArray *parsedCard = [NSMutableArray array];
    if ([receivedCard isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCard) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCard addObject:[ResultCard modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCard isKindOfClass:[NSDictionary class]]) {
       [parsedCard addObject:[ResultCard modelObjectWithDictionary:(NSDictionary *)receivedCard]];
    }

    self.card = [NSArray arrayWithArray:parsedCard];
            self.shopId = [[self objectOrNilForKey:kResultsShopId fromDictionary:dict] integerValue];
            self.websiteUrl = [self objectOrNilForKey:kResultsWebsiteUrl fromDictionary:dict];
            self.isEnter = [[self objectOrNilForKey:kResultsIsEnter fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kResultsName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.resultsDescription forKey:kResultsDescription];
    [mutableDict setValue:self.category forKey:kResultsCategory];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hasPromotion] forKey:kResultsHasPromotion];
    [mutableDict setValue:self.picUrl forKey:kResultsPicUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ekpCategory] forKey:kResultsEkpCategory];
    [mutableDict setValue:self.shopScore forKey:kResultsShopScore];
    [mutableDict setValue:self.brand forKey:kResultsBrand];
    [mutableDict setValue:[NSNumber numberWithDouble:self.topId] forKey:kResultsTopId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cid] forKey:kResultsCid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kResultsType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.level] forKey:kResultsLevel];
    [mutableDict setValue:self.keywords forKey:kResultsKeywords];
    NSMutableArray *tempArrayForCard = [NSMutableArray array];
    for (NSObject *subArrayObject in self.card) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCard addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCard addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCard] forKey:kResultsCard];
    [mutableDict setValue:[NSNumber numberWithInteger:self.shopId] forKey:kResultsShopId];
    [mutableDict setValue:self.websiteUrl forKey:kResultsWebsiteUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isEnter] forKey:kResultsIsEnter];
    [mutableDict setValue:self.name forKey:kResultsName];

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

    self.resultsDescription = [aDecoder decodeObjectForKey:kResultsDescription];
    self.category = [aDecoder decodeObjectForKey:kResultsCategory];
    self.hasPromotion = [aDecoder decodeDoubleForKey:kResultsHasPromotion];
    self.picUrl = [aDecoder decodeObjectForKey:kResultsPicUrl];
    self.ekpCategory = [aDecoder decodeDoubleForKey:kResultsEkpCategory];
    self.shopScore = [aDecoder decodeObjectForKey:kResultsShopScore];
    self.brand = [aDecoder decodeObjectForKey:kResultsBrand];
    self.topId = [aDecoder decodeDoubleForKey:kResultsTopId];
    self.cid = [aDecoder decodeDoubleForKey:kResultsCid];
    self.type = [aDecoder decodeDoubleForKey:kResultsType];
    self.level = [aDecoder decodeDoubleForKey:kResultsLevel];
    self.keywords = [aDecoder decodeObjectForKey:kResultsKeywords];
    self.card = [aDecoder decodeObjectForKey:kResultsCard];
    self.shopId = [aDecoder decodeIntegerForKey:kResultsShopId];
    self.websiteUrl = [aDecoder decodeObjectForKey:kResultsWebsiteUrl];
    self.isEnter = [aDecoder decodeDoubleForKey:kResultsIsEnter];
    self.name = [aDecoder decodeObjectForKey:kResultsName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_resultsDescription forKey:kResultsDescription];
    [aCoder encodeObject:_category forKey:kResultsCategory];
    [aCoder encodeDouble:_hasPromotion forKey:kResultsHasPromotion];
    [aCoder encodeObject:_picUrl forKey:kResultsPicUrl];
    [aCoder encodeDouble:_ekpCategory forKey:kResultsEkpCategory];
    [aCoder encodeObject:_shopScore forKey:kResultsShopScore];
    [aCoder encodeObject:_brand forKey:kResultsBrand];
    [aCoder encodeDouble:_topId forKey:kResultsTopId];
    [aCoder encodeDouble:_cid forKey:kResultsCid];
    [aCoder encodeDouble:_type forKey:kResultsType];
    [aCoder encodeDouble:_level forKey:kResultsLevel];
    [aCoder encodeObject:_keywords forKey:kResultsKeywords];
    [aCoder encodeObject:_card forKey:kResultsCard];
    [aCoder encodeInteger:_shopId forKey:kResultsShopId];
    [aCoder encodeObject:_websiteUrl forKey:kResultsWebsiteUrl];
    [aCoder encodeDouble:_isEnter forKey:kResultsIsEnter];
    [aCoder encodeObject:_name forKey:kResultsName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Result *copy = [[Result alloc] init];
    
    if (copy) {

        copy.resultsDescription = [self.resultsDescription copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.hasPromotion = self.hasPromotion;
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.ekpCategory = self.ekpCategory;
        copy.shopScore = [self.shopScore copyWithZone:zone];
        copy.brand = [self.brand copyWithZone:zone];
        copy.topId = self.topId;
        copy.cid = self.cid;
        copy.type = self.type;
        copy.level = self.level;
        copy.keywords = [self.keywords copyWithZone:zone];
        copy.card = [self.card copyWithZone:zone];
        copy.shopId = self.shopId;
        copy.websiteUrl = [self.websiteUrl copyWithZone:zone];
        copy.isEnter = self.isEnter;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
