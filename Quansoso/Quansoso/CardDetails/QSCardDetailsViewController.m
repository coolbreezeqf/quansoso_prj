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
@interface QSCardDetailsViewController ()
//data
@property (nonatomic,strong) QSCards *card;
//UI
@property (nonatomic,strong) UILabel *introduceLabel;
@property (nonatomic,strong) UILabel *merchantName;
@property (nonatomic,strong) UILabel *cardNameLabel;
@property (nonatomic,strong) UIImageView *cardTypeImage;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIView *recommendsView; // 推荐view

@end

@implementation QSCardDetailsViewController
- (void)buttonAction{
	
	if(![[TaeSession sharedInstance] isLogin]){
		__weak QSCardDetailsViewController *weakself = self;
		[[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
			[weakself accreditLogin];
		} failedCallback:^(NSError *error) {
			CAlertLabel *alert = [CAlertLabel alertLabelWithAdjustFrameForText:@"授权失败"];
			[alert showAlertLabel];
		}];
		return;
	}else{
		
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
	}
	return self;
}


- (void)setUI{
	_merchantName = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kMainScreenWidth - 40, 30)];
	_merchantName.text = _card.merchant;
	_merchantName.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
	[self.view addSubview:_merchantName];
	
	_cardTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(_merchantName.left, _merchantName.bottom + 5, 60, 60)];
	_cardTypeImage.image = [UIImage imageNamed:@"cardImage1"];
	_cardTypeImage.highlightedImage = [UIImage imageNamed:@"cardImage1"];
	[self.view addSubview:_cardTypeImage];
	
	_cardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cardTypeImage.right + 10, _cardTypeImage.top, kMainScreenWidth - _cardTypeImage.right - 20, 20)];
	_cardNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
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
			
		default:
			break;
	}
	[self.view addSubview:_introduceLabel];
	
	_button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 28)];
	_button.center = CGPointMake(kMainScreenWidth/2, _introduceLabel.bottom + 30);
	[_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchDown];
	_button.backgroundColor = [UIColor whiteColor];
	_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_button.layer.borderWidth = 1;
	_button.layer.cornerRadius = 5;
	_button.titleLabel.font = kFont13;
	[_button setTitle:@"立即领用" forState:UIControlStateNormal];
	[_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_button];
	
	_recommendsView = [[UIView alloc] initWithFrame:CGRectMake(0, _button.bottom + 5, kMainScreenWidth, kMainScreenHeight - _button.bottom - 5)];
	_recommendsView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_recommendsView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = RGBCOLOR(230, 230, 230);
	self.navigationController.navigationBarHidden = NO;
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
