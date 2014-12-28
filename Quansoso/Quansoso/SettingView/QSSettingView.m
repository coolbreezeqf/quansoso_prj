//
//  QSSettingView.m
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSettingView.h"
#import "QSDataSevice.h"
#import <TAESDK/TAESDK.h>
#import "QSAboutMeViewController.h"
#import "QSFeedBackViewController.h"
#import "ViewInteraction.h"
#import "SVProgressHUD.h"
#import "SDImageCache.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"
#import "NetManager.h"
#import "JSONKit.h"
#define kTitleColor RGBCOLOR(149, 149, 149)
@interface QSSettingView ()<UIActionSheetDelegate,UIAlertViewDelegate>{
	NSArray *titles;
}
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,strong) QSDataSevice *dataSevice;
@property (nonatomic,strong) UIButton *logoutBt;
@end

@implementation QSSettingView
- (void)setLogButtonTitle:(NSString *)title{
	[_logoutBt setTitle:title forState:UIControlStateNormal];
}

- (void)useBlock:(void (^)(void))aBlock
{
    self.myBlock = aBlock;
}

- (void)switchChanged{
	BOOL isOn = _switchView.isOn;
	_dataSevice.pushIntroduceStatus = isOn;
	[_dataSevice savePushIntroduceStatus];
}

- (void)attentionWeibo{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://weibo.com/u/2269834092"]];
	[[UIApplication sharedApplication] openURL:url];
}

- (void)feedback{
	QSFeedBackViewController *fbvc = [[QSFeedBackViewController alloc] init];
	[ViewInteraction viewPushViewcontroller:fbvc];
}

- (void)aboutMe{
	QSAboutMeViewController *amvc = [[QSAboutMeViewController alloc] init];
	[ViewInteraction viewPushViewcontroller:amvc];
}

- (void)share{
    [UMSocialSnsService presentSnsIconSheetView:[self viewController]
                                         appKey:kUMENG_APPKEY
                                      shareText:@"我在#券搜搜#领取到了超值品牌优惠券，轻松省了几十元，你也来试试吧~http://quansoso.wx.jaeapp.com/d/download"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, UMShareToSina]
                                       delegate:nil];
}

- (void)update{	//检查版本更新
	NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
	//CFShow((__bridge CFTypeRef)(infoDic));
	NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
	if (![[[QSDataSevice sharedQSDataSevice] lastVersion] isEqualToString:currentVersion]) {
		//trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
		alert.tag = 10000;
		[alert show];
	}
	else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		alert.tag = 10001;
		[alert show];
	}
}

//获取viewcontroller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)cleanCache{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定要清空券搜搜的本地所有缓存数据?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空缓存数据" otherButtonTitles: nil];
	[actionSheet showInView:self];
	
}

- (void)showLogoutButton{
	if (!_logoutBt) {
		_logoutBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
		_logoutBt.center = CGPointMake(kMainScreenWidth/2, self.bounds.size.height - 40);
		[_logoutBt setTitleColor:RGBCOLOR(105, 192, 17) forState:UIControlStateNormal];
		NSString *title;
		if(![[TaeSession sharedInstance] isLogin]){
			title = @"登录";
		}else{
			title = @"退出登录";
		}
		[_logoutBt setTitle:title forState:UIControlStateNormal];
		[_logoutBt addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchDown];
		[_logoutBt setBackgroundImage:[UIImage imageNamed:@"feedbackImg.png"] forState:UIControlStateNormal];
	}
	[self addSubview:_logoutBt];
}
- (void)logout{
	if (![[TaeSession sharedInstance] isLogin]) {
		[[TaeSDK sharedInstance] showLogin:[self viewController] successCallback:^(TaeSession *session) {
			[self viewController].navigationController.navigationBarHidden = NO;
			[self accreditLogin];
            [self setLogButtonTitle:@"退出登录"];
			[[NSNotificationCenter defaultCenter] postNotificationName:kTaeLoginInSuccessMsg object:nil];
		} failedCallback:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"登录失败" cover:YES offsetY:kMainScreenHeight/2.0];
		}];
	}else{
		[[TaeSDK sharedInstance] logout];
		self.myBlock();
		[SVProgressHUD showSuccessWithStatus:@"退出成功" cover:YES offsetY:kMainScreenHeight/2];
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

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 0) {
		dispatch_async(
					   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
					   , ^{
						   [[[SDImageCache alloc] init] clearMemory];
						   [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
	}
}

- (void)clearCacheSuccess{
	[SVProgressHUD showSuccessWithStatus:@"清理成功" cover:YES offsetY:kMainScreenHeight/2];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag==10000) {
		if (buttonIndex==1) {
			NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/videolicious/id%@?mt=8",kAPP_ID];
			NSURL *url = [NSURL URLWithString:urlStr];
			[[UIApplication sharedApplication] openURL:url];
		}
	}
}

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = RGBCOLOR(242, 239, 233);
		titles = @[@"优惠消息推送",@"关注券搜搜微博",@"意见反馈",@"分享app",@"关于我们",@"版本更新",@"清处缓存"];
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kMainScreenWidth, 44*titles.count-1) style:UITableViewStylePlain];
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.scrollEnabled = NO;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		[self addSubview:_tableView];
		[self showLogoutButton];
		_dataSevice = [QSDataSevice sharedQSDataSevice];
	}
	return self;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//	return titles.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell;
	//	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(10, 0, kMainScreenWidth - 100, 44)];
	//	cell.textLabel.text = [titles objectAtIndex:indexPath.row];
	switch (indexPath.row) {
		case 0:{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
			_switchView  = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
			[_switchView addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventValueChanged];
			_switchView.on = _dataSevice.pushIntroduceStatus;
			cell.accessoryView = _switchView;
		}
			break;
		case 1:{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
			cell.detailTextLabel.font = kFont10;
			cell.detailTextLabel.text = @"每月有抽奖,惊喜乐不停";
			cell.detailTextLabel.textColor = [UIColor lightGrayColor];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
			break;
		case 2:{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
			cell.detailTextLabel.font = kFont10;
			cell.detailTextLabel.text = @"您的建议，是我们进步的动力";
			cell.detailTextLabel.textColor = [UIColor lightGrayColor];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
			break;
		case 3:
		{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		cell.detailTextLabel.font = kFont10;
		cell.detailTextLabel.text = @"和好朋友一起来省钱吧";
		cell.detailTextLabel.textColor = [UIColor lightGrayColor];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
			break;
		default:{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
			break;
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = [titles objectAtIndex:indexPath.row];
	cell.textLabel.textColor = kTitleColor;
	cell.textLabel.font = kFont13;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.row) {
		case 1:
			[self attentionWeibo];
			break;
		case 2:
			[self feedback];
			break;
		case 3:
			[self share];
			break;
		case 4:
			[self aboutMe];
			break;
		case 5:
			[self update];
			break;
		case 6:
			[self cleanCache];
			break;
		default:
			break;
	}
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
