//
//  QSMerchantDetails.h
//
//  Created by qf  on 14/10/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QSMerchant;

@interface QSMerchantDetails : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *cards;
@property (nonatomic, strong) NSArray *activities;
@property (nonatomic, strong) QSMerchant *merchant;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
