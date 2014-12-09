//
//  QSMerchantDetailsViewController.m
//  Quansoso
//
//  Created by yato_kami on 14/11/10.
//  Copyright (c) 2014年 taobao. All rights reserved.
//
#import "QSMerchantDetailsViewController.h"
#import "ResultCard.h"
#import "UIImageView+WebCache.h"
#import "QSCardTableViewCell.h"
#import "QSMerchantNetManager.h"
#import "QSSActivities.h"
#import "QSSMerchant.h"
#import "QSCards.h"
#import "QSActivity.h"
#import "QSCardDetailsViewController.h"
#import "QSCardCell.h"
#import "SVProgressHUD.h"
#import "QSshowMerIntrodView.h"
#import "QSLikeBrandManage.h"
#import "IntroduceViewController.h"
#import <TAESDK/TAESDK.h>
#import "NetManager.h"
//#import "QSCardDetailsViewController.h"
#define logoViewWidth 130
#define logoImgWidth 100
#define kGrayColor RGBCOLOR(242, 239, 233)
#define isTest 0
#define showMerViewHeight 100

@interface QSMerchantDetailsViewController()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
	NSInteger _shopId;
    CGFloat _detailMercBtnCenterX;
	UILabel *tipLabel;
	UIButton *rightButton;
}
//data
@property (strong, nonatomic) QSSMerchant *merchant;
@property (strong, nonatomic) NSArray *cardsArray;
@property (strong, nonatomic) NSArray *activities;
//UI
@property (nonatomic,strong) UIView *logoView;
@property (nonatomic,strong) UIView *merchantToolView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) UIView *dimView;
@property (strong, nonatomic) QSshowMerIntrodView *showMerIntrodView;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) QSLikeBrandManage *likeManager;
@property (strong, nonatomic) UIImageView *backImageView;
@end

@implementation QSMerchantDetailsViewController

#pragma mark - getter and setter

- (QSLikeBrandManage *)likeManager
{
    if (!_likeManager) {
        _likeManager = [[QSLikeBrandManage alloc] init];
    }
    return _likeManager;
}

- (UIView *)dimView
{
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight)];
        _dimView.backgroundColor = [UIColor clearColor];
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.top, kMainScreenWidth, self.tableView.height)];
        blackView.backgroundColor = RGBACOLOR(200, 200, 200, 0.7);
        [_dimView addSubview:blackView];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeDimView)];
        [_dimView addGestureRecognizer:tapRecognizer];
    }
    return _dimView;
}

- (QSshowMerIntrodView *)showMerIntrodView
{
    if (!_showMerIntrodView) {
        _showMerIntrodView = [[QSshowMerIntrodView alloc] initWithFrame:CGRectMake(0, self.tableView.top-10, kMainScreenWidth, showMerViewHeight) AngleX:_detailMercBtnCenterX angleHeight:10];
    }
    return _showMerIntrodView;
}

#pragma mark - init

- (instancetype)initWithShopId:(NSInteger)shopid{
    if (self = [super init]) {
        _shopId = shopid;
		_isFollow = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
	self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"加载中...";
	[self setUI];
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame = CGRectMake(0, 0, 20, 20);
    _activityView.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
	
	
    QSMerchantNetManager *netManager = [[QSMerchantNetManager alloc] init];
    __weak QSMerchantDetailsViewController *weakSelf = self;
	if ([[TaeSession sharedInstance] isLogin]) {
		NSString *nick = [[TaeSession sharedInstance] getUser].nick;
		[netManager isFollowShopWithShopId:_shopId andNick:nick success:^(bool isfollow) {
			weakSelf.isFollow = isfollow;
			[weakSelf setLikeImage];
		} failure:^{
			
		}];
	}
	
    [netManager getMerchantWithShopID:_shopId success:^(QSSMerchant *merchant,NSArray *cardsArray,NSArray *activities) {
        [weakSelf.activityView stopAnimating];
        weakSelf.merchant = merchant;
        weakSelf.cardsArray = cardsArray;
		weakSelf.activities = activities;
//        [weakSelf settitleLabel:merchant.name];
		weakSelf.navigationItem.title = merchant.name;
        NSInteger categoryType = 1;
        categoryType = [weakSelf.merchant.ekpCategory integerValue];
		categoryType = categoryType ? categoryType : 1;
        MLOG(@"------%@--------",weakSelf.merchant.ekpCategory);
        weakSelf.backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"QSstoreBackImg%i",categoryType]];
        weakSelf.showMerIntrodView.text = weakSelf.merchant.merchantDescription;
        [weakSelf.logoImageView sd_setImageWithURL:[NSURL URLWithString:self.merchant.picUrl] placeholderImage:[UIImage imageNamed:@"QSUserDefualt"]];
        [weakSelf.tableView reloadData];
    } failure:^{
        [weakSelf.activityView stopAnimating];
//        weakSelf.title = @"加载失败";
        [weakSelf settitleLabel:@"加载失败"];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
    }];
	
}

- (void)setUI{
//    self.navigationItem.title = self.merchant.name;
	self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"QSBrandUnlike"] style:UIBarButtonItemStylePlain target:self action:@selector(privateTheMerchant)];
	[self setRightButton:[UIImage imageNamed:@"QSBrandUnlike"] title:nil target:self action:@selector(privateTheMerchant)];
	
	
    [self creatLogoView];
    [self creatMerchantToolView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.merchantToolView.bottom, kMainScreenWidth, kMainScreenHeight-64-self.logoView.height-self.merchantToolView.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kGrayColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.tableView.rowHeight = kCellHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self.tableView registerClass:[QSCardCell class] forCellReuseIdentifier:@"CardCellIdentifier"];
	tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kMainScreenWidth,30)];
	tipLabel.text = @"该商家暂无优惠券";
    tipLabel.backgroundColor = [UIColor clearColor];
	tipLabel.textAlignment = NSTextAlignmentCenter;
	tipLabel.textColor = [UIColor lightGrayColor];
	tipLabel.center = CGPointMake(self.tableView.width/2, self.tableView.height/2);
	[self.tableView addSubview:tipLabel];
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

- (void)setLikeImage{
	[rightButton setBackgroundImage:[UIImage imageNamed:_isFollow?@"QSBrandLiked":@"QSBrandUnlike"] forState:UIControlStateNormal] ;
}

- (void)creatLogoView
{
    //---商家logo部分view---
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 160)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:logoView.frame];

    //self.merchant.type
    //imageView.image = [UIImage imageNamed:@"QSstoreBackImg1"];
    imageView.backgroundColor = [UIColor whiteColor];
    _backImageView = imageView;
    [logoView addSubview:imageView];
    //圆形logo背景
    UIView *logoBackview = [[UIView alloc] initWithFrame:CGRectMake((kMainScreenWidth-logoViewWidth)/2.0f, (160-logoViewWidth)/2.0, logoViewWidth, logoViewWidth)];
    logoBackview.layer.cornerRadius = logoBackview.width/2.0;
    logoBackview.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
    logoBackview.clipsToBounds = YES;
    [logoView addSubview:logoBackview];
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((logoViewWidth - logoImgWidth)/2.0, (logoViewWidth - logoImgWidth)/2.0, logoImgWidth, logoImgWidth)];
    _logoImageView = logoImageView;
    logoImageView.clipsToBounds = YES;
    logoImageView.layer.cornerRadius = logoImageView.width/2.0f;
    logoImageView.backgroundColor = [UIColor whiteColor];
    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [logoBackview addSubview:logoImageView];
    [self.view addSubview:logoView];
    _logoView = logoView;
}

- (void)creatMerchantToolView
{
    //---店铺信息 功能view
    UIView *merchantToolView = [[UIView alloc] initWithFrame:CGRectMake(0, _logoView.bottom, kMainScreenWidth, 40)];
    merchantToolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:merchantToolView];
    UILabel *titileLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 30)];
    titileLable.text = @"店铺优惠";
    [merchantToolView addSubview:titileLable];
    
    UIButton *goMercButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goMercButton setFrame:CGRectMake(kMainScreenWidth-55-10, 5, 55, 30)];
    [goMercButton setTitle:@"进入店铺" forState:UIControlStateNormal];
    [goMercButton addTarget:self action:@selector(touchGoMercButton) forControlEvents:UIControlEventTouchUpInside];
    goMercButton.titleLabel.font = kFont13;
    [goMercButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //goMercButton.backgroundColor = [UIColor blackColor];
    [merchantToolView addSubview:goMercButton];
    UIImageView *mImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QSgoMerc"]];
    mImageview.frame = CGRectMake(goMercButton.left-5-20, 12, 20, 15);
    [merchantToolView addSubview:mImageview];
    
    UIButton *detailMercButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailMercButton setFrame:CGRectMake(mImageview.left-10-55, 5, 55, 30)];
    [detailMercButton addTarget:self action:@selector(touchDetailMercButton:) forControlEvents:UIControlEventTouchUpInside];
    detailMercButton.titleLabel.font = kFont13;
    [detailMercButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [detailMercButton setTitle:@"品牌介绍" forState:UIControlStateNormal];
    _detailMercBtnCenterX = detailMercButton.centerX;
    [merchantToolView addSubview:detailMercButton];
    UIImageView *dImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QSmeIntro"]];
    dImageview.frame = CGRectMake(detailMercButton.frame.origin.x-5-20, 12, 20, 15);
    [merchantToolView addSubview:dImageview];
    _merchantToolView = merchantToolView;
}



#pragma mark - tableview detegate and datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isTest) {
        return 5;
    }
    if (self.cardsArray && self.activities && self.cardsArray.count+self.activities.count) {
		if ([tipLabel superview]) {
			[tipLabel removeFromSuperview];
		}
        return self.cardsArray.count+self.activities.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 1;  //用来消除多余的分割线
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CardCellIdentifier";
    QSCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QSCardCell alloc] initWithReuseIdentifier:cellIdentifier];
    }
    if (indexPath.row >= self.activities.count) {
		int index = indexPath.row - self.activities.count;
        QSCards *card = [[QSCards alloc] initWithDictionary:self.cardsArray[index]];//self.cardsArray[indexPath.row];
        //MLOG(@"%@",card.denomination);
		NSString *endDate = card.endProperty?[card.endProperty substringWithRange:NSMakeRange(0, [card.endProperty rangeOfString:@" "].location)]:@"";
		[cell setCellUIwithCardType:card.cardType
					   denomination:card.denomination? :@""
					Money_condition:card.moneyCondition? :@""
								end:endDate
					   discountRate:card.discountRate
					   outdateState:[card.status integerValue]];
	}else{
		QSActivity *activity = [[QSActivity alloc] initWithDictionary:self.activities[indexPath.row]];
		NSString *endDate = activity?[activity.endProperty substringWithRange:NSMakeRange(0, [activity.endProperty rangeOfString:@" "].location)]:@"";
		NSString *cardType = [NSString stringWithFormat:@"%i",[activity.type integerValue]+1];
		if ([cardType integerValue] == cardType_floor) {
			[cell setCellUIwithCardType:cardType
						   denomination:activity.denomination
						Money_condition:activity.moneyCondition
									end:endDate
						   discountRate:activity.discountRate
						   outdateState:[activity.status intValue]];
		}else{
//			NSString *describe =
			[cell setCellUIwithCardType:cardType
						   denomination:activity.denomination
						Money_condition:activity.moneyCondition?:(activity.quantityCondition?:@"0")
									end:endDate
						   discountRate:activity.discountRate
						   outdateState:[activity.status intValue]];
		}
	}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row < self.activities.count) {
		QSActivity *activity = [[QSActivity alloc] initWithDictionary:self.activities[indexPath.row]];
//		QSCardDetailsViewController *dvc = [[QSCardDetailsViewController alloc] initWithActivity:activity];
		QSCardDetailsViewController *dvc = [[QSCardDetailsViewController alloc] initWithActivity:activity andSellerId:_merchant.externalId];
		[self.navigationController pushViewController:dvc animated:YES];
	}else{
		NSInteger index = indexPath.row - self.activities.count;
		QSCards *card = [[QSCards alloc] initWithDictionary:self.cardsArray[index]];
		//MLOG(@"%@",card);
//		if ([card.cardType integerValue] < 2 || [card.cardType integerValue] > 5) {
//			QSCardDetailsViewController *dVC = [[QSCardDetailsViewController alloc] initWithCard:card];
		QSCardDetailsViewController *dVC = [[QSCardDetailsViewController alloc] initWithCard:card webSite:_merchant.websiteUrl andSellerId:_merchant.externalId];
			[self.navigationController pushViewController:dVC animated:YES];
//		}
	}
}


#pragma mark - action
//收藏
- (void)privateTheMerchant
{
	__weak QSMerchantDetailsViewController *weakself = self;
	if ([[TaeSession sharedInstance] isLogin]) {
		if (!_isFollow) {
			[self.likeManager likeBrand:[self.merchant.externalShopId integerValue] andSuccBlock:^{
				[SVProgressHUD showSuccessWithStatus:@"关注成功" cover:NO offsetY:0];
				_isFollow = YES;
				[weakself setLikeImage];
			} failBlock:^{
				[SVProgressHUD showErrorWithStatus:@"关注失败" cover:NO offsetY:0];
			}];
		}else{
			[self.likeManager unlikeBrand:[self.merchant.externalShopId integerValue] andSuccBlock:^{
				_isFollow = NO;
				[SVProgressHUD showSuccessWithStatus:@"取消关注成功" cover:NO offsetY:0];
				[weakself setLikeImage];
			} failBlock:^{
				
			}];
		}
	}else{
		[[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
			self.navigationController.navigationBarHidden = NO;
			[weakself accreditLogin];
			[[NSNotificationCenter defaultCenter] postNotificationName:kTaeLoginInSuccessMsg object:nil];
		} failedCallback:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"登录失败" cover:YES offsetY:kMainScreenHeight/2.0];
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
		[SVProgressHUD showSuccessWithStatus:@"登录成功" cover:YES offsetY:kMainScreenHeight/2.0];
	} failure:^(NSDictionary *failDict, NSError *error) {
		MLOG(@"%@", failDict);
		[SVProgressHUD showSuccessWithStatus:@"登录失败" cover:YES offsetY:kMainScreenHeight/2.0];
	}];
}


//进入店铺
- (void)touchGoMercButton
{
//    if (self.merchant.websiteUrl && self.merchant.websiteUrl.length) {
//		NSString *str = [self.merchant.websiteUrl substringFromIndex:[self.merchant.websiteUrl rangeOfString:@"http"].location+4];
//		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao%@",str]];
//		if ([[UIApplication sharedApplication] canOpenURL:url]) {
//			UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确认使用淘宝客户端打开店铺" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开淘宝客户端" otherButtonTitles:nil];
//			[actionSheet showInView:self.view];
//		} else {
//			url = [NSURL URLWithString:[NSString stringWithFormat:@"http%@",str]];
//			[[UIApplication sharedApplication] openURL:url];
//		}
//
//	}else{
//		[SVProgressHUD showErrorWithStatus:@"缺少该商家店铺地址" cover:YES offsetY:kMainScreenHeight/2];
//	}
	if (self.merchant.websiteUrl && self.merchant.websiteUrl.length) {
//		IntroduceViewController *webView = [[IntroduceViewController alloc] init];
//		webView.isSysPush = YES;
//		[webView setUrl:self.merchant.websiteUrl title:self.merchant.name];
//		[self.navigationController pushViewController:webView animated:YES];
		TaeWebViewUISettings *wb = [[TaeWebViewUISettings alloc] init];
		wb.title = self.merchant.name;
		wb.titleColor = RGBCOLOR(75, 171, 14);
		[[TaeSDK sharedInstance] showPage:self isNeedPush:YES pageUrl:self.merchant.websiteUrl webViewUISettings:wb tradeProcessSuccessCallback:^(TaeTradeProcessResult *tradeProcessResult) {
			
		} tradeProcessFailedCallback:^(NSError *error) {
			
		}];
	}else{
		[SVProgressHUD showErrorWithStatus:@"缺少该商家店铺地址" cover:YES offsetY:kMainScreenHeight/2];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 0){
		NSString *str = [self.merchant.websiteUrl substringFromIndex:[self.merchant.websiteUrl rangeOfString:@"http"].location+4];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao%@",str]];
		[[UIApplication sharedApplication] openURL:url];
	}
}
//显示店铺详情
- (void)touchDetailMercButton:(UIButton *)sender
{
    self.showMerIntrodView.height = 1;
    [self.view addSubview:self.dimView];
    [self.dimView addSubview:self.showMerIntrodView];
    [UIView animateWithDuration:0.5f animations:^{
        self.showMerIntrodView.height = showMerViewHeight;
    }];
    
}

//隐藏dimView
- (void)removeDimView
{
    [UIView animateWithDuration:0.5f animations:^{
        self.showMerIntrodView.height = 1;
    } completion:^(BOOL finished) {
        [self.showMerIntrodView removeFromSuperview];
        [self.dimView removeFromSuperview];
    }];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
