//
//  QSSSearchBar.m
//  Quansoso
//
//  Created by qf on 14/11/5.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSSearchBar.h"

@implementation QSSSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		//更改输入框左边的图片
		[self setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
		//更改搜索textfield的背景图片
		[self setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchBarBG"] forState:UIControlStateNormal];
		//输入文本的offset
		self.searchTextPositionAdjustment = UIOffsetMake(10, 0);
		self.Placeholder = @"搜索品牌/优惠";

		//设置光标颜色
		[self setTintColor:[UIColor lightGrayColor]];
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
