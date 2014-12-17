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
#import "QSBrandBtnTableViewCell.h"
#import "QSMerchantDetailsViewController.h"
#import "QSSearchViewController.h"

//#define brandWidth 80;
//#define brandHeight 80;
@interface QSBrandCollectionViewController ()<UITableViewDataSource, UITableViewDelegate, QSBrandBtnTableViewCellDelegate, UIAlertViewDelegate>
{
    UIView *headerView;
    UIButton *attentionBtn;
    int lines;
    CGFloat interval;
    CGFloat brandWidth;
    CGFloat brandHeight;
    NSMutableDictionary *payAttentionBrand;
    
    int dragCount;
}
@property(nonatomic ,strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic ,strong) QSBrandListManage *brandListManage;
@property(nonatomic, strong) NSMutableArray *brandArray;
@property(nonatomic, strong) QSLikeBrandManage *likeBrandManage;
@property(nonatomic, strong) UIView *failView;
@property(nonatomic, strong) LoadingView *loadingView;
@property(nonatomic, strong) UIAlertView *alertView;
@end

@implementation QSBrandCollectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
#pragma mark 网络请求
    [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
        [self.loadingView removeFromSuperview];
        self.brandArray = aArray;
        if (self.brandArray.count==0) {
            [self.view addSubview:self.failView];
        }
        payAttentionBrand = [NSMutableDictionary new];
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
        [self.view addSubview:self.failView];
        [self.loadingView removeFromSuperview];
    }];
}

- (instancetype)init
{
    self = [super init];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dragCount=0;
    self.view.backgroundColor = [UIColor whiteColor];
    brandWidth = kMainScreenWidth/3;
    brandHeight = brandWidth/0.85;
    interval = 1;
    MLOG(@"%f %f", kMainScreenHeight-66, interval+brandHeight);
    payAttentionBrand = [NSMutableDictionary new];
    self.alertView.delegate = self;
//    lines = (kMainScreenHeight-66)/(interval+brandHeight);
    if (kMainScreenHeight>500) {
        lines=4;
    }
    else
    {
        lines=3;
    }
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
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
    
//#pragma mark 网络请求
//    [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
////        [self.activityIndicatorView stopAnimating];
//        [self.loadingView removeFromSuperview];
//        self.brandArray = aArray;
//        if (self.brandArray.count==0) {
//            [self.view addSubview:self.failView];
//        }
//        [self.showBrandTableView reloadData];
//    } andFailBlock:^{
//        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
//        [self.view addSubview:self.failView];
//        [self.loadingView removeFromSuperview];
//    }];
}

- (void)reloadTableView
{
    [self.showBrandTableView reloadData];
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

- (UIAlertView *)alertView
{
    if (!_alertView)
    {
        _alertView = [[UIAlertView alloc] initWithTitle:@"亲，还没有找到您喜欢的商家吗？不如试试搜索吧" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去搜索", nil];
        _alertView.delegate = self;
    }
    return _alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        QSSearchViewController *searchVC = [[QSSearchViewController alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }
}



#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSBrandCollectionViewController *weakself = self;
    [weakself.showBrandTableView addPullToRefreshWithActionHandler:^{
            [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
                [weakself.showBrandTableView.pullToRefreshView stopAnimating];
                self.brandArray = aArray;
//                [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:1];
                [self.showBrandTableView reloadData];
            } andFailBlock:^{
                [weakself.showBrandTableView.pullToRefreshView stopAnimating];
                [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
            }];
            [self.showBrandTableView reloadData];
    }];
    
    [weakself.showBrandTableView addInfiniteScrollingWithActionHandler:^{
        if (dragCount==5)
        {
            [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
            [self.alertView show];
            dragCount = 0;
        }
        else if (self.brandArray.count>0&&self.brandArray.count%(lines*3)==0)
        {
                [self.brandListManage getNextBrandListSuccBlock:^(NSArray *aArray) {
                    [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
                    dragCount++;
                    NSMutableArray *insertIndexPaths = [NSMutableArray new];
                    for (unsigned long i=self.brandArray.count/3; i<self.brandArray.count/3+aArray.count/3; i++) {
                        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                        [insertIndexPaths addObject:indexpath];
                    }
                    [self.brandArray addObjectsFromArray:aArray];
                    [self.showBrandTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                } andFailBlock:^{
                    [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
                    [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
                }];
        }
        else
        {
            [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
        }
        
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
        if (likedArray.count>0) {
            [self.likeBrandManage likeMultiBrand:likedArray andSuccBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kTaePayAttentionSuccessMsg object:nil];
            } failBlock:^{
                
            }];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kTaeLoginInSuccessMsg object:nil];
        //    MLOG(@"%@", likedArray);
        [self back];
    }
    else
    {
        [[TaeSDK sharedInstance] showLogin:self.navigationController successCallback:^(TaeSession *session) {
            self.navigationController.navigationBarHidden = NO;
            [self accreditLogin];
            [[NSNotificationCenter defaultCenter] postNotificationName:kTaeLoginInSuccessMsg object:nil];
        } failedCallback:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"登录失败" cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
}

#pragma mark 授权登录
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
    QSBrandBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[QSBrandBtnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    cell.row = indexPath.row;
    cell.backgroundColor = RGBCOLOR(228, 222, 214);
    if (cell.row<self.brandArray.count)
    {
        for (int i=0; i<3; i++)
        {
            QSMerchant *model = [self.brandArray objectAtIndex:indexPath.row*3+i];
            QSBrandBtn *btn = (QSBrandBtn *)[cell viewWithTag:i+1];
            [btn showDislike];
            [btn setBtnWithModel:model];
            NSArray *keyArray = [payAttentionBrand allKeys];
            for (int j=0; j<keyArray.count; j++)
            {
                NSString *key = [keyArray objectAtIndex:j];
                if (indexPath.row*3+i==[key intValue])
                {
                    [btn showLike];
                    break;
                }
            }
        }
    }
    return cell;
}

- (void)selectBrandCell:(QSBrandBtnTableViewCell *)aCell withRow:(int)aRow andIndex:(int)aIndex
{
    QSMerchant *model = [self.brandArray objectAtIndex:aRow*3+aIndex];
    QSMerchantDetailsViewController *vc = [[QSMerchantDetailsViewController alloc]
                                           initWithShopId:[model.externalShopId intValue]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectCell:(QSBrandBtnTableViewCell *)aCell withRow:(int)aRow andIndex:(int)aIndex
{
    MLOG(@"%d, %d", aRow, aIndex);
    QSBrandBtn *btn = (QSBrandBtn *)[aCell viewWithTag:aIndex+1];
    QSMerchant *model = [self.brandArray objectAtIndex:aRow*3+aIndex];
    if (btn.isLiked)
    {
        [payAttentionBrand removeObjectForKey:[NSString stringWithFormat:@"%d", aRow*3+aIndex]];
    }
    else
    {
        [payAttentionBrand setObject:model.externalShopId forKey:[NSString stringWithFormat:@"%d", aRow*3+aIndex]];
    }
    [btn changeLike];
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
