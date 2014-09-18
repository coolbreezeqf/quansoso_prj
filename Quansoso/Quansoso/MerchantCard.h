//
//  MerchantCard.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Merchant;
//商家和该商家的卡券
@interface MerchantCard : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *cards;  //of Card
@property (nonatomic, strong) Merchant *merchant;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
