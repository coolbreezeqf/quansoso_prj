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
#define kURLMerchant @"http://quansoso.uz.taobao.com/d/cr/rest?service=merchant&topId="
#define kURL
@implementation QSMerchantNetManager
- (void)getMerchantWithTopID:(double)topId success:(void (^)(QSSMerchant *merchant,NSArray *cardsArray))succ failure:(void (^)())failure{
	[NetManager requestWith:nil url:[NSString stringWithFormat:@"%@%.0lf",kURLMerchant,topId] method:@"GET" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        if([successDict[@"isSuccess"] boolValue] == true && [(NSString *)successDict[@"code"] isEqualToString:@"SUCCESS"]){
            QSSMerchant *merchantModel = [QSSMerchant modelObjectWithDictionary:successDict[@"merchant"]];
            NSArray *cardsArray = successDict[@"cards"];
            succ(merchantModel,cardsArray);
        }else{
            failure();
        }

	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
}
@end
