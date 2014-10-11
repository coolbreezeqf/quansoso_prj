//
//  QSSearchNetManager.h
//  Quansoso
//
//  Created by qf on 14/9/23.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSSearchNetManager : NSObject

- (void)searchNextContentWithSuccess:(void (^)(NSArray *results))succ failure:(void (^)())failure;

- (void)searchContent:(NSString *)content success:(void (^)(NSArray *results))succ failure:(void (^)())failure;
@end
