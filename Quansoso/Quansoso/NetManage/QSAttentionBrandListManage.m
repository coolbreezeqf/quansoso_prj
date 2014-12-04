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

int current;
int pageSize;
int totalPage;
BOOL isIndex;
@implementation QSAttentionBrandListManage

- (void)getFirstAttentionBrandListSuccBlock:(void(^)(NSMutableArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock isIndex:(BOOL)aBool
{
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
    current = 1;
    if (aBool==YES)
    {
        pageSize = 9;
    }
    else
    {
        pageSize = 20;
    }
    NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=my_follow&tbNick=%@&current=%d&pageSize=%d&lastModified=%@", KBaseUrl, [TaeSession sharedInstance].getUser.nick, current,pageSize, time];
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
            int count = [[dict objectForKey:model.externalShopId] intValue];
            if (count && count)
            {
                [dict setObject:[NSString stringWithFormat:@"%d", count+[model.hasModified intValue]] forKey:model.externalShopId];
            }
            else
            {
                [dict setObject:[NSString stringWithFormat:@"%d", [model.hasModified intValue]] forKey:model.externalShopId];
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

- (void)getNextAttentionBrandListSuccBlock:(void(^)(NSArray *))aBlock andFailBlock:(void(^)(void))aFailBlock voidBlock:(void(^)(void))aVoidBlock
{
    if (current<totalPage) {
        current++;
//        NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=merchants&tbNick=j**t&current=%d&pageSize=%d", KBaseUrl, current,pageSize];
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
            totalPage = [[pageDict objectForKey:@"totalPage"] intValue];
            NSArray *array = [pageDict objectForKey:@"resultList"];
            NSMutableArray *mutableArray = [NSMutableArray new];
            for (int i=0; i<array.count; i++)
            {
                QSMerchant *model = [QSMerchant modelObjectWithDictionary:[array objectAtIndex:i]];
                int count = [[dict objectForKey:model.externalShopId] intValue];
                if (count && count)
                {
                    [dict setObject:[NSString stringWithFormat:@"%d", count+[model.hasModified intValue]] forKey:model.externalShopId];
                }
                else
                {
                    [dict setObject:[NSString stringWithFormat:@"%d", [model.hasModified intValue]] forKey:model.externalShopId];
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
