//
//  Card.m
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ResultCard.h"


NSString *const kResultCardId = @"id";
NSString *const kResultCardStart = @"start";
NSString *const kResultCardDescription = @"description";
NSString *const kResultCardExpression = @"expression";
NSString *const kResultCardPicUrl = @"picUrl";
NSString *const kResultCardMoneyCondition = @"moneyCondition";
NSString *const kResultCardSold = @"sold";
NSString *const kResultCardStocks = @"stocks";
NSString *const kResultCardType = @"type";
NSString *const kResultCardSourceId = @"sourceId";
NSString *const kResultCardDenomination = @"denomination";
NSString *const kResultCardMerchantName = @"merchantName";
NSString *const kResultCardProviderId = @"providerId";
NSString *const kResultCardEnd = @"end";
NSString *const kResultCardName = @"name";
NSString *const kResultCardStatus = @"status";


@interface ResultCard ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ResultCard

@synthesize resultCardIdentifier = _resultCardIdentifier;
@synthesize start = _start;
@synthesize resultCardDescription = _resultCardDescription;
@synthesize expression = _expression;
@synthesize picUrl = _picUrl;
@synthesize moneyCondition = _moneyCondition;
@synthesize sold = _sold;
@synthesize stocks = _stocks;
@synthesize type = _type;
@synthesize sourceId = _sourceId;
@synthesize denomination = _denomination;
@synthesize merchantName = _merchantName;
@synthesize providerId = _providerId;
@synthesize endProperty = _endProperty;
@synthesize name = _name;
@synthesize status = _status;


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
            self.resultCardIdentifier = [[self objectOrNilForKey:kResultCardId fromDictionary:dict] doubleValue];
            self.start = [self objectOrNilForKey:kResultCardStart fromDictionary:dict];
            self.resultCardDescription = [self objectOrNilForKey:kResultCardDescription fromDictionary:dict];
            self.expression = [self objectOrNilForKey:kResultCardExpression fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kResultCardPicUrl fromDictionary:dict];
            self.moneyCondition = [[self objectOrNilForKey:kResultCardMoneyCondition fromDictionary:dict] doubleValue];
            self.sold = [[self objectOrNilForKey:kResultCardSold fromDictionary:dict] doubleValue];
            self.stocks = [[self objectOrNilForKey:kResultCardStocks fromDictionary:dict] doubleValue];
            self.type = [[self objectOrNilForKey:kResultCardType fromDictionary:dict] doubleValue];
            self.sourceId = [[self objectOrNilForKey:kResultCardSourceId fromDictionary:dict] doubleValue];
            self.denomination = [[self objectOrNilForKey:kResultCardDenomination fromDictionary:dict] doubleValue];
            self.merchantName = [self objectOrNilForKey:kResultCardMerchantName fromDictionary:dict];
            self.providerId = [[self objectOrNilForKey:kResultCardProviderId fromDictionary:dict] doubleValue];
            self.endProperty = [self objectOrNilForKey:kResultCardEnd fromDictionary:dict];
            self.name = [self objectOrNilForKey:kResultCardName fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kResultCardStatus fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultCardIdentifier] forKey:kResultCardId];
    [mutableDict setValue:self.start forKey:kResultCardStart];
    [mutableDict setValue:self.resultCardDescription forKey:kResultCardDescription];
    [mutableDict setValue:self.expression forKey:kResultCardExpression];
    [mutableDict setValue:self.picUrl forKey:kResultCardPicUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.moneyCondition] forKey:kResultCardMoneyCondition];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sold] forKey:kResultCardSold];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stocks] forKey:kResultCardStocks];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kResultCardType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sourceId] forKey:kResultCardSourceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.denomination] forKey:kResultCardDenomination];
    [mutableDict setValue:self.merchantName forKey:kResultCardMerchantName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.providerId] forKey:kResultCardProviderId];
    [mutableDict setValue:self.endProperty forKey:kResultCardEnd];
    [mutableDict setValue:self.name forKey:kResultCardName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kResultCardStatus];

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

    self.resultCardIdentifier = [aDecoder decodeDoubleForKey:kResultCardId];
    self.start = [aDecoder decodeObjectForKey:kResultCardStart];
    self.resultCardDescription = [aDecoder decodeObjectForKey:kResultCardDescription];
    self.expression = [aDecoder decodeObjectForKey:kResultCardExpression];
    self.picUrl = [aDecoder decodeObjectForKey:kResultCardPicUrl];
    self.moneyCondition = [aDecoder decodeDoubleForKey:kResultCardMoneyCondition];
    self.sold = [aDecoder decodeDoubleForKey:kResultCardSold];
    self.stocks = [aDecoder decodeDoubleForKey:kResultCardStocks];
    self.type = [aDecoder decodeDoubleForKey:kResultCardType];
    self.sourceId = [aDecoder decodeDoubleForKey:kResultCardSourceId];
    self.denomination = [aDecoder decodeDoubleForKey:kResultCardDenomination];
    self.merchantName = [aDecoder decodeObjectForKey:kResultCardMerchantName];
    self.providerId = [aDecoder decodeDoubleForKey:kResultCardProviderId];
    self.endProperty = [aDecoder decodeObjectForKey:kResultCardEnd];
    self.name = [aDecoder decodeObjectForKey:kResultCardName];
    self.status = [aDecoder decodeDoubleForKey:kResultCardStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultCardIdentifier forKey:kResultCardId];
    [aCoder encodeObject:_start forKey:kResultCardStart];
    [aCoder encodeObject:_resultCardDescription forKey:kResultCardDescription];
    [aCoder encodeObject:_expression forKey:kResultCardExpression];
    [aCoder encodeObject:_picUrl forKey:kResultCardPicUrl];
    [aCoder encodeDouble:_moneyCondition forKey:kResultCardMoneyCondition];
    [aCoder encodeDouble:_sold forKey:kResultCardSold];
    [aCoder encodeDouble:_stocks forKey:kResultCardStocks];
    [aCoder encodeDouble:_type forKey:kResultCardType];
    [aCoder encodeDouble:_sourceId forKey:kResultCardSourceId];
    [aCoder encodeDouble:_denomination forKey:kResultCardDenomination];
    [aCoder encodeObject:_merchantName forKey:kResultCardMerchantName];
    [aCoder encodeDouble:_providerId forKey:kResultCardProviderId];
    [aCoder encodeObject:_endProperty forKey:kResultCardEnd];
    [aCoder encodeObject:_name forKey:kResultCardName];
    [aCoder encodeDouble:_status forKey:kResultCardStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    ResultCard *copy = [[ResultCard alloc] init];
    
    if (copy) {

        copy.resultCardIdentifier = self.resultCardIdentifier;
        copy.start = [self.start copyWithZone:zone];
        copy.resultCardDescription = [self.resultCardDescription copyWithZone:zone];
        copy.expression = [self.expression copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.moneyCondition = self.moneyCondition;
        copy.sold = self.sold;
        copy.stocks = self.stocks;
        copy.type = self.type;
        copy.sourceId = self.sourceId;
        copy.denomination = self.denomination;
        copy.merchantName = [self.merchantName copyWithZone:zone];
        copy.providerId = self.providerId;
        copy.endProperty = [self.endProperty copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.status = self.status;
    }
    
    return copy;
}


@end
