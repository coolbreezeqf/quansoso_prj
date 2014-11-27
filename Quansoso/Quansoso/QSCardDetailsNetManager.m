//
//  QSCardDetails.m
//  Quansoso
//
//  Created by qf on 14/11/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCardDetailsNetManager.h"
#import "NetManager.h"
#define kURLMerchant @"http://quansoso.uz.taobao.com/d/cr/rest"
@implementation QSCardDetailsNetManager
- (void)getCardUseCouponId:(NSString *)couponId andNick:(NSString *)nick success:(void (^)(NSString* describe))succ failure:(void (^)(NSString* describe))failure{
//	NSDictionary *dic = @{@"nick":nick,@"couponId":couponId,@"service":@"exchange"};
//	NSString *encodedStr = [kURLMerchant stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *url = [NSString stringWithFormat:@"%@?service=exchange&nick=%@&couponId=%@",kURLMerchant,nick,couponId];
	NSString *encodeStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFPropertyListParameterEncoding succ:^(NSDictionary *successDict) {
		bool result = [successDict[@"isSuccess"] boolValue];
		NSString *resultStr = successDict[@"describe"];
		if(result){
			succ(resultStr);
		}else{
			failure(resultStr);
		}
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure(@"error");
	}];
}

@end
