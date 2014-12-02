//
//  QSItemsCellTableViewCell.m
//  Quansoso
//
//  Created by qf on 14/12/1.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSItemsCellTableViewCell.h"

@interface QSItemsCellTableViewCell ()
@property (nonatomic,strong) UIView *item1;
@property (nonatomic,strong) UIView *item2;
@end

@implementation QSItemsCellTableViewCell

+ (CGFloat)heightOfCell{
	return [QSItemsCellTableViewCell widthOfCell]+80;
}

+ (CGFloat)widthOfCell{
	return (kMainScreenWidth-30)/2;
}

- (void)showItemWith:(NSInteger)num{
	if (num == 1) {
		if ([_item2 superview]) {
			[_item2 removeFromSuperview];
		}
	}else{
		if (![_item2 superview]) {
			[self.contentView addSubview:_item2];
		}
	}
}

- (void)setUI{
	int width = [QSItemsCellTableViewCell widthOfCell];
	int height = [QSItemsCellTableViewCell heightOfCell]-10;
	_item1 = [[UIView alloc] initWithFrame:CGRectMake(10, 0, width, height)];
	_item1.layer.cornerRadius = 5;
	_item1.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_item1.layer.borderWidth = 1;
	[self.contentView addSubview:_item1];
	
	_imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
	_imageView1.layer.cornerRadius = 5;
	_imageView1.clipsToBounds = YES;
	[_item1 addSubview:_imageView1];
	
	_titleLb1 = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageView1.bottom+10, width-20, 30)];
	_titleLb1.font = kFont11;
	_titleLb1.textColor = [UIColor lightGrayColor];
	_titleLb1.backgroundColor = [UIColor clearColor];
	[_titleLb1 setNumberOfLines:2];
	[_item1 addSubview:_titleLb1];
	
	_priceLb1 = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLb1.bottom+10, width-20, 13)];
	_priceLb1.font = kFont11;
	_priceLb1.textColor = RGBCOLOR(75, 171, 14);
	_priceLb1.backgroundColor = [UIColor clearColor];
	[_item1 addSubview:_priceLb1];
//itme2

	_item2 = [[UIView alloc] initWithFrame:CGRectMake(_item1.right+10, 0, width, height)];
	_item2.layer.cornerRadius = 5;
	_item2.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_item2.layer.borderWidth = 1;
	[self.contentView addSubview:_item2];
	
	_imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
	_imageView2.layer.cornerRadius = 5;
	_imageView2.clipsToBounds = YES;
	[_item2 addSubview:_imageView2];
	
	_titleLb2 = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageView2.bottom+10, width-20, 30)];
	_titleLb2.font = kFont11;
	_titleLb2.textColor = [UIColor lightGrayColor];
	_titleLb2.backgroundColor = [UIColor clearColor];
	[_titleLb2 setNumberOfLines:2];
	[_item2 addSubview:_titleLb2];
	
	_priceLb2 = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLb2.bottom+10, width-20, 13)];
	_priceLb2.font = kFont11;
	_priceLb2.textColor = RGBCOLOR(75, 171, 14);
	_priceLb2.backgroundColor = [UIColor clearColor];
	[_item2 addSubview:_priceLb2];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setUI];
	}
	return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch= [touches anyObject];
	CGPoint location = [touch locationInView:self];
	if (CGRectContainsPoint(_item1.frame, location) ){
		[_delegate selectCellAtIndex:0 andRow:_indexOfRow];
	}else if(CGRectContainsPoint(_item2.frame, location)){
		[_delegate selectCellAtIndex:1 andRow:_indexOfRow];
	}
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
