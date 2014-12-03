//
//  QSRootViewController.m
//  Quansoso
//
//  Created by  striveliu on 14-9-17.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSRootViewController.h"
#import "ViewInteraction.h"
#import "UIImageView+WebCache.h"
#import "NetManager.h"
#import <TAESDK/TAESDK.h>
#import "SVProgressHUD.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"

typedef NS_ENUM(NSInteger, cateType) {
    cateTypeIndex = 0,
    cateTypeCoupon,
    cateTypeBrand,
    cateTypeShare,
    cateTypeNull,
    cateTypeSetting
};

@interface QSRootViewController (){
	BOOL haveSearchBar;
}
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic) int currentPage;
@end

@implementation QSRootViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        fbkvo = [[FBKVOController alloc] initWithObserver:self];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (leftView) {
        if (_currentPage==cateTypeIndex)
        {
            self.navigationController.navigationBarHidden = YES;
        }
        else
        {
            self.navigationController.navigationBarHidden = NO;
        }
    }
    else
    {
        self.navigationController.navigationBarHidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setLeftButton:nil title:@"登出" target:self action:@selector(logout)];
    _currentPage=cateTypeIndex;
    UIButton *rigthBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 12)];
    [rigthBtn addTarget:self action:@selector(leftButtonItem) forControlEvents:UIControlEventTouchUpInside];
    [rigthBtn setImage:[UIImage imageNamed:@"QSRightMoreButton"] forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    [self showFirstView];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        UIImageView *guideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight+20)];
        if (kMainScreenHeight<=480)
        {
            [guideView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QSGuide44s@2x" ofType:@"png"]]];
        }
        else
        {
            [guideView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QSGuideView@2x" ofType:@"png"]]];
        }
        guideView.tag = 10000;
        guideView.contentMode = UIViewContentModeScaleAspectFill;
        guideView.userInteractionEnabled = YES;
        UITapGestureRecognizer *removeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeGuideView)];
        [guideView addGestureRecognizer:removeGesture];
        [self.view addSubview:guideView];
    }
    else
    {
        MLOG(@"not first");
    }
    
//    self.title = @"首页";
}

- (void)removeGuideView
{
    [[self.view viewWithTag:10000] removeFromSuperview];
}

#pragma mark 淘宝的系列操作
#pragma mark 淘宝login
- (void)checkLogin
{
    if(![[TaeSession sharedInstance] isLogin]){
        [[TaeSDK sharedInstance] showLogin:self.navigationController  successCallback:^(TaeSession *session) {
            
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
            NSLog(@"%@", tip);
//            [self alert:tip];
        } failedCallback:^(NSError *error) {
            
            NSString *tip=[NSString stringWithFormat:@"登录失败:%@",error];
            NSLog(@"%@", tip);
//            [self alert:tip];
            
        }];
    }else{
        TaeSession *session=[TaeSession sharedInstance];
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
        NSLog(@"%@", tip);
//        [self alert:tip];
    }
}

#pragma mark 登出
- (void)logout
{
    [[TaeSDK sharedInstance] logout];
}

#pragma mark 重置SDK
- (void)resetSDK
{
    [TaeTest resetTaeSDKDemo];
}

#pragma mark right button
- (void)leftButtonItem
{
    if(!leftView)
    {
        leftView = [[QSRootLeftView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kMainScreenHeight)];
        [leftView useFadeBlock:^{
            [ViewInteraction viewDissmissAnimationToRight:leftView isRemove:NO completeBlock:^(BOOL isComplete) {
                
            }];
        }];
        [leftView useLoginBlock:^{
            [[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
                [self accreditLogin];
                [self updateUI];
            } failedCallback:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"登陆失败" cover:YES offsetY:kMainScreenHeight/2.0];
            }];
        }];
        __weak QSRootViewController *weakself = self;
        [fbkvo observe:leftView keyPath:@"categoryType" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            MLOG(@"%@", change);
            int cateType = [change[@"new"] intValue];
            [ViewInteraction viewDissmissAnimationToRight:leftView isRemove:NO completeBlock:^(BOOL isComplete) {
                
            }];
//            self.navigationController.navigationBarHidden = NO;
            switch (cateType) {
                case cateTypeIndex:
                {
                    _currentPage=cateTypeIndex;
                    [weakself showFirstView];
                    self.navigationController.navigationBarHidden = YES;
//                    self.title = @"首页";
                }
                break;
                case cateTypeCoupon:
                {
                    if ([[TaeSession sharedInstance] isLogin])
                    {
                        self.navigationController.navigationBarHidden = NO;
                        _currentPage=cateTypeCoupon;
                        [weakself showCouponView];
//                        self.title = @"我的优惠券";
                        [self settitleLabel:@"我的优惠券"];
                        MLOG(@"%@", [[TaeSession sharedInstance] getUser]);
                    }
                    else
                    {
                        [[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
                            self.navigationController.navigationBarHidden = NO;
                            _currentPage=cateTypeCoupon;
                            [weakself showCouponView];
                            [self settitleLabel:@"我的优惠券"];
                            [self accreditLogin];
                            [self updateUI];
                        } failedCallback:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"登陆失败" cover:YES offsetY:kMainScreenHeight/2.0];
                        }];
                    }
                }
                break;
                case cateTypeBrand:
                {
                    if ([[TaeSession sharedInstance] isLogin])
                    {
                        self.navigationController.navigationBarHidden = NO;
                        _currentPage=cateTypeBrand;
                        [weakself showAttentionBrandView];
//                        self.title = @"我关注的品牌";
                        [self settitleLabel:@"我关注的品牌"];
                        MLOG(@"%@", [[TaeSession sharedInstance] getUser]);
                    }
                    else
                    {
                        [[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
                            self.navigationController.navigationBarHidden = NO;
                            _currentPage=cateTypeBrand;
                            [weakself showAttentionBrandView];
                            [self settitleLabel:@"我关注的品牌"];
                            [self accreditLogin];
                            [self updateUI];
                        } failedCallback:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"登陆失败" cover:YES offsetY:kMainScreenHeight/2.0];
                        }];
                    }
                }
                break;
                case cateTypeShare:
                {
//                    _currentPage=cateTypeShare;
//                    [weakself showShareAppView];
////                    self.title = @"分享app";
//                    [self settitleLabel:@"分享app"];
                    [UMSocialSnsService presentSnsIconSheetView:self
                                                         appKey:kUMENG_APPKEY
                                                      shareText:@"我在#券搜搜#领取到了超值品牌优惠券，轻松省了几十元，你也来试试吧~"
                                                     shareImage:[UIImage imageNamed:@"AppIcon"]
                                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, UMShareToSina]
                                                       delegate:nil];
                }
                break;
                case cateTypeNull:
                {
                    
                }
                break;
                case cateTypeSetting:
                {
                    self.navigationController.navigationBarHidden = NO;
                    _currentPage=cateTypeSetting;
                    [weakself showSettingView];
//                    self.title = @"设置";
                    [self settitleLabel:@"设置"];
                }
                break;
                default:
                    break;
            }
        }];
        leftView.backgroundColor = kClearColor;
    }
    [self updateUI];
    [ViewInteraction viewPresentAnimationFromRight:self.view toView:leftView];
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

#pragma mark 登陆刷新UI
- (void)updateUI
{
    if ([[TaeSession sharedInstance] isLogin])
    {
        leftView.logInLabel.text = [TaeSession sharedInstance].getUser.nick;
        [leftView.headImgView sd_setImageWithURL:[NSURL URLWithString:[[TaeSession sharedInstance] getUser].iconUrl]];
        leftView.logInLabel.userInteractionEnabled = NO;
    }
    else
    {
        leftView.logInLabel.text = @"登录";
        [leftView.headImgView setImage:[UIImage imageNamed:@"QSUserDefualt"]];
        leftView.logInLabel.userInteractionEnabled = YES;
    }
}

- (void)updateLogoutUI
{
    leftView.logInLabel.text = @"登录";
    [leftView.headImgView setImage:[UIImage imageNamed:@"QSUserDefualt"]];
    leftView.logInLabel.userInteractionEnabled = YES;
}

#pragma mark Default  firstView
- (void)showFirstView
{
    if(!firstview)
    {
        firstview = [[QSFirstView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        [firstview touchRightMoreBtn:^{
            [self leftButtonItem];
        }];
        [self.view addSubview:firstview];
    }
    [self.view bringSubviewToFront:firstview];
}

#pragma mark settingView
- (void)showSettingView
{
    if(!settingView)
    {
        settingView = [[QSSettingView alloc] initWithFrame:self.view.bounds];
        [settingView useBlock:^{
            [self updateLogoutUI];
        }];
        [self.view addSubview:settingView];
    }
    [self.view bringSubviewToFront:settingView];
}

#pragma mark crazyQGview
- (void)showCrazyQGView
{
    if(!crazyQGView)
    {
        crazyQGView = [[QSCrazyQGView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:crazyQGView];
    }
    [self.view bringSubviewToFront:firstview];
}

#pragma mark couponView
- (void)showCouponView
{
    if(!couponView)
    {
        couponView = [[QSCouponView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:couponView];
    }
    [self.view bringSubviewToFront:couponView];
}

#pragma mark showShareAppView
- (void)showShareAppView
{
    if (!shareAppView)
    {
        shareAppView = [[QSShareAppView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:shareAppView];
    }
    [self.view bringSubviewToFront:shareAppView];
}

#pragma mark showAttentionBrandView
- (void)showAttentionBrandView
{
    if (!attentionBrandView)
    {
        attentionBrandView = [[QSAttentionBrandView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:attentionBrandView];
    }
    [self.view bringSubviewToFront:attentionBrandView];
}

#pragma mark searchView
- (void)showSearchView
{
    if(!searchView){
        searchView = [[QSSearchView alloc] initWithFrame:self.view.bounds];
		[self.view addSubview:searchView];
    }
    [self.view bringSubviewToFront:firstview];
}

- (void)showSearchBar{
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchContent)];
	rightItem.tintColor = [UIColor whiteColor];
	rightItem.width = 44;
	self.navigationItem.rightBarButtonItem = rightItem;
	
	if (!_searchBar) {
		UIView *leftBarView = self.navigationItem.leftBarButtonItem.customView;
		UIBarButtonItem *rightBarButton = self.navigationItem.rightBarButtonItem;
		_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(leftBarView.width,0, kMainScreenWidth - leftBarView.width - rightBarButton.width , 44)];
		_searchBar.backgroundColor = [UIColor clearColor];
		_searchBar.delegate = self;
		[_searchBar setPlaceholder:@"输入要搜索的内容"];
		[_searchBar setTintColor:[UIColor blackColor]];
		[_searchBar becomeFirstResponder];
	}
	haveSearchBar = YES;
	[self.navigationController.navigationBar addSubview:_searchBar];
}

- (void)hideSearchBar{
	[_searchBar removeFromSuperview];
	self.navigationItem.rightBarButtonItem = nil;
	haveSearchBar = NO;
}

- (void)searchContent{
	[searchView searchContent:_searchBar.text];
	[_searchBar resignFirstResponder];
}

#pragma mark touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[_searchBar resignFirstResponder]; //点击空白部分 取消_searchBar的第一响应者
}

#pragma mark UISearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[searchView searchContent:_searchBar.text];
	[_searchBar resignFirstResponder];
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
