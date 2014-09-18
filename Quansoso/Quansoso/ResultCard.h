//
//  ResultCard.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Card-info of Search Result

@interface ResultCard : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultCardIdentifier;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *resultCardDescription;
@property (nonatomic, strong) NSString *expression;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, assign) double moneyCondition;
@property (nonatomic, assign) double sold;
@property (nonatomic, assign) double stocks;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double sourceId;
@property (nonatomic, assign) double denomination;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, assign) double providerId;
@property (nonatomic, strong) NSString *endProperty;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
