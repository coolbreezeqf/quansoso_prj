//
//  QSMerchantNetManager.h
//  Quansoso
//
//  Created by qf on 14/10/10.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSMerchantNetManager : NSObject
- (void)getMerchantWithTopID:(double)topId success:(void (^)(NSDictionary *successDict))succ failure:(void (^)())failure;

@end
