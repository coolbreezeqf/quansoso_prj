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
#import "QSDataSevice.h"

int currentNine;
int currentTwenty;
int pageSizeNine;
int pageSizeTwenty;
int totalPageNine;
int totalPageTwenty;
BOOL isIndex;
@implementation QSAttentionBrandListManage

- (void)getFirstAttentionBrandListSuccBlock:(void(^)(NSMutableArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock isIndex:(BOOL)aBool
{
    pageSizeNine = 9;
    pageSizeTwenty = 20;
    NSString *time = [[QSDataSevice sharedQSDataSevice] getTime];
    if (!time)
    {
        time = [self getNowTime];
    }
    NSMutableDictionary *dict = [[QSDataSevice sharedQSDataSevice] getDict];
    if (!dict)
    {
        dict = [NSMutableDictionary new];
    }
    int current=1;
    int pageSize;
    if (aBool==YES)
    {
        currentNine=1;
        pageSize = pageSizeNine;
    }
    else
    {
        currentTwenty=1;
        pageSize = pageSizeTwenty;
    }
    NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=my_follow&tbNick=%@&current=%d&pageSize=%d&lastModified=%@", KBaseUrl, [TaeSession sharedInstance].getUser.nick, current,pageSize, time];
    MLOG(@"%@", [TaeSession sharedInstance].getUser);
    NSString *encodeStr = [BrandListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *pageDict = [successDict objectForKey:@"page"];
        if (aBool==YES)
        {
            totalPageNine = [[pageDict objectForKey:@"totalPage"] intValue];
        }
        else
        {
            totalPageTwenty = [[pageDict objectForKey:@"totalPage"] intValue];
        }
        NSArray *array = [pageDict objectForKey:@"resultList"];
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (int i=0; i<array.count; i++)
        {
            QSMerchant *model = [QSMerchant modelObjectWithDictionary:[array objectAtIndex:i]];
            if (model.externalShopId && model.externalShopId>0)
            {
                int count = [[dict objectForKey:model.externalShopId] intValue];
                if (count && count)
                {
                    [dict setObject:[NSString stringWithFormat:@"%d", count+[model.hasModified intValue]] forKey:model.externalShopId];
                }
                else
                {
                    [dict setObject:[NSString stringWithFormat:@"%d", [model.hasModified intValue]] forKey:model.externalShopId];
                }
            }
            [mutableArray addObject:model];
        }
        [[QSDataSevice sharedQSDataSevice] saveTime:[self getNowTime]];
        [[QSDataSevice sharedQSDataSevice] saveRedDict:dict];
        aSuccBlock(mutableArray);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}

- (void)getNextAttentionBrandListSuccBlock:(void(^)(NSArray *))aBlock andFailBlock:(void(^)(void))aFailBlock voidBlock:(void(^)(void))aVoidBlock isIndex:(BOOL)aBool
{
    int totalPage;
    int current;
    int pageSize;
    if (aBool==YES)
    {
        totalPage = totalPageNine;
        current = currentNine;
        pageSize = pageSizeNine;
    }
    else
    {
        totalPage = totalPageTwenty;
        current = currentTwenty;
        pageSize = pageSizeTwenty;
    }
    if (current<totalPage) {
        current++;
        NSString *time = [[QSDataSevice sharedQSDataSevice] getTime];
        if (!time)
        {
            time = [self getNowTime];
        }
        NSMutableDictionary *dict = [[QSDataSevice sharedQSDataSevice] getDict];
        if (!dict)
        {
            dict = [NSMutableDictionary new];
        }
        NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=my_follow&tbNick=%@&current=%d&pageSize=%d&lastModified=%@", KBaseUrl, [TaeSession sharedInstance].getUser.nick, current,pageSize, time];
        MLOG(@"%@", [TaeSession sharedInstance].getUser);
        NSString *encodeStr = [BrandListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
//            MLOG(@"%@", successDict);
            NSDictionary *pageDict = [successDict objectForKey:@"page"];
            if (aBool==YES)
            {
                currentNine++;
                totalPageNine = [[pageDict objectForKey:@"totalPage"] intValue];
            }
            else
            {
                currentTwenty++;
                totalPageTwenty = [[pageDict objectForKey:@"totalPage"] intValue];
            }
            NSArray *array = [pageDict objectForKey:@"resultList"];
            NSMutableArray *mutableArray = [NSMutableArray new];
            for (int i=0; i<array.count; i++)
            {
                QSMerchant *model = [QSMerchant modelObjectWithDictionary:[array objectAtIndex:i]];
                if (model.externalShopId && model.externalShopId>0)
                {
                    int count = [[dict objectForKey:model.externalShopId] intValue];
                    if (count && count)
                    {
                        [dict setObject:[NSString stringWithFormat:@"%d", count+[model.hasModified intValue]] forKey:model.externalShopId];
                    }
                    else
                    {
                        [dict setObject:[NSString stringWithFormat:@"%d", [model.hasModified intValue]] forKey:model.externalShopId];
                    }
                }
                [mutableArray addObject:model];
            }
            [[QSDataSevice sharedQSDataSevice] saveRedDict:dict];
            [[QSDataSevice sharedQSDataSevice] saveTime:[self getNowTime]];
            aBlock(mutableArray);
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock();
        }];
    }
    else
    {
        aVoidBlock();
    }
}

- (NSString *)getNowTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    
    return locationString;
}

@end
