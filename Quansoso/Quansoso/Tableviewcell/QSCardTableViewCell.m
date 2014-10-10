//
//  QSCardTableViewCell.m
//  Quansoso
//
//  Created by qf on 14/10/8.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCardTableViewCell.h"

@implementation QSCardTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame{
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CardCell" owner:self options:nil];
	self = nib[0];
	return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CardCell" owner:self options:nil];
	self = nib[0];
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
