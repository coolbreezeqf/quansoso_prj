//
//  SearchInfo.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SearchInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *results; //of  Result
@property (nonatomic, assign) double currentPage;
@property (nonatomic, assign) double totalCount;
@property (nonatomic, assign) double totalPage;
@property (nonatomic, assign) double pageSize;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
