//
//  QSCardDetailsViewController.m
//  Quansoso
//
//  Created by qf on 14/10/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCardDetailsViewController.h"
#import "QSCards.h"
#import "QSActivity.h"
#import <TAESDK/TAESDK.h>
#import "NetManager.h"
#import "CAlertLabel.h"
#import "QSCardDetailsNetManager.h"
#import "SVProgressHUD.h"
#import "QSMerchantDetailsViewController.h"
@interface QSCardDetailsViewController (){
	NSString *shopId;
	NSString *sellerId;
	NSString *webSite;
}
//data
@property (nonatomic,strong) QSCards *card;
@property (nonatomic,strong) QSActivity *activity;
@property (nonatomic,strong) NSArray *items;
//UI
@property (nonatomic,strong) UILabel *introduceLabel;
@property (nonatomic,strong) UILabel *merchantName;
@property (nonatomic,strong) UILabel *cardNameLabel;
@property (nonatomic,strong) UIImageView *cardTypeImage;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) QSMerchantCommendView *recommendsView; // 推荐view
@property (nonatomic,strong) QSCardDetailsNetManager *netManager;

@end

@implementation QSCardDetailsViewController
- (void)buttonAction{
	if(![[TaeSession sharedInstance] isLogin]){
		__weak QSCardDetailsViewController *weakself = self;
		[[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
			[weakself accreditLogin];
			
		} failedCallback:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"授权失败" cover:YES offsetY:kMainScreenHeight/2];
		}];
		return;
	}else{
		NSString *nick = [[TaeSession sharedInstance] getUser].nick;
		__weak QSCardDetailsViewController *weakself = self;
		[_netManager getCardUseCouponId:_card.sourceId andNick:nick success:^(NSString *describe) {
			MLOG(@"%@",describe);
			[SVProgressHUD showSuccessWithStatus:@"领取成功" cover:YES offsetY:kMainScreenHeight/2];
			[_netManager getItemsSellerId:sellerId success:^(NSArray *items) {
				_items = items;
				[weakself showRecommendView];
			} failure:^{
				[SVProgressHUD showErrorWithStatus:@"未获取到热门商品信息" cover:YES offsetY:kMainScreenHeight/2];
			}];
		} failure:^(NSString *describe) {
			MLOG(@"%@",describe);
			[SVProgressHUD showErrorWithStatus:describe cover:YES offsetY:kMainScreenHeight/2];
			[_netManager getItemsSellerId:sellerId success:^(NSArray *items) {
				_items = items;
				[weakself showRecommendView];
			} failure:^{
				[SVProgressHUD showErrorWithStatus:@"未获取到热门商品信息" cover:YES offsetY:kMainScreenHeight/2];
			}];
		}];
	}
}

#pragma mark 授权登陆
- (void)accreditLogin
{
	TaeUser *temUser = [[TaeSession sharedInstance] getUser];
	NSString *loginUrl = [NSString stringWithFormat:@"%@?service=outh&tbNick=%@&picUrl=%@&userId=%@", KBaseUrl, temUser.nick, temUser.iconUrl, temUser.userId];
	[NetManager requestWith:nil url:loginUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict){
		MLOG(@"%@", successDict);
	} failure:^(NSDictionary *failDict, NSError *error) {
		MLOG(@"%@", failDict);
	}];
}

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)initWithCard:(QSCards *)card webSite:(NSString*)site andSellerId:(NSString *)sellerid{
	if (self = [super init]) {
		_card = card;
		_activity = nil;
		sellerId = sellerid;
		shopId = nil;
		webSite = site;
	}
	return self;
}

- (instancetype)initWithActivity:(QSActivity *)activity andSellerId:(NSString *)sellerid{
	if (self = [super init]) {
		_card = nil;
		_activity = activity;
		sellerId = sellerid;
		shopId = nil;
		webSite = nil;
	}
	return self;
}

- (instancetype)initWithCard:(QSCards *)card shopId:(NSString *)shopid andSellerId:(NSString *)sellerid{
	if (self = [super init]) {
		_card = card;
		_activity = nil;
		sellerId = sellerid;
		shopId = shopid;
		webSite = nil;
	}
	return self;
}

- (void)setUI{
	_merchantName = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, kMainScreenWidth - 40, 30)];
	_merchantName.backgroundColor = [UIColor clearColor];
	_merchantName.textColor = RGBCOLOR(10, 76, 121);
	_merchantName.font = kFont17;
	[self.view addSubview:_merchantName];
	
	_cardTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(_merchantName.left, _merchantName.bottom + 10, 60, 60)];
	[self.view addSubview:_cardTypeImage];
	
	_cardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cardTypeImage.right + 10, _cardTypeImage.top, kMainScreenWidth - _cardTypeImage.right - 20, 20)];
	_cardNameLabel.backgroundColor = [UIColor clearColor];
	_cardNameLabel.font = kFont17;
	[self.view addSubview:_cardNameLabel];
	
	_introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cardTypeImage.right + 10, _cardNameLabel.bottom , _cardNameLabel.width, _cardTypeImage.height)];
	_introduceLabel.backgroundColor = [UIColor clearColor];
	_introduceLabel.font = kFont12;
	_introduceLabel.textColor = [UIColor grayColor];
	[self.view addSubview:_introduceLabel];
}

- (void)showRecommendView{
	int height = _button?_button.bottom:_introduceLabel.bottom;
	_recommendsView = [[QSMerchantCommendView alloc] initWithFrame:CGRectMake(0, height + 5, kMainScreenWidth, self.view.height - height - 5) andItems:_items];
	_recommendsView.backgroundColor = [UIColor whiteColor];
	_recommendsView.delegate = self;
	
	[self.view addSubview:_recommendsView];
}

- (void)setUIForActivity{
	[self setUI];
	NSString *activityImgName = [NSString stringWithFormat:@"cardRightImg%i",[_activity.type integerValue]+1];
	_cardTypeImage.image = [UIImage imageNamed:activityImgName];
	_merchantName.text = _activity.merchant;
	_cardNameLabel.text = _activity.name;
	_introduceLabel.text = [NSString stringWithFormat:@"截止%@",_activity.endProperty];
	
	__weak QSCardDetailsViewController *weakself = self;
	[_netManager getItemsSellerId:sellerId success:^(NSArray *items) {
		_items = items;
		[weakself showRecommendView];
	} failure:^{
		[SVProgressHUD showErrorWithStatus:@"未获取到热门商品信息" cover:YES offsetY:kMainScreenHeight/2];
	}];
}

- (void)setUIForCard{

	[self setUI];
	_merchantName.text = _card.merchant;
	_cardNameLabel.text = _card.name;

	_cardTypeImage.image = [UIImage imageNamed:@"cardImage1"];
	_cardTypeImage.highlightedImage = [UIImage imageNamed:@"cardImage1"];

	[_introduceLabel setNumberOfLines:3];
	_introduceLabel.text = [NSString stringWithFormat:@"剩%@张 (已领用%@张)\n单笔满%i元可用，每人限领%@张\n截止%@", _card.stocks,_card.sold,[_card.moneyCondition integerValue]/100, _card.limited, _card.endProperty];
	
	_button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 28)];
	_button.center = CGPointMake(kMainScreenWidth/2, _introduceLabel.bottom + 20);
	[_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchDown];
//	_button.backgroundColor = RGBCOLOR(240, 240, 240);
//	_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
//	_button.layer.borderWidth = 1;
//	//	_button.layer.cornerRadius = 5;
//	_button.titleLabel.font = kFont13;
//	[_button setTitle:@"立即领用" forState:UIControlStateNormal];
//	[_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[_button setBackgroundImage:[UIImage imageNamed:@"QSLingYong"] forState:UIControlStateNormal];
	[self.view addSubview:_button];
	
}
//MerchantCommendView delegate
- (void)gotoMoreCard{
	if (shopId) {
		QSMerchantDetailsViewController *md = [[QSMerchantDetailsViewController alloc] initWithShopId:[shopId integerValue]];
		[self.navigationController pushViewController:md animated:YES];
	}else{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)gotoShop{
	if (_activity || webSite) {
		TaeWebViewUISettings *wb = [[TaeWebViewUISettings alloc] init];
		wb.title = _card?_card.merchant:_activity.merchant;
		wb.titleColor = RGBCOLOR(75, 171, 14);
		[[TaeSDK sharedInstance] showPage:self isNeedPush:NO pageUrl:_activity?_activity.site:webSite webViewUISettings:wb tradeProcessSuccessCallback:^(TaeTradeProcessResult *tradeProcessResult) {
			
		} tradeProcessFailedCallback:^(NSError *error) {
			
		}];
	}else{
		[SVProgressHUD showErrorWithStatus:@"缺少店铺地址" cover:YES offsetY:kMainScreenHeight/2];
	}
	
}

- (void)gotoItem:(NSString *)item{
	if (item && item.length) {
		TaeWebViewUISettings *wb = [[TaeWebViewUISettings alloc] init];
		wb.title = _card?_card.merchant:_activity.merchant;
		wb.titleColor = RGBCOLOR(75, 171, 14);
		[[TaeSDK sharedInstance] showItemDetail:self isNeedPush:NO webViewUISettings:wb itemId:item itemType:1 params:nil tradeProcessSuccessCallback:^(TaeTradeProcessResult *tradeProcessResult) {
			
		} tradeProcessFailedCallback:^(NSError *error) {
			
		}];
	}else{
		[SVProgressHUD showErrorWithStatus:@"商品信息错误" cover:YES offsetY:kMainScreenHeight/2];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.navigationController.navigationBarHidden = NO;
	self.view.backgroundColor = RGBCOLOR(238, 238, 238);
//	self.title = @"领取优惠券";
	_netManager = [[QSCardDetailsNetManager alloc] init];
    [self settitleLabel:@"领取优惠券"];
	[self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
	if (_activity) {
		[self setUIForActivity];
	}else{
		[self setUIForCard];
	}
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
