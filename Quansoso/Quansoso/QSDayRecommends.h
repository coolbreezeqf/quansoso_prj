//
//  QSDayRecommends.h
//
//  Created by able  on 14-10-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QSDayRecommends : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *gmtCreated;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *externalId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gmtModified;
@property (nonatomic, strong) NSString *date;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
