//
//  QSCardDetails.h
//  Quansoso
//
//  Created by qf on 14/11/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSCardDetailsNetManager: NSObject
- (void)getCardUseCouponId:(NSString *)couponId andNick:(NSString *)nick success:(void (^)(NSString* describe))succ failure:(void (^)(NSString* describe))failure;
@end
