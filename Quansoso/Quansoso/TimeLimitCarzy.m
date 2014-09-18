//
//  TimeLimitCarzy.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TimeLimitCarzy.h"
#import "CardCarzy.h"
#import "Card.h"


NSString *const kTimeLimitCarzyCardCarzy = @"cardCarzy";
NSString *const kTimeLimitCarzyCard = @"card";


@interface TimeLimitCarzy ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TimeLimitCarzy

@synthesize cardCarzy = _cardCarzy;
@synthesize card = _card;


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
            self.cardCarzy = [CardCarzy modelObjectWithDictionary:[dict objectForKey:kTimeLimitCarzyCardCarzy]];
            self.card = [Card modelObjectWithDictionary:[dict objectForKey:kTimeLimitCarzyCard]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.cardCarzy dictionaryRepresentation] forKey:kTimeLimitCarzyCardCarzy];
    [mutableDict setValue:[self.card dictionaryRepresentation] forKey:kTimeLimitCarzyCard];

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

    self.cardCarzy = [aDecoder decodeObjectForKey:kTimeLimitCarzyCardCarzy];
    self.card = [aDecoder decodeObjectForKey:kTimeLimitCarzyCard];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cardCarzy forKey:kTimeLimitCarzyCardCarzy];
    [aCoder encodeObject:_card forKey:kTimeLimitCarzyCard];
}

- (id)copyWithZone:(NSZone *)zone
{
    TimeLimitCarzy *copy = [[TimeLimitCarzy alloc] init];
    
    if (copy) {

        copy.cardCarzy = [self.cardCarzy copyWithZone:zone];
        copy.card = [self.card copyWithZone:zone];
    }
    
    return copy;
}


@end
