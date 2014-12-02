//
//  QSAttentionBrandTableViewCell.m
//  Quansoso
//
//  Created by Johnny's on 14-10-8.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSAttentionBrandTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation QSAttentionBrandTableViewCell

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGRect temframe = self.frame;
    temframe.size.width = kMainScreenWidth;
    self.frame = temframe;
    CGFloat cellHeight = 70;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, cellHeight)];
    [self addSubview:backView];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
    topLineView.backgroundColor = RGBCOLOR(239, 235, 227);
    [self addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBottom(backView)-0.5, kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = RGBCOLOR(239, 235, 227);
    [self addSubview:bottomLineView];
    
    self.brandImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.brandImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.brandImgView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.brandImgView.layer.borderWidth = 0.5;
    [backView addSubview:self.brandImgView];
    
    self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-40, cellHeight/2-11, 22, 22)];
//    [self.cancelBtn setImage:[UIImage imageNamed:@"QSBrandLiked"] forState:UIControlStateNormal];
    [backView addSubview:self.cancelBtn];
    
    self.brandNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.brandImgView.right+10, cellHeight/2-10, 180, 20)];
//    self.brandNameLabel.text = @"江南布衣官方旗舰店";
    self.brandNameLabel.font = kFont16;
    self.brandNameLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:self.brandNameLabel];
    return self;
}

- (void)setCellWithModel:(QSMerchant *)aModel
{
    [self.brandImgView sd_setImageWithURL:[NSURL URLWithString:aModel.picUrl]];
    self.brandNameLabel.text = aModel.name;
    [self.cancelBtn setImage:[UIImage imageNamed:@"QSBrandLiked"] forState:UIControlStateNormal];
}

- (void)showLike
{
    [self.cancelBtn setImage:[UIImage imageNamed:@"QSBrandLiked"] forState:UIControlStateNormal];
}

- (void)showUnlike
{
    [self.cancelBtn setImage:[UIImage imageNamed:@"QSBrandUnlike"] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
