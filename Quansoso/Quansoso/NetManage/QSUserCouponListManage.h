//
//  UserCouponListManage.h
//  Quansoso
//
//  Created by Johnny's on 14-10-7.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSUserCouponListManage : NSObject
@property(nonatomic) int nextPage;

- (void)getFirstUserCouponListSuccBlock:(void(^)(void))aBlock;
- (void)getNextUserCouponListSuccBlock:(void (^)(void))aBlock;
@end
