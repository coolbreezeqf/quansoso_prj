//
//  QSMerchantNetManager.m
//  Quansoso
//
//  Created by qf on 14/10/10.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSMerchantNetManager.h"
#import "NetManager.h"
#import "QSSMerchant.h"
#define kURLMerchant @"http://quansoso.uz.taobao.com/d/cr/rest?service=merchant&shopId="
#define kURLIs_Follow @"http://quansoso.uz.taobao.com/view/app/is_follow.php?service=is_follow&tbNick=%@&shopId=%i"
#define kURL
@implementation QSMerchantNetManager
- (void)getMerchantWithShopID:(NSInteger)shopId success:(void (^)(QSSMerchant *merchant,NSArray *cardsArray,NSArray *activities))succ failure:(void (^)())failure{
    MLOG(@"%i",shopId);
	[NetManager requestWith:nil url:[NSString stringWithFormat:@"%@%i",kURLMerchant,shopId] method:@"GET" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        if([successDict[@"isSuccess"] boolValue] == true && [(NSString *)successDict[@"code"] isEqualToString:@"SUCCESS"]){
			NSDictionary *dic = successDict[@"merchant"];
			if(dic){
				QSSMerchant *merchantModel = [QSSMerchant modelObjectWithDictionary:dic];
				NSArray *cardsArray = successDict[@"cards"];
				NSArray *activityArray = successDict[@"activities"];
				succ(merchantModel,cardsArray,activityArray);
			}else{
				failure();
			}
			
        }else{
            failure();
        }

	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
}

- (void)isFollowShopWithShopId:(NSInteger)shopId andNick:(NSString *)nick success:(void (^)(bool isfollow))succ failure:(void (^)()	)failure{
	NSString *url = [NSString stringWithFormat:kURLIs_Follow,nick,shopId];
	NSString *encodeStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
		BOOL isFollow = [successDict[@"is_follow"] boolValue];
		succ(isFollow);
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
}
@end
