//
//  QSMerchantDetails.m
//
//  Created by qf  on 14/10/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSMerchantDetails.h"
#import "QSCards.h"
#import "QSActivities.h"
#import "QSMerchant.h"


NSString *const kQSBaseClassCards = @"cards";
NSString *const kQSBaseClassActivities = @"activities";
NSString *const kQSBaseClassMerchant = @"merchant";


@interface QSMerchantDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSMerchantDetails

@synthesize cards = _cards;
@synthesize activities = _activities;
@synthesize merchant = _merchant;


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
    NSObject *receivedQSCards = [dict objectForKey:kQSBaseClassCards];
    NSMutableArray *parsedQSCards = [NSMutableArray array];
    if ([receivedQSCards isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedQSCards) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedQSCards addObject:[QSCards modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedQSCards isKindOfClass:[NSDictionary class]]) {
       [parsedQSCards addObject:[QSCards modelObjectWithDictionary:(NSDictionary *)receivedQSCards]];
    }

    self.cards = [NSArray arrayWithArray:parsedQSCards];
    NSObject *receivedQSActivities = [dict objectForKey:kQSBaseClassActivities];
    NSMutableArray *parsedQSActivities = [NSMutableArray array];
    if ([receivedQSActivities isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedQSActivities) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedQSActivities addObject:[QSActivities modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedQSActivities isKindOfClass:[NSDictionary class]]) {
       [parsedQSActivities addObject:[QSActivities modelObjectWithDictionary:(NSDictionary *)receivedQSActivities]];
    }

    self.activities = [NSArray arrayWithArray:parsedQSActivities];
            self.merchant = [QSMerchant modelObjectWithDictionary:[dict objectForKey:kQSBaseClassMerchant]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCards = [NSMutableArray array];
    for (NSObject *subArrayObject in self.cards) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCards addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCards addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCards] forKey:kQSBaseClassCards];
    NSMutableArray *tempArrayForActivities = [NSMutableArray array];
    for (NSObject *subArrayObject in self.activities) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForActivities addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForActivities addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForActivities] forKey:kQSBaseClassActivities];
    [mutableDict setValue:[self.merchant dictionaryRepresentation] forKey:kQSBaseClassMerchant];

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

    self.cards = [aDecoder decodeObjectForKey:kQSBaseClassCards];
    self.activities = [aDecoder decodeObjectForKey:kQSBaseClassActivities];
    self.merchant = [aDecoder decodeObjectForKey:kQSBaseClassMerchant];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cards forKey:kQSBaseClassCards];
    [aCoder encodeObject:_activities forKey:kQSBaseClassActivities];
    [aCoder encodeObject:_merchant forKey:kQSBaseClassMerchant];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSMerchantDetails *copy = [[QSMerchantDetails alloc] init];
    
    if (copy) {

        copy.cards = [self.cards copyWithZone:zone];
        copy.activities = [self.activities copyWithZone:zone];
        copy.merchant = [self.merchant copyWithZone:zone];
    }
    
    return copy;
}


@end
