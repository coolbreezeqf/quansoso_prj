//
//  QSUser.h
//  Quansoso
//
//  Created by qf on 14/10/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaeUser;

@interface QSUser : NSObject
@property (nonatomic,strong) TaeUser *user;

+ (QSUser *)sharedQSUser;

@end
