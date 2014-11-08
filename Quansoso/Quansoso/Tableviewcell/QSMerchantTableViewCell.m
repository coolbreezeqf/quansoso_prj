//
//  QSMerchantTableViewCell.m
//  Quansoso
//
//  Created by qf on 14/10/3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSMerchantTableViewCell.h"

@implementation QSMerchantTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame{
//	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MerchantCell" owner:self options:nil];
//	self = nib[0];
    if (self = [super initWithFrame:frame]) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12.5, 90, 45)];
        [self addSubview:_iconImageView];
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right+10, _iconImageView.top, kMainScreenWidth - _iconImageView.right - 20, 45)];
        _titleLb.font = kFont15;
        _titleLb.textColor = [UIColor lightGrayColor];
        [self addSubview:_titleLb];
    }
	return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MerchantCell" owner:self options:nil];
//	self = nib[0];
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12.5, 90, 45)];
        [self addSubview:_iconImageView];
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right+10, _iconImageView.top, kMainScreenWidth - _iconImageView.right - 20, 45)];
        _titleLb.font = kFont15;
        _titleLb.textColor = [UIColor lightGrayColor];
        [self addSubview:_titleLb];
    }
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
