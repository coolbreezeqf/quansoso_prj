//
//  TimeLimitCarzy.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CardCarzy, Card;
//限时疯抢
@interface TimeLimitCarzy : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) CardCarzy *cardCarzy;
@property (nonatomic, strong) Card *card;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
