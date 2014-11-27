//
//  QSLikeBrandManage.m
//  Quansoso
//
//  Created by Johnny's on 14/11/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSLikeBrandManage.h"
#import "NetManager.h"
#import <TAESDK/TAESDK.h>

@implementation QSLikeBrandManage

- (void)likeBrand:(int)aBrandId andSuccBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(void))aFailBlock
{
    NSString *likeBrandUrl = [NSString stringWithFormat:@"%@?service=follow&tbNick=%@&merchantShopIds=%d", KBaseUrl, [[TaeSession sharedInstance] getUser].nick, aBrandId];
    NSString *encodeStr = [likeBrandUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetManager requestWith:nil url:encodeStr method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);

    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];

}

- (void)likeMultiBrand:(NSArray *)aBrandIdArray andSuccBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(void))aFailBlock
{
    NSMutableString *mutableString = [NSMutableString new];
    for (int i=0; i<aBrandIdArray.count; i++) {
        if (i==0)
        {
            [mutableString setString:[NSString stringWithFormat:@"%@", [aBrandIdArray objectAtIndex:0]]];
        }
        else
        {
            [mutableString appendFormat:@",%@", [aBrandIdArray objectAtIndex:i]];
        }
    }
    NSString *likeBrandUrl = [NSString stringWithFormat:@"%@?service=follow&tbNick=%@&merchantShopIds=%@", KBaseUrl, [[TaeSession sharedInstance] getUser].nick, mutableString];
    NSString *encodeStr = [likeBrandUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetManager requestWith:nil url:encodeStr method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];

}

- (void)unlikeBrand:(int)aBrandId andSuccBlock:(void (^)(void))aSuccBlock failBlock:(void (^)(void))aFailBlock
{
    NSString *deleteUrl = [NSString stringWithFormat:@"%@?service=unfollow&tbNick=%@&merchantShopId=%d", KBaseUrl, [TaeSession sharedInstance].getUser.nick, aBrandId];
    NSString *encodeStr = [deleteUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetManager requestWith:nil url:encodeStr method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

@end
