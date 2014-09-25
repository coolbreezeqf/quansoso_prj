//
//  QSSearchNetManager.m
//  Quansoso
//
//  Created by qf on 14/9/23.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchNetManager.h"
#import "NetManager.h"
#define kURLSearch @"http://repository.api.ekupeng.com/search/merchant"
@implementation QSSearchNetManager

+ (NSDictionary *)searchContent:(NSDictionary *)content success:(void (^)(NSDictionary *successDict))succ failure:(void (^)())failure{
	__block NSDictionary *result = nil;
	[NetManager requestWith:content url:kURLSearch method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
//		result = [[NSDictionary alloc] initWithDictionary:successDict];
		succ(successDict);
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
	return result;
}
@end
