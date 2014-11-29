//
//  QSAttentionBtn.h
//  Quansoso
//
//  Created by Johnny's on 14/11/29.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSMerchant.h"

@interface QSAttentionBtn : UIButton
{
    UIImageView *countImgView;
    UILabel *countLabel;
}

- (instancetype)initWithFrame:(CGRect)frame andModel:(QSMerchant *)aModel;
- (void)removeRedView;
@end
