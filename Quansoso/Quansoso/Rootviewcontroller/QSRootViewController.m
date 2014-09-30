//
//  QSRootViewController.m
//  Quansoso
//
//  Created by  striveliu on 14-9-17.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSRootViewController.h"
#import "ViewInteraction.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    [self setRightButton:nil title:@"right" target:self action:@selector(leftButtonItem)];
//    [self setRightButton:nil title:@"个人" target:self action:@selector(rightButtonItem)];
    [self showFirstView];
    self.title = @"首页";
}

//#pragma mark right button
//- (void)rightButtonItem
//{
//    QSUserCenterViewController *userCenterVC = [[QSUserCenterViewController alloc] init];
//    [self.navigationController pushViewController:userCenterVC animated:YES];
//}

#pragma mark left button
- (void)leftButtonItem
{
    if(!leftView)
    {
        leftView = [[QSRootLeftView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kMainScreenHeight)];
        __weak QSRootViewController *weakself = self;
        [fbkvo observe:leftView keyPath:@"categoryType" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            MLOG(@"%@", change);
            int cateType = [change[@"new"] intValue];
            [ViewInteraction viewDissmissAnimationToRight:leftView isRemove:NO completeBlock:^(BOOL isComplete) {
                
            }];
            switch (cateType) {
                case cateTypeIndex:
                {
                    [weakself showFirstView];
                    self.title = @"首页";
                }
                break;
                case cateTypeCoupon:
                {
                    [weakself showCouponView];
                    self.title = @"我的优惠券";
                }
                break;
                case cateTypeBrand:
                {
                    [weakself showSearchView];
                    self.title = @"我关注的品牌";
                }
                break;
                case cateTypeShare:
                {
                    [weakself showSettingView];
                    self.title = @"分享app";
                }
                break;
                case cateTypeNull:
                {
                    
                }
                break;
                case cateTypeSetting:
                {
                    [weakself showSettingView];
                    self.title = @"设置";
                }
                break;
                default:
                    break;
            }
        }];
        leftView.backgroundColor = kClearColor;
    }
    [ViewInteraction viewPresentAnimationFromRight:self.view toView:leftView];
}

#pragma mark Default  firstView
- (void)showFirstView
{
    if(!firstview)
    {
        firstview = [[QSFirstView alloc] initWithFrame:self.view.bounds];
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
