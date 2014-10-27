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
@implementation QSAttentionBrandListManage

- (void)getFirstAttentionBrandListSuccBlock:(void(^)(void))aSuccBlock andFailBlock:(void(^)(void))aFailBlock
{
    _nextPage = 2;
    NSString *attentionBrandListUrl = [NSString stringWithFormat:@"%@?service=my_follow&tbNick=%@&current=1&pageSize=14", KBaseUrl, [[TaeSession sharedInstance] getUser].nick];
    [NetManager requestWith:nil url:attentionBrandListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        aSuccBlock();
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

- (void)getNextAttentionBrandListSuccBlock:(void(^)(void))aBlock andFailBlock:(void(^)(void))aFailBlock
{
    NSString *nextAttentionBrandListUrl = [NSString stringWithFormat:@"%@?service=my_follow&tbNick=%@&current=%d&pageSize=15", KBaseUrl, [[TaeSession sharedInstance] getUser].nick, _nextPage];
    [NetManager requestWith:nil url:nextAttentionBrandListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        aBlock();
        _nextPage++;
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];

}
@end
