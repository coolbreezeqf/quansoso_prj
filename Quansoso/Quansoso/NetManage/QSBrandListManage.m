//
//  BrandListManage.m
//  Quansoso
//
//  Created by Johnny's on 14-10-6.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandListManage.h"
#import "NetManager.h"
#import "QSMerchant.h"

int current;
int pageSize;
int totalPage;
@implementation QSBrandListManage

- (void)getBrandListPageSize:(int)aPageSize andSuccBlock:(void(^)(NSMutableArray *aArray))aBlock andFailBlock:(void(^)(void))aFailBlock;
{
    current = 1;
    pageSize = aPageSize;
    NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=merchants&tbNick=aa&current=%d&pageSize=%d", KBaseUrl, current,pageSize];
    [NetManager requestWith:nil url:BrandListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
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

- (void)getNextBrandListSuccBlock:(void(^)(NSArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock
{
    if (current<totalPage) {
        current++;
        NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=merchants&tbNick=aa&current=%d&pageSize=%d", KBaseUrl, current,pageSize];
        [NetManager requestWith:nil url:BrandListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
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
}


@end
