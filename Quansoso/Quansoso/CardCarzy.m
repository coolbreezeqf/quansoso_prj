//
//  CardCarzy.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CardCarzy.h"


NSString *const kCardCarzyId = @"id";
NSString *const kCardCarzyGmtCreated = @"gmt_created";
NSString *const kCardCarzyGmtModified = @"gmt_modified";
NSString *const kCardCarzyCardId = @"card_id";
NSString *const kCardCarzyDate = @"date";


@interface CardCarzy ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CardCarzy

@synthesize cardCarzyIdentifier = _cardCarzyIdentifier;
@synthesize gmtCreated = _gmtCreated;
@synthesize gmtModified = _gmtModified;
@synthesize cardId = _cardId;
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
            self.cardCarzyIdentifier = [self objectOrNilForKey:kCardCarzyId fromDictionary:dict];
            self.gmtCreated = [self objectOrNilForKey:kCardCarzyGmtCreated fromDictionary:dict];
            self.gmtModified = [self objectOrNilForKey:kCardCarzyGmtModified fromDictionary:dict];
            self.cardId = [self objectOrNilForKey:kCardCarzyCardId fromDictionary:dict];
            self.date = [self objectOrNilForKey:kCardCarzyDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cardCarzyIdentifier forKey:kCardCarzyId];
    [mutableDict setValue:self.gmtCreated forKey:kCardCarzyGmtCreated];
    [mutableDict setValue:self.gmtModified forKey:kCardCarzyGmtModified];
    [mutableDict setValue:self.cardId forKey:kCardCarzyCardId];
    [mutableDict setValue:self.date forKey:kCardCarzyDate];

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

    self.cardCarzyIdentifier = [aDecoder decodeObjectForKey:kCardCarzyId];
    self.gmtCreated = [aDecoder decodeObjectForKey:kCardCarzyGmtCreated];
    self.gmtModified = [aDecoder decodeObjectForKey:kCardCarzyGmtModified];
    self.cardId = [aDecoder decodeObjectForKey:kCardCarzyCardId];
    self.date = [aDecoder decodeObjectForKey:kCardCarzyDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cardCarzyIdentifier forKey:kCardCarzyId];
    [aCoder encodeObject:_gmtCreated forKey:kCardCarzyGmtCreated];
    [aCoder encodeObject:_gmtModified forKey:kCardCarzyGmtModified];
    [aCoder encodeObject:_cardId forKey:kCardCarzyCardId];
    [aCoder encodeObject:_date forKey:kCardCarzyDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    CardCarzy *copy = [[CardCarzy alloc] init];
    
    if (copy) {

        copy.cardCarzyIdentifier = [self.cardCarzyIdentifier copyWithZone:zone];
        copy.gmtCreated = [self.gmtCreated copyWithZone:zone];
        copy.gmtModified = [self.gmtModified copyWithZone:zone];
        copy.cardId = [self.cardId copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
