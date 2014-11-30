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
#define kTitleColor RGBCOLOR(149, 149, 149)

@interface QSSettingView ()<UIActionSheetDelegate>{
	NSArray *titles;
}
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,strong) QSDataSevice *dataSevice;
@property (nonatomic,strong) UIButton *logoutBt;
@end

@implementation QSSettingView
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
//	CAlertLabel *alert = [CAlertLabel alertLabelWithAdjustFrameForText:@"暂无"];
//	[alert showAlertLabel];
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
		[_logoutBt setTitle:@"退出登陆" forState:UIControlStateNormal];
		[_logoutBt addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchDown];
		[_logoutBt setBackgroundImage:[UIImage imageNamed:@"feedbackImg.png"] forState:UIControlStateNormal];
	}
	[self addSubview:_logoutBt];
}
- (void)logout{
	if (![[TaeSession sharedInstance] isLogin]) {
		[SVProgressHUD showErrorWithStatus:@"尚未登陆" cover:YES offsetY:kMainScreenHeight/2];

		return;
	}
	[[TaeSDK sharedInstance] logout];
//    while([[TaeSession sharedInstance] isLogin]) {
//		CAlertLabel *alert = [CAlertLabel alertLabelWithAdjustFrameForText:@"退出成功"];
//		[alert showAlertLabel];
        self.myBlock();
        [SVProgressHUD showSuccessWithStatus:@"退出成功" cover:YES offsetY:kMainScreenHeight/2];
//	}
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

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = RGBCOLOR(242, 239, 233);
		titles = @[@"优惠消息推送",@"关注券搜搜微博",@"意见反馈",@"分享app",@"关于我们",@"清处缓存"];
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kMainScreenWidth, 44*6-1) style:UITableViewStylePlain];
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
		case 4:
		{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}			break;
		case 5:
		{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}			break;
		default:
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
