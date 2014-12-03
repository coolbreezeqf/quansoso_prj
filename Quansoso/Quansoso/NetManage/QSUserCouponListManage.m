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
#import "QSCards.h"

int current;
int pageSize;
int totalPage;
@implementation QSUserCouponListManage

- (void)getFirstUserCouponListSuccBlock:(void(^)(NSArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock
{
    current = 1;
    pageSize = 20;
//    NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=%@&current=1&pageSize=10", KBaseUrl,[[TaeSession sharedInstance] getUser].nick];
//    NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=易01wAwxxIxcL28uzuD2oLlS7c2DEMds1FAQI7fgfrP3PMg=&current=1&pageSize=%d", KBaseUrl, pageSize];
    NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=%@&current=1&pageSize=%d", KBaseUrl, [TaeSession sharedInstance].getUser.nick, pageSize];
    NSString *encodeStr = [UserCouponListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *pageDict = [successDict objectForKey:@"page"];
        totalPage = [[pageDict objectForKey:@"totalPage"] intValue];
        NSArray *array = [pageDict objectForKey:@"resultList"];
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (int i=0; i<array.count; i++)
        {
            QSCards *model = [QSCards modelObjectWithDictionary:[array objectAtIndex:i]];
            [mutableArray addObject:model];
        }
        totalPage = [[pageDict objectForKey:@"totalPage"] intValue];
        aSuccBlock(mutableArray);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];

}

- (void)getNextUserCouponListSuccBlock:(void(^)(NSArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock
{
    if (current<totalPage) {
        current++;
        NSString *UserCouponListUrl = [NSString stringWithFormat:@"%@?service=my_exchange&tbNick=%@&current=%d&pageSize=%d", KBaseUrl, [TaeSession sharedInstance].getUser.nick, current, pageSize];
        NSString *encodeStr = [UserCouponListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
            MLOG(@"%@", successDict);
            NSDictionary *pageDict = [successDict objectForKey:@"page"];
            NSArray *array = [pageDict objectForKey:@"resultList"];
            NSMutableArray *mutableArray = [NSMutableArray new];
            for (int i=0; i<array.count; i++)
            {
                QSCards *model = [QSCards modelObjectWithDictionary:[array objectAtIndex:i]];
                [mutableArray addObject:model];
            }
            totalPage = [[pageDict objectForKey:@"totalPage"] intValue];
            aSuccBlock(mutableArray);
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock();
        }];
    }
}

@end
