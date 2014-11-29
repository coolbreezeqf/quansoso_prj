//
//  AttentionBrandListManage.m
//  Quansoso
//
//  Created by Johnny's on 14-10-6.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSAttentionBrandListManage.h"
#import <TAESDK/TAESDK.h>
#import "NetManager.h"
#import "QSMerchant.h"

int current;
int pageSize;
int totalPage;
BOOL isIndex;
@implementation QSAttentionBrandListManage

- (void)getFirstAttentionBrandListSuccBlock:(void(^)(NSMutableArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock isIndex:(BOOL)aBool
{
    current = 1;
    if (aBool==YES)
    {
        pageSize = 9;
    }
    else
    {
        pageSize = 20;
    }
    NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=my_follow&tbNick=%@&current=%d&pageSize=%d", KBaseUrl, [TaeSession sharedInstance].getUser.nick, current,pageSize];
    MLOG(@"%@", [TaeSession sharedInstance].getUser);
    NSString *encodeStr = [BrandListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *pageDict = [successDict objectForKey:@"page"];
        totalPage = [[pageDict objectForKey:@"totalPage"] intValue];
        NSArray *array = [pageDict objectForKey:@"resultList"];
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (int i=0; i<array.count; i++)
        {
            QSMerchant *model = [QSMerchant modelObjectWithDictionary:[array objectAtIndex:i]];
            [mutableArray addObject:model];
        }
        aSuccBlock(mutableArray);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}

- (void)getNextAttentionBrandListSuccBlock:(void(^)(NSArray *))aBlock andFailBlock:(void(^)(void))aFailBlock
{
    if (current<totalPage) {
        current++;
//        NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=merchants&tbNick=j**t&current=%d&pageSize=%d", KBaseUrl, current,pageSize];
        NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=my_follow&tbNick=%@&current=%d&pageSize=%d", KBaseUrl, [TaeSession sharedInstance].getUser.nick, current,pageSize];
        MLOG(@"%@", [TaeSession sharedInstance].getUser);
        NSString *encodeStr = [BrandListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
            MLOG(@"%@", successDict);
            NSDictionary *pageDict = [successDict objectForKey:@"page"];
            totalPage = [[pageDict objectForKey:@"totalPage"] intValue];
            NSArray *array = [pageDict objectForKey:@"resultList"];
            NSMutableArray *mutableArray = [NSMutableArray new];
            for (int i=0; i<array.count; i++)
            {
                QSMerchant *model = [QSMerchant modelObjectWithDictionary:[array objectAtIndex:i]];
                [mutableArray addObject:model];
            }
            aBlock(mutableArray);
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock();
        }];
    }
}
@end
