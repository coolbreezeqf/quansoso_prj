//
//  QSRootViewController.m
//  Quansoso
//
//  Created by  striveliu on 14-9-17.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSRootViewController.h"
#import "ViewInteraction.h"
@interface QSRootViewController ()

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
    self.view.backgroundColor = [UIColor redColor];
    [self setLeftButton:nil title:@"left" target:self action:@selector(leftButtonItem)];
}

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
            [ViewInteraction viewDissmissAnimationToLeft:leftView isRemove:NO];
            switch (cateType) {
                case 0:
                {
                    [weakself showFirstView];
                }
                break;
                case 1:
                {
                    [weakself showCrazyQGView];
                }
                break;
                case 2:
                {
                    [weakself showSearchView];
                }
                break;
                case 3:
                {
                    [weakself showSettingView];
                }
                break;
                default:
                    break;
            }
        }];
        leftView.backgroundColor = kClearColor;
    }
    [ViewInteraction viewPresentAnimationFromLeft:self.view toView:leftView];
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

#pragma mark searchView
- (void)showSearchView
{
    if(!searchView)
    {
        searchView = [[QSSearchView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:searchView];
    }
    [self.view bringSubviewToFront:firstview];
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
