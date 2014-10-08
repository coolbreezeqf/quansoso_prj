//
//  BrandListManage.m
//  Quansoso
//
//  Created by Johnny's on 14-10-6.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandListManage.h"
#import "NetManager.h"

@implementation QSBrandListManage

- (void)getBrandListPageSize:(int)aPageSize andSuccBlock:(void(^)(void))aBlock
{
    NSString *BrandListUrl = [NSString stringWithFormat:@"%@?service=follow_list&current=1&pageSize=%d", KBaseUrl, aPageSize];
    [NetManager requestWith:nil url:BrandListUrl method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        aBlock();
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}


@end
