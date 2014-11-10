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
    cardType_count,//折扣券
    cardType_mail, //包邮券
    cardType_floor,//阶梯券
    cardType_treasure,//宝贝卷
    cardType_tao,//淘券
    cardType_prefextTao//精选淘券
};

@interface QSCardCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)identifier;

- (void)setCellUIwithCardType:(cardType)type Money_condition:(NSString *)money_condition end:(NSString *)endTime discountRate:(NSString *)rate;

@end
