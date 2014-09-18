//
//  Results.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Search result

@interface Result : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *resultsDescription;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) double hasPromotion;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, assign) double ekpCategory;
@property (nonatomic, strong) NSString *shopScore;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, assign) double topId;
@property (nonatomic, assign) double cid;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double level;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSArray *card;  //of ResultCard
@property (nonatomic, assign) double shopId;
@property (nonatomic, strong) NSString *websiteUrl;
@property (nonatomic, assign) double isEnter;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
