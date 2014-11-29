//
//  QSBrandCollectionViewController.m
//  Quansoso
//
//  Created by Johnny's on 14-10-3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandCollectionViewController.h"
#import "SVPullToRefresh.h"
#import "QSBrandListManage.h"
#import "QSBrandBtn.h"
#import "QSMerchant.h"
#import "UIImageView+WebCache.h"
#import "QSLikeBrandManage.h"
#import "LoadingView.h"
#import "SVProgressHUD.h"
#import <TAESDK/TAESDK.h>
#import "NetManager.h"

//#define brandWidth 80;
//#define brandHeight 80;
@interface QSBrandCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *headerView;
    UIButton *attentionBtn;
    int lines;
    CGFloat interval;
    CGFloat brandWidth;
    CGFloat brandHeight;
    NSMutableDictionary *payAttentionBrand;
}
@property(nonatomic ,strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic ,strong) QSBrandListManage *brandListManage;
@property(nonatomic, strong) NSMutableArray *brandArray;
@property(nonatomic, strong) QSLikeBrandManage *likeBrandManage;
@property(nonatomic, strong) UIView *failView;
@property(nonatomic, strong) LoadingView *loadingView;
@end

@implementation QSBrandCollectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (instancetype)init
{
    self = [super init];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    brandWidth = kMainScreenWidth/3;
    brandHeight = brandWidth/0.85;
    interval = 1;
    MLOG(@"%f %f", kMainScreenHeight-66, interval+brandHeight);
    payAttentionBrand = [NSMutableDictionary new];
//    lines = (kMainScreenHeight-66)/(interval+brandHeight);
    if (kMainScreenHeight>500) {
        lines=4;
    }
    else
    {
        lines=3;
    }
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 8, 16)];
    [backBtn setImage:[UIImage imageNamed:@"QSBackItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-85, 8, 80, 24)];
    [attentionBtn addTarget:self action:@selector(payAttention) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn setImage:[UIImage imageNamed:@"QSUnLikeBtn"] forState:UIControlStateNormal];
//    [self.navigationController.navigationBar addSubview:attentionBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:attentionBtn];
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.allowsSelection = NO;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.showBrandTableView.tableHeaderView = headerView;
    [self addTableViewTrag];
    [self.view addSubview:self.showBrandTableView];
    
//    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
//                                  initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2-40, 40, 40)];
//    [self.activityIndicatorView startAnimating];
//    self.activityIndicatorView.color = [UIColor blackColor];
//    [self.view addSubview:self.activityIndicatorView];
    [self.view addSubview:self.loadingView];
    
#pragma mark 网络请求
    [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
//        [self.activityIndicatorView stopAnimating];
        [self.loadingView removeFromSuperview];
        self.brandArray = aArray;
        if (self.brandArray.count==0) {
            [self.view addSubview:self.failView];
        }
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
        [self.view addSubview:self.failView];
        [self.loadingView removeFromSuperview];
    }];
}

- (void)back
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getter
- (LoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[LoadingView alloc] initWithFrame:self.showBrandTableView.bounds];
    }
    return _loadingView;
}

- (UIView *)failView
{
    if (!_failView) {
        _failView = [[UIView alloc] initWithFrame:self.view.bounds];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-60, kMainScreenHeight/2-60, 120, 20)];
        label.text = @"暂无数据";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor lightGrayColor];
        label.font = kFont14;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [_failView addSubview:label];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(label.left, label.bottom+50, 120, 30)];
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:RGBCOLOR(73, 167, 14) forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [RGBCOLOR(73, 167, 14) CGColor];
        
        [btn addTarget:self action:@selector(reloadView) forControlEvents:UIControlEventTouchUpInside];
        [_failView addSubview:btn];
    }
    return _failView;
}

- (void)reloadView
{
    [self.failView removeFromSuperview];
//    [self.activityIndicatorView startAnimating];
    [self.view addSubview:self.loadingView];
    [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
//        [self.activityIndicatorView stopAnimating];
        [self.loadingView removeFromSuperview];
        self.brandArray = aArray;
        if (self.brandArray.count==0) {
            [self.view addSubview:self.failView];
        }
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        [self.loadingView removeFromSuperview];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
        [self.view addSubview:self.failView];
    }];
}

- (QSBrandListManage *)brandListManage
{
    if (!_brandListManage)
    {
        _brandListManage = [[QSBrandListManage alloc] init];
    }
    return _brandListManage;
}

- (NSMutableArray *)brandArray
{
    if (!_brandArray) {
        _brandArray = [[NSMutableArray alloc] init];
    }
    return _brandArray;
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSBrandCollectionViewController *weakself = self;
    [weakself.showBrandTableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showBrandTableView.pullToRefreshView stopAnimating];
            [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
                self.brandArray = aArray;
                [self.showBrandTableView reloadData];
            } andFailBlock:^{
                
            }];
            [self.showBrandTableView reloadData];
        });
    }];
    
    [weakself.showBrandTableView addInfiniteScrollingWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
            [self.brandListManage getNextBrandListSuccBlock:^(NSArray *aArray) {
                NSMutableArray *insertIndexPaths = [NSMutableArray new];
                for (unsigned long i=self.brandArray.count/3; i<self.brandArray.count/3+aArray.count/3; i++) {
                    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                    [insertIndexPaths addObject:indexpath];
                }
                [self.brandArray addObjectsFromArray:aArray];
                [self.showBrandTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
            } andFailBlock:^{
                
            }];
            });
    }];
    
}

- (QSLikeBrandManage *)likeBrandManage
{
    if (!_likeBrandManage) {
        _likeBrandManage = [[QSLikeBrandManage alloc] init];
    }
    return _likeBrandManage;
}

#pragma mark 按钮 关注这些品牌
- (void)payAttention
{
    if ([[TaeSession sharedInstance] isLogin]) {
        self.navigationController.navigationBarHidden = YES;
        self.navigationController.navigationBarHidden = YES;
        NSArray *likedArray = [payAttentionBrand allValues];
        [self.likeBrandManage likeMultiBrand:likedArray andSuccBlock:^{
            
        } failBlock:^{
            
        }];
        //    MLOG(@"%@", likedArray);
        [self back];
    }
    else
    {
        [[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
            self.navigationController.navigationBarHidden = NO;
            [self accreditLogin];
        } failedCallback:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"登陆失败" cover:YES offsetY:kMainScreenHeight/2.0];
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


#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.brandArray.count/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return brandHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"brandCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = RGBCOLOR(228, 222, 214);
    for (int i=0; i<3; i++)
    {
        QSMerchant *model = [self.brandArray objectAtIndex:indexPath.row*3+i];
        QSBrandBtn *btn = [[QSBrandBtn alloc] initWithFrame:CGRectMake(brandWidth*i, 0, brandWidth, brandHeight)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBrand:)];
        [btn addGestureRecognizer:tapGesture];
        btn.tag = 100+indexPath.row*3+i;
        btn.isLiked = NO;
        [btn.brandImgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@""]];
        [cell addSubview:btn];
    }
    return cell;
}

#pragma mark 按钮事件
- (void)chooseBrand:(UITapGestureRecognizer *)aGestureRecognizer
{
    QSBrandBtn *aBtn = (QSBrandBtn *)aGestureRecognizer.view;
    if (aBtn.isLiked==NO)
    {
        [aBtn.brandLikeView setImage:[UIImage imageNamed:@"QSBrandLiked"]];
        QSMerchant *model = [self.brandArray objectAtIndex:aBtn.tag-100];
        [payAttentionBrand setObject:model.externalShopId forKey:[NSString stringWithFormat:@"%d", aBtn.tag]];
    }
    else
    {
        [aBtn.brandLikeView setImage:[UIImage imageNamed:@"QSBrandUnlike"]];
        [payAttentionBrand removeObjectForKey:[NSString stringWithFormat:@"%d", aBtn.tag]];
    }
    aBtn.isLiked = !aBtn.isLiked;
    if (payAttentionBrand.count>0)
    {
        [attentionBtn setImage:[UIImage imageNamed:@"QSLikeBrand"] forState:UIControlStateNormal];
    }
    else
    {
        [attentionBtn setImage:[UIImage imageNamed:@"QSUnLikeBtn"] forState:UIControlStateNormal];
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
