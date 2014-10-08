//
//  UserCouponListManage.m
//  Quansoso
//
//  Created by Johnny's on 14-10-7.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSUserCouponListManage.h"
#import "NetManager.h"
#import <TAESDK/TAESDK.h>

@implementation QSUserCouponListManage

- (void)getFirstUserCouponListSuccBlock:(void(^)(void))aBlock
{
    _nextPage = 2;
    NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=%@&current=1&pageSize=10", KBaseUrl,[[TaeSession sharedInstance] getUser].nick];
    [NetManager requestWith:nil url:UserCouponListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        aBlock();
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];

}

- (void)getNextUserCouponListSuccBlock:(void (^)(void))aBlock
{
    NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=%@&current=%d&pageSize=10", KBaseUrl,[[TaeSession sharedInstance] getUser].nick, _nextPage];
    [NetManager requestWith:nil url:UserCouponListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        aBlock();
        _nextPage ++;
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

@end
