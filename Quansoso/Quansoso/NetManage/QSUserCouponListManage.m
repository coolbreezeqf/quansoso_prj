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

int current;
int pageSize;
int totalPage;
@implementation QSUserCouponListManage

- (void)getFirstUserCouponListSuccBlock:(void(^)(NSArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock
{
    current = 1;
    pageSize = 20;
//    NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=%@&current=1&pageSize=10", KBaseUrl,[[TaeSession sharedInstance] getUser].nick];
    NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=j**t&current=1&pageSize=%d", KBaseUrl, pageSize];
    [NetManager requestWith:nil url:UserCouponListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
//        totalPage = [[pageDict objectForKey:@"totalPage"] intValue];
        aSuccBlock([NSArray new]);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];

}

- (void)getNextUserCouponListSuccBlock:(void(^)(NSArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock
{
    if (current<totalPage) {
        current++;
        NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=%@&current=%d&pageSize=10", KBaseUrl,[[TaeSession sharedInstance] getUser].nick, current];
        [NetManager requestWith:nil url:UserCouponListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
            MLOG(@"%@", successDict);
    //        aBlock();
        } failure:^(NSDictionary *failDict, NSError *error) {
            
        }];
    }
}

@end
