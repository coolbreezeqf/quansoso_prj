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
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"
#import "LoadingView.h"
#import "QSMerchantNetManager.h"
#import "QSSMerchant.h"
@interface QSCardDetailsViewController ()<UMSocialUIDelegate,UIWebViewDelegate,UIScrollViewDelegate>{
	NSString *shopId;
	NSString *sellerId;
	NSString *webSite;
	UIButton *rightButton;
	UIView *headView;
	UIWebView *myWebView;
}
//data
@property (nonatomic,strong) QSCards *card;
@property (nonatomic,strong) QSActivity *activity;
@property (nonatomic,strong) NSArray *items;
//UI
@property (nonatomic,strong) UILabel *introduceLabel;
@property (nonatomic,strong) UIButton *merchantName;
@property (nonatomic,strong) UILabel *cardNameLabel;
@property (nonatomic,strong) UIImageView *cardTypeImage;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) QSMerchantCommendView *recommendsView; // 推荐view
@property (nonatomic,strong) QSCardDetailsNetManager *netManager;

@end

@implementation QSCardDetailsViewController
- (void)buttonAction{
	if(![[TaeSession sharedInstance] isLogin]){
		__weak QSCardDetailsViewController *weakself = self;
		[[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
			self.navigationController.navigationBarHidden = NO;
			[weakself accreditLogin];
			[[NSNotificationCenter defaultCenter] postNotificationName:kTaeLoginInSuccessMsg object:nil];
		} failedCallback:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"登陆失败" cover:YES offsetY:kMainScreenHeight/2.0];
		}];		return;
	}else{
		NSString *nick = [[TaeSession sharedInstance] getUser].nick;
		__weak QSCardDetailsViewController *weakself = self;
		[_netManager getCardUseCouponId:_card.sourceId andNick:nick success:^(NSString *describe) {
			MLOG(@"%@",describe);
			[SVProgressHUD showSuccessWithStatus:@"领取成功" cover:YES offsetY:kMainScreenHeight/2];
			[weakself showRecommendView];
			_recommendsView.tableView.tableHeaderView = headView;
		} failure:^(NSString *describe) {
			MLOG(@"%@",describe);
			[SVProgressHUD showErrorWithStatus:describe cover:YES offsetY:kMainScreenHeight/2];
			[weakself showRecommendView];
			_recommendsView.tableView.tableHeaderView = headView;
		}];
	}
}

#pragma mark 授权登陆
- (void)accreditLogin
{
	TaeUser *temUser = [[TaeSession sharedInstance] getUser];
	NSString *loginUrl = [NSString stringWithFormat:@"%@?service=outh&tbNick=%@&picUrl=%@&userId=%@", KBaseUrl, temUser.nick, temUser.iconUrl, temUser.userId];
	NSString *encodeStr = [loginUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[NetManager requestWith:nil url:encodeStr method:@"GET" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict){
		MLOG(@"%@", successDict);
		[SVProgressHUD showSuccessWithStatus:@"登陆成功" cover:YES offsetY:kMainScreenHeight/2.0];
	} failure:^(NSDictionary *failDict, NSError *error) {
		MLOG(@"%@", failDict);
		[SVProgressHUD showSuccessWithStatus:@"登陆失败" cover:YES offsetY:kMainScreenHeight/2.0];
	}];
}
- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction{
	NSString *merchant = _card?_card.merchant:_activity.merchant;
	NSInteger money = [_card.denomination integerValue]/100;
	NSString *shareText;
	if (_card) {
		shareText = [NSString stringWithFormat:@"我在#券搜搜#领到%@的超值优惠券，省了%i元，你来试试吧～http://quansoso.wx.jaeapp.com/d/download",merchant,money];
	}else{
		shareText = [NSString stringWithFormat:@"我在#券搜搜#发现了%@的%@活动，你也来试试吧～http://quansoso.wx.jaeapp.com/d/download",merchant,_activity.name];
	}
	[UMSocialSnsService presentSnsIconSheetView:self
										 appKey:kUMENG_APPKEY
									  shareText:shareText
									 shareImage:[UIImage imageNamed:@"AppIcon"]
								shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, UMShareToSina]
									   delegate:nil];
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

- (instancetype)initWithActivity:(QSActivity *)activity shopId:(NSString *)shopid andSellerId:(NSString *)sellerid{
    if (self = [super init]) {
        _card = nil;
        _activity = activity;
        sellerId = sellerid;
        shopId = shopid;
        webSite = nil;
    }
    return self;
}

- (void)setRightButton:(UIImage *)aImg title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector{
	CGRect buttonFrame = CGRectMake(5, 0, 22, 22);
	rightButton = [[UIButton alloc] initWithFrame:buttonFrame];
	[rightButton addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
	[rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	if(aTitle)
		{
		[rightButton setTitle:aTitle forState:UIControlStateNormal];
		}
	if(aImg)
		{
		[rightButton setBackgroundImage:aImg forState:UIControlStateNormal];
		}
	CGRect viewFrame = CGRectMake(kMainScreenWidth-100/2, 0, 22, 22);
	UIView *view = [[UIView alloc]initWithFrame:viewFrame];
	[view addSubview:rightButton];
	if(self.navigationController && self.navigationItem)
		{
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
		}
}
- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (UIView *)setUI{
	_merchantName = [[UIButton alloc] initWithFrame:CGRectMake(30, 10, kMainScreenWidth - 40, 30)];
	_merchantName.backgroundColor = [UIColor clearColor];
	_merchantName.titleLabel.textAlignment = NSTextAlignmentLeft;
	[_merchantName addTarget:self action:@selector(gotoMoreCard) forControlEvents:UIControlEventTouchDown];
	[_merchantName setTitleColor:RGBCOLOR(10, 76, 121) forState:UIControlStateNormal] ;
	_merchantName.titleLabel.font = kFont17;
	
//	[self.view addSubview:_merchantName];
	
	_cardTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(_merchantName.left, _merchantName.bottom + 10, 60, 60)];
//	[self.view addSubview:_cardTypeImage];
	
	_cardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cardTypeImage.right + 10, _cardTypeImage.top, kMainScreenWidth - _cardTypeImage.right - 20, 20)];
	_cardNameLabel.backgroundColor = [UIColor clearColor];
	_cardNameLabel.font = kFont17;
//	[self.view addSubview:_cardNameLabel];
	
	_introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cardTypeImage.right + 10, _cardNameLabel.bottom , _cardNameLabel.width, _cardTypeImage.height)];
	_introduceLabel.backgroundColor = [UIColor clearColor];
	_introduceLabel.font = kFont12;
	_introduceLabel.textColor = [UIColor grayColor];
//	[self.view addSubview:_introduceLabel];
	headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _introduceLabel.bottom)];
	headView.backgroundColor = RGBCOLOR(238, 238, 238);
	
	_button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 28)];
	_button.center = CGPointMake(kMainScreenWidth/2, _introduceLabel.bottom + 20);
	[_button setBackgroundImage:[UIImage imageNamed:@"QSLingYong"] forState:UIControlStateNormal];
	[_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[_button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
	_button.titleLabel.font = kFont13;

	if (_card) {
		[_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchDown];
		[_button setTitle:@"立刻领用" forState:UIControlStateNormal];
	}else{
		[_button addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchUpInside];
		[_button setTitle:@"进入店铺" forState:UIControlStateNormal];
	}
	
	[headView addSubview:_button];
	headView.height = _button.bottom+5;

	[headView addSubview:_merchantName];
	[headView addSubview:_cardTypeImage];
	[headView addSubview:_introduceLabel];
	[headView addSubview:_cardNameLabel];
	return headView;
}

- (void)showRecommendView{
//	_recommendsView = [[QSMerchantCommendView alloc] initWithFrame:CGRectMake(0, height + 5, kMainScreenWidth, self.view.height - height - 5) andItems:nil];
	_recommendsView = [[QSMerchantCommendView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, self.view.height) andType:_activity?1:2];
	_recommendsView.backgroundColor = [UIColor whiteColor];
	_recommendsView.delegate = self;
	
	[self.view addSubview:_recommendsView];
	[_recommendsView addSubview:self.loadingView];
	__weak QSCardDetailsViewController *weakself = self;
	if (!sellerId) {
		QSMerchantNetManager *netmanager = [[QSMerchantNetManager alloc] init];
		[netmanager getMerchantWithShopID:[shopId integerValue]success:^(QSSMerchant *merchant, NSArray *cardsArray, NSArray *activities) {
			[weakself.netManager getItemsSellerId:merchant.externalId success:^(NSArray *items) {
				[weakself.recommendsView setItemArray:items];
				[_loadingView removeFromSuperview];
			} failure:^{
				[SVProgressHUD showErrorWithStatus:@"未获取到热门商品信息" cover:YES offsetY:kMainScreenHeight/2];
				[_loadingView removeFromSuperview];
			}];
		} failure:^{
			
		}];
	}else
		[_netManager getItemsSellerId:sellerId success:^(NSArray *items) {
			[weakself.recommendsView setItemArray:items];
			[_loadingView removeFromSuperview];
		} failure:^{
			[SVProgressHUD showErrorWithStatus:@"未获取到热门商品信息" cover:YES offsetY:kMainScreenHeight/2];
			[_loadingView removeFromSuperview];
		}];
}

- (LoadingView *)loadingView{
	if(!_loadingView){
		_loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
		_loadingView.center	= CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2);
	}
	return _loadingView;
}


- (void)setUIForActivity{
	[self setUI];
	NSString *activityImgName = [NSString stringWithFormat:@"cardRightImg%i",[_activity.type integerValue]+1];
	_cardTypeImage.image = [UIImage imageNamed:activityImgName];
//	_merchantName.titleLabel.text = _activity.merchant;
	CGFloat width = [self widthOfString:_activity.merchant withFont:kFont17];
	_merchantName.width = width;
	[_merchantName setTitle:_activity.merchant forState:UIControlStateNormal];

	switch ([_activity.type integerValue]+1) {
		case 2://满减
		{
			if (_activity.moneyCondition) {
				_cardNameLabel.text = [NSString stringWithFormat:@"满%i元减%i元",[_activity.moneyCondition integerValue]/100,[_activity.denomination integerValue]/100];
			}else{
				_cardNameLabel.text = [NSString stringWithFormat:@"满%i件减%i元",[_activity.quantityCondition integerValue],[_activity.denomination integerValue]/100];
			}
		
		}
			break;
		case 3://折扣
			_cardNameLabel.text = [NSString stringWithFormat:@"全场%i%%",[_activity.discountRate integerValue]/100];
			break;
		case 4://包邮
		{
			_cardNameLabel.text = @"全场包邮";
			if (!_activity.moneyCondition && !_activity.quantityCondition) {
				_cardNameLabel.text = @"全场包邮";
			}else if (_activity.quantityCondition){
				self.cardNameLabel.text = [NSString stringWithFormat:@"满%i件包邮",[_activity.quantityCondition integerValue]];
			}else{
				self.cardNameLabel.text = [NSString stringWithFormat:@"满%i元包邮",[_activity.moneyCondition integerValue]/100];
			}
		}
			break;
		case 5://满送
		{
		_cardNameLabel.text = [NSString stringWithFormat:@"满%i元送%i元代金券",[_activity.moneyCondition integerValue]/100,[_activity.denomination integerValue]/100];
		}
			break;
		default:
			break;
	}
//	_cardNameLabel.text = _activity.name;
	NSString *endDate = [_activity.endProperty substringWithRange:NSMakeRange(0, [_activity.endProperty rangeOfString:@" "].location)];
	_introduceLabel.text = [NSString stringWithFormat:@"截止%@",endDate];
	
	[self showRecommendView];
	_recommendsView.tableView.tableHeaderView = headView;
}

- (void)setUIForCard{
	if([_card.cardType integerValue]!= 7){
		[self setUI];
//		_merchantName.titleLabel.text = _card.merchant;
		[_merchantName setTitle:_card.merchant forState:UIControlStateNormal];
		CGFloat width = [self widthOfString:_card.merchant withFont:kFont17];
		_merchantName.width = width;
		_cardNameLabel.text = _card.name;

		_cardTypeImage.image = [UIImage imageNamed:@"cardImage"];
		_cardTypeImage.highlightedImage = [UIImage imageNamed:@"cardImage"];

	//	NSLog(@"%@",NSStringFromRange([_card.endProperty rangeOfString:@" "]));
		NSString *endDate = [_card.endProperty substringWithRange:NSMakeRange(0, [_card.endProperty rangeOfString:@" "].location)];
		[_introduceLabel setNumberOfLines:3];
		_introduceLabel.text = [NSString stringWithFormat:@"剩%@ 张 (已领用%@张)\n单笔满%i元可用，每人限领%@张\n有效期至%@", _card.stocks,_card.sold,[_card.moneyCondition integerValue]/100, _card.limited, endDate];
		
		[self.view addSubview:headView];
	}else{
//		NSString *testURL = @"http://shop.m.taobao.com/shop/coupon.htm?activityId=200316068&sellerId=880592812";
		NSString *testURL = @"http://shop.m.taobao.com/shop/coupon.htm?activityId=142486854&sellerId=1639298094";
		NSString *url = @"http://shop.m.taobao.com/shop/coupon.htm?";

		if(/* DISABLES CODE */ (0)){
			/* 使用淘宝的sdk*/
			TaeWebViewUISettings *wb = [[TaeWebViewUISettings alloc] init];
			wb.title = _card.merchant;
			wb.titleColor = RGBCOLOR(75, 171, 14);
			[[TaeSDK sharedInstance] showPage:self isNeedPush:NO pageUrl:testURL webViewUISettings:wb tradeProcessSuccessCallback:^(TaeTradeProcessResult *tradeProcessResult) {
				
			} tradeProcessFailedCallback:^(NSError *error) {
				
			}];
		}else{
			NSRange range1 = [_card.expression rangeOfString:@"activity_id="];
			if (range1.length == 0) {
				[SVProgressHUD showErrorWithStatus:@"信息错误" cover:YES offsetY:kMainScreenHeight/2];
				[self back];
				return ;
			}
			NSRange range2 = NSMakeRange(range1.location+range1.length, 9);
			NSString *activityId = [_card.expression substringWithRange:range2];
			NSString *urlStr = [NSString stringWithFormat:@"%@activityId=%@&sellerId=%@",url,activityId,sellerId];
			myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 181)];
			myWebView.scrollView.scrollEnabled = NO;
			myWebView.delegate = self;
			[myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];

			[self.view addSubview:myWebView];
		}
	}
 
	
}

- (void)webAction{
	[myWebView removeFromSuperview];
	[self showRecommendView];
	_recommendsView.tableView.tableHeaderView = myWebView;
	if(![[TaeSession sharedInstance] isLogin]){
		__weak QSCardDetailsViewController *weakself = self;
		[[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
			self.navigationController.navigationBarHidden = NO;
			[weakself accreditLogin];
			[[NSNotificationCenter defaultCenter] postNotificationName:kTaeLoginInSuccessMsg object:nil];
		} failedCallback:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"登陆失败" cover:YES offsetY:kMainScreenHeight/2.0];
		}];		return;
	}else{
		NSString *nick = [[TaeSession sharedInstance] getUser].nick;
		[_netManager lingCard:_card.cardsIdentifier andNick:nick success:^(NSString *describe) {
			MLOG(@"%@",describe);
		} failure:^(NSString *describe) {
			MLOG(@"%@",describe);
		}];
	}
}
//webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//	NSString *urlString = [[[webView request] URL] absoluteString];
//	NSString *JsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
//	NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:JsToGetHTMLSource];
	[webView.scrollView setContentOffset:CGPointMake(0, 64) animated:YES];
	[webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
	 "script.type = 'text/javascript';"
	 "script.text = \""
	 "var obj = document.getElementsByTagName('button')[1];"
	 "obj.onclick = function myFuction2(){"
	 //"alert(obj.onclick);"
	 "window.location.href='objc://webAction';"
	 "}\";"
	 "document.getElementsByTagName('head')[0].appendChild(script);"];
	//MLOG(@"%@",[webView stringByEvaluatingJavaScriptFromString:JsToGetHTMLSource]);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
	
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	NSString *urlString = [[request URL] absoluteString];
	urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	MLOG(@"urlString=%@",urlString);
	NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
	
	if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
	{
	
		NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
		NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
	
		if (1 == [arrFucnameAndParameter count]){
			// 没有参数
			if([funcStr isEqualToString:@"webAction"]){
					/*调用本地函数1*/
				[self webAction];
			}
		}
		else{
			//有参数的
//				if([funcStr isEqualToString:@"getParam1:withParam2:"])
//				{
//					[self getParam1:[arrFucnameAndParameter objectAtIndex:1] withParam2:[arrFucnameAndParameter objectAtIndex:2]];
//				}
		}
		return NO;
	}else{
		//[self showRecommendView]
	}
	return TRUE;
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
	if (!_activity || !webSite) {
		webSite = [NSString stringWithFormat:@"http://shop%@.taobao.com",shopId];
	}
	TaeWebViewUISettings *wb = [[TaeWebViewUISettings alloc] init];
		wb.title = _card?_card.merchant:_activity.merchant;
		wb.titleColor = RGBCOLOR(75, 171, 14);
		[[TaeSDK sharedInstance] showPage:self isNeedPush:NO pageUrl:_activity?_activity.site:webSite webViewUISettings:wb tradeProcessSuccessCallback:^(TaeTradeProcessResult *tradeProcessResult) {
			
		} tradeProcessFailedCallback:^(NSError *error) {
			
		}];

	
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
	self.view.backgroundColor = RGBCOLOR(238, 238, 238);
	if(_card){
		self.title = @"领取优惠券";
	}else{
		self.title = @"店铺活动";
	}
	_netManager = [[QSCardDetailsNetManager alloc] init];
	[self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
	[self setRightButton:[UIImage imageNamed:@"QSRightViewItem3"] title:nil target:self action:@selector(shareAction)];
	if (_activity) {
		[self setUIForActivity];
	}else{
		[self setUIForCard];
	}
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
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
