//
//  MerchantCard.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MerchantCard.h"
#import "Merchant.h"
#import "Card.h"

NSString *const kMerchantCardCards = @"cards";
NSString *const kMerchantCardMerchant = @"merchant";


@interface MerchantCard ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MerchantCard

@synthesize cards = _cards;
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
    NSObject *receivedCards = [dict objectForKey:kMerchantCardCards];
    NSMutableArray *parsedCards = [NSMutableArray array];
    if ([receivedCards isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCards) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCards addObject:[Card modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCards isKindOfClass:[NSDictionary class]]) {
       [parsedCards addObject:[Card modelObjectWithDictionary:(NSDictionary *)receivedCards]];
    }

    self.cards = [NSArray arrayWithArray:parsedCards];
            self.merchant = [Merchant modelObjectWithDictionary:[dict objectForKey:kMerchantCardMerchant]];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCards] forKey:kMerchantCardCards];
    [mutableDict setValue:[self.merchant dictionaryRepresentation] forKey:kMerchantCardMerchant];

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

    self.cards = [aDecoder decodeObjectForKey:kMerchantCardCards];
    self.merchant = [aDecoder decodeObjectForKey:kMerchantCardMerchant];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cards forKey:kMerchantCardCards];
    [aCoder encodeObject:_merchant forKey:kMerchantCardMerchant];
}

- (id)copyWithZone:(NSZone *)zone
{
    MerchantCard *copy = [[MerchantCard alloc] init];
    
    if (copy) {

        copy.cards = [self.cards copyWithZone:zone];
        copy.merchant = [self.merchant copyWithZone:zone];
    }
    
    return copy;
}


@end
