//
//  QSCardDetails.m
//  Quansoso
//
//  Created by qf on 14/11/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCardDetailsNetManager.h"
#import "NetManager.h"
#import <CommonCrypto/CommonDigest.h>
#define kURLMerchant @"http://quansoso.uz.taobao.com/d/cr/rest"
#define kURLItems @"http://repository.ekupeng.com/cr/rest?service=ekupeng_item_relate&fields=num_iid,title,nick,pic_url,price,click_url"
#define kURLLing @"http://quansoso.uz.taobao.com/view/app/add_exchange.php?service=add_exchange&"
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

- (void)lingCard:(NSString *)cardId andNick:(NSString *)nick success:(void (^)(NSString* describe))succ failure:(void (^)(NSString* describe))failure{
	NSString *url = [NSString stringWithFormat:@"%@tbNick=%@&cardId=%@",kURLLing,nick,cardId];
	NSString *encodeStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFPropertyListParameterEncoding succ:^(NSDictionary *successDict) {
		bool result = [successDict[@"isSuccess"] boolValue];
		NSString *resultStr = successDict[@"describe"];
		if(result){
			succ(resultStr);
			MLOG(@"调用成功");
		}else{
			failure(resultStr);
			MLOG(@"调用失败");
		}
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure(@"error");
		MLOG(@"调用失败");
	}];
}



- (void)getItemsSellerId:(NSString *)sellerId success:(void (^)(NSArray *items))succ failure:(void (^)())failure{
	NSString *url = [NSString stringWithFormat:@"%@&sellerId=%@",kURLItems,sellerId];
	[NetManager requestWith:nil url:url method:@"GET" operationKey:nil parameEncoding:AFPropertyListParameterEncoding succ:^(NSDictionary *successDict) {
		MLOG(@"");
		succ((NSArray*)successDict);
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
}

@end
