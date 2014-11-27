//
//  QSMerchantCommendView.m
//  Quansoso
//
//  Created by qf on 14/11/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSMerchantCommendView.h"
#import "SVProgressHUD.h"
@interface QSMerchantCommendView ()<UIActionSheetDelegate>

@end

@implementation QSMerchantCommendView

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self setUI];
	}
	return self;
}

- (instancetype)init{
	if(self = [super init]){
		[self setUI];
	}
	return self;
}


- (void)setUI{
	UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 60, 20)];
	titleLb.text = @"热门商品";
	titleLb.textColor = [UIColor blackColor];
	titleLb.textAlignment = NSTextAlignmentLeft;
	titleLb.font = kFont15;
	[self addSubview:titleLb];
	
//gotoShop
	UILabel *gotoShopLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
	gotoShopLb.width = [self widthOfString:@"进入店铺" withFont:kFont13];
	gotoShopLb.right = kMainScreenWidth - 10;
	gotoShopLb.text = @"进入店铺";
	gotoShopLb.textColor = [UIColor lightGrayColor];
	gotoShopLb.font = kFont13;
	[self addSubview:gotoShopLb];
	
	UIImageView *gotoShopImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 20, 20)];
	gotoShopImg.image = [UIImage imageNamed:@"QSgoMerc"];
	gotoShopImg.right = gotoShopLb.left-5;
	[self addSubview:gotoShopImg];
	
	UIButton *gotoShopBt = [[UIButton alloc] initWithFrame:CGRectMake(gotoShopImg.left, 20, gotoShopLb.right-gotoShopImg.left, 30)];
	[gotoShopBt addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchDown];
	[self addSubview:gotoShopBt];
//gotoshop end
	
//more
	UILabel *more = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
	more.width = [self widthOfString:@"更多优惠" withFont:kFont13];
	more.right = gotoShopBt.left-10;
	more.text = @"更多优惠";
	more.textColor = [UIColor lightGrayColor];
	more.font = kFont13;
	[self addSubview:more];
	
	UIImageView *moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 20, 20)];
	moreImg.image = [UIImage imageNamed:@"QSMore"];
	moreImg.right = more.left-5;
	[self addSubview:moreImg];

	UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(moreImg.left, 20, more.right - moreImg.left, 30)];
	[moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
	[self addSubview:moreButton];
//more end
}

- (void)gotoShop
{
	if (self.webSiteUrl && self.webSiteUrl) {
		NSString *str = [self.webSiteUrl substringFromIndex:[self.webSiteUrl rangeOfString:@"http"].location+4];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao%@",str]];
		if ([[UIApplication sharedApplication] canOpenURL:url]) {
			UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确认使用淘宝客户端打开店铺" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开淘宝客户端" otherButtonTitles:nil];
			[actionSheet showInView:self];
		} else {
			url = [NSURL URLWithString:[NSString stringWithFormat:@"http%@",str]];
			[[UIApplication sharedApplication] openURL:url];
		}
		
	}else{
		[SVProgressHUD showErrorWithStatus:@"缺少该商家店铺地址" cover:YES offsetY:kMainScreenHeight/2];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 0){
		NSString *str = [self.webSiteUrl substringFromIndex:[self.webSiteUrl rangeOfString:@"http"].location+4];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao%@",str]];
		[[UIApplication sharedApplication] openURL:url];
	}
}

- (void)more{
	[_delegate gotoMoreCard];
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}


						
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
