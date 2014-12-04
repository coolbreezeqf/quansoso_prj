//
//  QSDayRecommend.m
//  Quansoso
//
//  Created by able on 14-10-11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSDayRecommendManage.h"
#import "NetManager.h"
#import "QSDayRecommends.h"

@implementation QSDayRecommendManage : NSObject

- (void)getDayRecommendSuccBlock:(void(^)(NSArray *dayRecomendModelArray))aBlock andFailBlock:(void(^)(void))aFailBlock
{
    NSString *dayRecommendUrl = [NSString stringWithFormat:@"%@?service=every_recommend", KBaseUrl];
    [NetManager requestWith:nil url:dayRecommendUrl method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
        NSArray *dayRecommendArray = [successDict objectForKey:@"recommends"];
        NSMutableArray *dayRecommendModelArray = [NSMutableArray new];
        for (int i=0; i<dayRecommendArray.count; i++)
        {
            NSDictionary *recommendDict = [dayRecommendArray objectAtIndex:i];
            QSDayRecommends *model = [QSDayRecommends modelObjectWithDictionary:recommendDict];
            [dayRecommendModelArray addObject:model];
        }
        aBlock(dayRecommendModelArray);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}

@end
