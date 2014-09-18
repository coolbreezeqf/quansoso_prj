//
//  CardCarzy.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//疯抢信息

@interface CardCarzy : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cardCarzyIdentifier;
@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *cardId;
@property (nonatomic, strong) NSString *date;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
