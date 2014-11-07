//
//  QSSearchNothingView.m
//  Quansoso
//
//  Created by qf on 14/11/7.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchNothingView.h"

@implementation QSSearchNothingView

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = RGBCOLOR(242, 239, 233);
		[self setUI];
	}
	return self;
}

//- (void)feedback{
//#warning feedback
//	MLOG(@"feedback!");
//}

- (void)setUI{
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 124)];
	imageView.image = [UIImage imageNamed:@"404img.png"];
	imageView.centerX = kMainScreenWidth/2;
	imageView.centerY = 100;
	[self addSubview:imageView];
	UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
	tipLb.centerY = imageView.bottom + 60;
	[tipLb setNumberOfLines:3];
	tipLb.text = @"亲，您要的品牌还没有入驻哦\n我们会尽快找到品牌，请您下次再来查看哦";
	tipLb.font = kFont14;
	tipLb.textColor = [UIColor lightGrayColor];
	tipLb.textAlignment = NSTextAlignmentCenter;
	[self addSubview:tipLb];
	//feedback按钮
/*
	UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
	bt.center = CGPointMake(kMainScreenWidth/2, tipLb.bottom + 50);
	[bt setTitleColor:RGBCOLOR(105, 192, 17) forState:UIControlStateNormal];
	[bt setTitle:@"我要这个品牌" forState:UIControlStateNormal];
	[bt addTarget:self action:@selector(feedback) forControlEvents:UIControlEventTouchDown];
	[bt setBackgroundImage:[UIImage imageNamed:@"feedbackImg.png"] forState:UIControlStateNormal];
	[self addSubview:bt];
 */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
