//
//  DataModels.h
//
//  Created by qf  on 14/9/18
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "TimeLimitCarzy.h"
#import "CardCarzy.h"
#import "Card.h"
#import	"Merchant.h"
#import	"MerchantCard.h"
#import "CarzyList.h"

//错误返回码一览表:
/*
 ILLEGAL_PARTNER	非法key
 ILLEGAL_SIGN 	非法签名
 PARAMETER_MISSING	缺失必填参数
 ILLEGAL_PARAMETER	非法的参数
 INVALID_CARD_ID	卡券ID错误
 CATEGORY_UNKONW	类目不存在
 INVALID_TB_NICK	淘宝昵称错误
 EXPIRED_CARD	卡券已过期
 EXCEED_MAX_COUNT	优惠券库存不足
 EXCEED_LIMITED	个人领用超量
 INSUFFICIENT_PRIVILEGES	权限不足
 TOO_MANY_REQUEST	请求过于频繁
*/