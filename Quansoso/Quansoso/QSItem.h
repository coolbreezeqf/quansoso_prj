//
//  QSBaseClass.h
//
//  Created by qf  on 14/12/1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QSItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *openIid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *picUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
