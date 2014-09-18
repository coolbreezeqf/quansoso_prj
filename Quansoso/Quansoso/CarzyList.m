//
//  CarzyList.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CarzyList.h"
#import "TimeLimitCarzy.h"

NSString *const kCarzyListCarzies = @"carzies";


@interface CarzyList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CarzyList

@synthesize carzies = _carzies;


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
    NSObject *receivedCarzies = [dict objectForKey:kCarzyListCarzies];
    NSMutableArray *parsedCarzies = [NSMutableArray array];
    if ([receivedCarzies isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCarzies) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCarzies addObject:[TimeLimitCarzy modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCarzies isKindOfClass:[NSDictionary class]]) {
       [parsedCarzies addObject:[TimeLimitCarzy modelObjectWithDictionary:(NSDictionary *)receivedCarzies]];
    }

    self.carzies = [NSArray arrayWithArray:parsedCarzies];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCarzies = [NSMutableArray array];
    for (NSObject *subArrayObject in self.carzies) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCarzies addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCarzies addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCarzies] forKey:kCarzyListCarzies];

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

    self.carzies = [aDecoder decodeObjectForKey:kCarzyListCarzies];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_carzies forKey:kCarzyListCarzies];
}

- (id)copyWithZone:(NSZone *)zone
{
    CarzyList *copy = [[CarzyList alloc] init];
    
    if (copy) {

        copy.carzies = [self.carzies copyWithZone:zone];
    }
    
    return copy;
}


@end
