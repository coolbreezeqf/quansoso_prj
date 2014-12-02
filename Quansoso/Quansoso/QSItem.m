//
//  QSBaseClass.m
//
//  Created by qf  on 14/12/1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "QSItem.h"


NSString *const kQSBaseClassOpenIid = @"openIid";
NSString *const kQSBaseClassTitle = @"title";
NSString *const kQSBaseClassNick = @"nick";
NSString *const kQSBaseClassPrice = @"price";
NSString *const kQSBaseClassPicUrl = @"picUrl";


@interface QSItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QSItem

@synthesize openIid = _openIid;
@synthesize title = _title;
@synthesize nick = _nick;
@synthesize price = _price;
@synthesize picUrl = _picUrl;


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
            self.openIid = [self objectOrNilForKey:kQSBaseClassOpenIid fromDictionary:dict];
            self.title = [self objectOrNilForKey:kQSBaseClassTitle fromDictionary:dict];
            self.nick = [self objectOrNilForKey:kQSBaseClassNick fromDictionary:dict];
            self.price = [self objectOrNilForKey:kQSBaseClassPrice fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kQSBaseClassPicUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.openIid forKey:kQSBaseClassOpenIid];
    [mutableDict setValue:self.title forKey:kQSBaseClassTitle];
    [mutableDict setValue:self.nick forKey:kQSBaseClassNick];
    [mutableDict setValue:self.price forKey:kQSBaseClassPrice];
    [mutableDict setValue:self.picUrl forKey:kQSBaseClassPicUrl];

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

    self.openIid = [aDecoder decodeObjectForKey:kQSBaseClassOpenIid];
    self.title = [aDecoder decodeObjectForKey:kQSBaseClassTitle];
    self.nick = [aDecoder decodeObjectForKey:kQSBaseClassNick];
    self.price = [aDecoder decodeObjectForKey:kQSBaseClassPrice];
    self.picUrl = [aDecoder decodeObjectForKey:kQSBaseClassPicUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_openIid forKey:kQSBaseClassOpenIid];
    [aCoder encodeObject:_title forKey:kQSBaseClassTitle];
    [aCoder encodeObject:_nick forKey:kQSBaseClassNick];
    [aCoder encodeObject:_price forKey:kQSBaseClassPrice];
    [aCoder encodeObject:_picUrl forKey:kQSBaseClassPicUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    QSItem *copy = [[QSItem alloc] init];
    
    if (copy) {

        copy.openIid = [self.openIid copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.nick = [self.nick copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
