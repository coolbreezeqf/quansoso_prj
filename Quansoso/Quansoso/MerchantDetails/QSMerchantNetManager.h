//
//  QSMerchantNetManager.h
//  Quansoso
//
//  Created by qf on 14/10/10.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QSSMerchant;

@interface QSMerchantNetManager : NSObject
- (void)getMerchantWithShopID:(NSInteger)shopId success:(void (^)(QSSMerchant *merchant,NSArray *cardsArray,NSArray *activities))succ failure:(void (^)())failure;
- (void)isFollowShopWithShopId:(NSInteger)shopId andNick:(NSString *)nick success:(void (^)(bool isfollow))succ failure:(void (^)()	)failure;
@end
