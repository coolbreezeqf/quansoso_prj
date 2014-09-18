//
//  CarzyList.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//往期的“疯抢”

@interface CarzyList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *carzies;  //of TimeLimitCarzy

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
