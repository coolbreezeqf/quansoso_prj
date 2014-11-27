//
//  QSCardDetailsViewController.m
//  Quansoso
//
//  Created by qf on 14/10/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCardDetailsViewController.h"
#import "QSCards.h"
#import <TAESDK/TAESDK.h>
#import "NetManager.h"
#import "CAlertLabel.h"
#import "QSCardDetailsNetManager.h"
#import "SVProgressHUD.h"
@interface QSCardDetailsViewController (){
	BOOL isFromRoot;
}
//data
@property (nonatomic,strong) QSCards *card;

//UI
@property (nonatomic,strong) UILabel *introduceLabel;
@property (nonatomic,strong) UILabel *merchantName;
@property (nonatomic,strong) UILabel *cardNameLabel;
@property (nonatomic,strong) UIImageView *cardTypeImage;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) QSMerchantCommendView *recommendsView; // 推荐view

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
		QSCardDetailsNetManager *netManager = [[QSCardDetailsNetManager alloc] init];
		[netManager getCardUseCouponId:_card.sourceId andNick:nick success:^(NSString *describe) {
			MLOG(@"%@",describe);
			[SVProgressHUD showSuccessWithStatus:@"领取成功" cover:YES offsetY:kMainScreenHeight/2];
		} failure:^(NSString *describe) {
			MLOG(@"%@",describe);
			[SVProgressHUD showErrorWithStatus:describe cover:YES offsetY:kMainScreenHeight/2];

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

- (instancetype)initWithCard:(QSCards *)card{
	if (self = [super init]) {
		_card = card;
		isFromRoot = YES;
	}
	return self;
}

- (instancetype)initWithCard:(QSCards *)card isFromRoot:(BOOL)isRoot{
	if (self = [super init]){
		_card = card;
		isFromRoot = isRoot;
	}
	return self;
}


- (void)setUI{
	_merchantName = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, kMainScreenWidth - 40, 30)];
	_merchantName.text = _card.merchant;
	_merchantName.textColor = [UIColor blueColor];
	_merchantName.font = kFont17;
	[self.view addSubview:_merchantName];
	
	_cardTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(_merchantName.left, _merchantName.bottom + 10, 60, 60)];
	_cardTypeImage.image = [UIImage imageNamed:@"cardImage1"];
	_cardTypeImage.highlightedImage = [UIImage imageNamed:@"cardImage1"];
	[self.view addSubview:_cardTypeImage];
	
	_cardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cardTypeImage.right + 10, _cardTypeImage.top, kMainScreenWidth - _cardTypeImage.right - 20, 20)];
	_cardNameLabel.font = kFont17;
	_cardNameLabel.text = _card.name;
	[self.view addSubview:_cardNameLabel];
	
	_introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cardTypeImage.right + 10, _cardNameLabel.bottom , _cardNameLabel.width, _cardTypeImage.height)];
	_introduceLabel.font = kFont12;
	_introduceLabel.textColor = [UIColor grayColor];
	switch ([_card.cardType integerValue]) {
		case 1:{
			[_introduceLabel setNumberOfLines:3];
			_introduceLabel.text = [NSString stringWithFormat:@"剩%@张 (已领用%@张)\n单笔满%.2lf元可用，每人限领%@张\n截止%@", _card.stocks,_card.sold,[_card.moneyCondition doubleValue]/100, _card.limited, _card.endProperty];
		}
			break;
		case 7:{
			[_introduceLabel setNumberOfLines:3];
			_introduceLabel.text = [NSString stringWithFormat:@"剩%@张 (已领用%@张)\n单笔满%.2lf元可用，每人限领%@张\n截止%@", _card.stocks,_card.sold,[_card.moneyCondition doubleValue]/100, _card.limited, _card.endProperty];
		}break;
		default:
			break;
	}
	[self.view addSubview:_introduceLabel];
	
	_button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 28)];
	_button.center = CGPointMake(kMainScreenWidth/2, _introduceLabel.bottom + 30);
//	[_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchDown];
//	_button.backgroundColor = RGBCOLOR(240, 240, 240);
//	_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
//	_button.layer.borderWidth = 1;
//	//	_button.layer.cornerRadius = 5;
//	_button.titleLabel.font = kFont13;
//	[_button setTitle:@"立即领用" forState:UIControlStateNormal];
//	[_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[_button setBackgroundImage:[UIImage imageNamed:@"QSLingYong"] forState:UIControlStateNormal];
	[self.view addSubview:_button];
	
	_recommendsView = [[QSMerchantCommendView alloc] initWithFrame:CGRectMake(0, _button.bottom + 5, kMainScreenWidth, kMainScreenHeight - _button.bottom - 5)];
	_recommendsView.backgroundColor = [UIColor whiteColor];
	_recommendsView.delegate = self;
	[self.view addSubview:_recommendsView];
}

- (void)gotoMoreCard{
	if (isFromRoot) {
		[self.navigationController popViewControllerAnimated:YES];
	}else{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.navigationController.navigationBarHidden = NO;
	self.view.backgroundColor = RGBCOLOR(238, 238, 238);
	self.title = @"领取优惠券";
	[self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
	[self setUI];
	
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
