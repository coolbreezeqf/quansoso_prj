//
//  QSSearchNetManager.h
//  Quansoso
//
//  Created by qf on 14/9/23.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface QSSearchNetManager : NSObject

+ (NSDictionary *)searchContent:(NSDictionary *)content success:(void (^)(NSDictionary *successDict))succ failure:(void (^)())failure;

@end
