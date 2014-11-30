//
//  QSCardCell.h
//  Quansoso
//
//  Created by yato_kami on 14/11/10.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellHeight 60
typedef NS_ENUM(NSInteger, cardType) {
    cardType_complex = 0,//复合卡券
    cardType_privilege,//优惠券
	cardType_floor,//阶梯券
    cardType_count,//折扣券
    cardType_mail, //包邮券
    cardType_treasure,//宝贝卷
    cardType_tao,//淘券
    cardType_prefextTao//精选淘券
};

@interface QSCardCell : UITableViewCell

//定制的init方法
- (instancetype)initWithReuseIdentifier:(NSString *)identifier;

/**
 *  设置cell的UI
 *
 *  @param card_type       对应card模型-card_type
 *  @param denom           对应card模型-denomination
 *  @param money_condition 对应card模型-money_condition
 *  @param endTime         对应card模型-endProperty
 *  @param rate            对应card模型-discount_rate
 *  @param odState         优惠券是否过期状态量 0：未过期 1：即将过期 2：已过期
 */
- (void)setCellUIwithCardType:(NSString *)card_type denomination:(NSString *)denom Money_condition:(NSString *)money_condition end:(NSString *)endTime discountRate:(NSString *)rate outdateState:(int)odState;

@end
