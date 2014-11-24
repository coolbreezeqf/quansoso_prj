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
- (void)getMerchantWithShopID:(NSInteger)topId success:(void (^)(QSSMerchant *merchant,NSArray *cardsArray))succ failure:(void (^)())failure;

@end
