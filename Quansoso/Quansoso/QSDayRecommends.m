//
//  QSDayRecommends.m
//
//  Created by able  on 14-10-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSDayRecommends.h"


NSString *const kQSDayRecommendsGmtCreated = @"gmt_created";
NSString *const kQSDayRecommendsPicUrl = @"pic_url";
NSString *const kQSDayRecommendsExternalId = @"external_id";
NSString *const kQSDayRecommendsName = @"name";
NSString *const kQSDayRecommendsGmtModified = @"gmt_modified";
NSString *const kQSDayRecommendsDate = @"date";


@interface QSDayRecommends ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSDayRecommends

@synthesize gmtCreated = _gmtCreated;
@synthesize picUrl = _picUrl;
@synthesize externalId = _externalId;
@synthesize name = _name;
@synthesize gmtModified = _gmtModified;
@synthesize date = _date;


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
            self.gmtCreated = [self objectOrNilForKey:kQSDayRecommendsGmtCreated fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSDayRecommendsPicUrl fromDictionary:dict];
            self.externalId = [self objectOrNilForKey:kQSDayRecommendsExternalId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kQSDayRecommendsName fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kQSDayRecommendsGmtModified fromDictionary:dict];
            self.date = [self objectOrNilForKey:kQSDayRecommendsDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.gmtCreated forKey:kQSDayRecommendsGmtCreated];
    [mutableDict setValue:self.picUrl forKey:kQSDayRecommendsPicUrl];
    [mutableDict setValue:self.externalId forKey:kQSDayRecommendsExternalId];
    [mutableDict setValue:self.name forKey:kQSDayRecommendsName];
    [mutableDict setValue:self.gmtModified forKey:kQSDayRecommendsGmtModified];
    [mutableDict setValue:self.date forKey:kQSDayRecommendsDate];

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

    self.gmtCreated = [aDecoder decodeObjectForKey:kQSDayRecommendsGmtCreated];
    self.picUrl = [aDecoder decodeObjectForKey:kQSDayRecommendsPicUrl];
    self.externalId = [aDecoder decodeObjectForKey:kQSDayRecommendsExternalId];
    self.name = [aDecoder decodeObjectForKey:kQSDayRecommendsName];
    self.gmtModified = [aDecoder decodeObjectForKey:kQSDayRecommendsGmtModified];
    self.date = [aDecoder decodeObjectForKey:kQSDayRecommendsDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_gmtCreated forKey:kQSDayRecommendsGmtCreated];
    [aCoder encodeObject:_picUrl forKey:kQSDayRecommendsPicUrl];
    [aCoder encodeObject:_externalId forKey:kQSDayRecommendsExternalId];
    [aCoder encodeObject:_name forKey:kQSDayRecommendsName];
    [aCoder encodeObject:_gmtModified forKey:kQSDayRecommendsGmtModified];
    [aCoder encodeObject:_date forKey:kQSDayRecommendsDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSDayRecommends *copy = [[QSDayRecommends alloc] init];
    
    if (copy) {

        copy.gmtCreated = [self.gmtCreated copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.externalId = [self.externalId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.gmtModified = [self.gmtModified copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
