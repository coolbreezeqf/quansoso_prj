//
//  QSAttentionBrandTableViewCell.h
//  Quansoso
//
//  Created by Johnny's on 14-10-8.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSMerchant.h"

@interface QSAttentionBrandTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *brandImgView;
@property(nonatomic, strong) UILabel *brandNameLabel;
@property(nonatomic, strong) UIButton *cancelBtn;
@property(nonatomic, assign) BOOL isfollow;


- (instancetype)init;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCellWithModel:(QSMerchant *)aModel;
@end
