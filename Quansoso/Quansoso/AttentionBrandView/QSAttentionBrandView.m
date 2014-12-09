//
//  QSAttentionBrandView.m
//  Quansoso
//
//  Created by Johnny's on 14-10-3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSAttentionBrandView.h"
#import "QSAttentionBrandTableViewCell.h"
#import "SVPullToRefresh.h"
#import "ViewInteraction.h"
#import "QSBrandCollectionViewController.h"
#import "QSMerchant.h"
#import "QSMerchantDetailsViewController.h"
#import "NetManager.h"
#import "SVProgressHUD.h"
#import <TAESDK/TAESDK.h>

@implementation QSAttentionBrandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.brandArray = [NSMutableArray new];
    self.backgroundColor = [UIColor whiteColor];
    unLikeDict = [NSMutableDictionary new];
    
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    topview.backgroundColor = [UIColor whiteColor];
    UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-50, 15, 100, 30)];
    [attentionBtn setImage:[UIImage imageNamed:@"QSLikeBrand"] forState:UIControlStateNormal];
    [attentionBtn addTarget:self action:@selector(attentionBrand) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:attentionBtn];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = RGBCOLOR(239, 235, 227);
    [topview addSubview:bottomLineView];
    [self addSubview:topview];
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight-60-62)];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.showBrandTableView];
    
    [self addTableViewTrag];

    [self addSubview:self.loadingView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kTaePayAttentionSuccessMsg object:nil];
    
#pragma mark 网络请求
    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
        self.brandArray = [aArray mutableCopy];
        if (self.brandArray.count==0) {
            [self addSubview:self.failView];
        }
        [self.loadingView removeFromSuperview];
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        [self addSubview:self.failView];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
        [self.loadingView removeFromSuperview];
    } isIndex:NO];
    return self;
}

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
        _failView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight-60-62)];
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
    if (self.failView.superview) {
        [self.failView removeFromSuperview];
    }
    [self addSubview:self.loadingView];
    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
        self.brandArray = [aArray mutableCopy];
        if (self.brandArray.count==0) {
            [self addSubview:self.failView];
        }
        [self.loadingView removeFromSuperview];
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        [self.loadingView removeFromSuperview];
        [self addSubview:self.failView];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
    } isIndex:NO];
}

- (QSAttentionBrandListManage *)attentionBrandListManage
{
    if (!_attentionBrandListManage)
    {
        _attentionBrandListManage = [[QSAttentionBrandListManage alloc] init];
    }
    return _attentionBrandListManage;
}

- (QSLikeBrandManage *)likeBrandManage
{
    if (!_likeBrandManage) {
        _likeBrandManage = [[QSLikeBrandManage alloc] init];
    }
    return _likeBrandManage;
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSAttentionBrandView *weakself = self;
    [weakself.showBrandTableView addPullToRefreshWithActionHandler:^{
            [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
                [weakself.showBrandTableView.pullToRefreshView stopAnimating];
                self.brandArray = aArray;
                unLikeDict = [NSMutableDictionary new];
                [self.showBrandTableView reloadData];
            } andFailBlock:^{
                [weakself.showBrandTableView.pullToRefreshView stopAnimating];
                [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
            } isIndex:NO];
    }];


    [weakself.showBrandTableView addInfiniteScrollingWithActionHandler:^{
        if (self.brandArray.count>0&&self.brandArray.count%20==0)
        {
                [self.attentionBrandListManage getNextAttentionBrandListSuccBlock:^(NSArray *aArray) {
                    [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
                    NSMutableArray *insertIndexPaths = [NSMutableArray new];
                    for (unsigned long i=self.brandArray.count; i<self.brandArray.count+aArray.count; i++) {
                        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                        [insertIndexPaths addObject:indexpath];
                    }
                    [self.brandArray addObjectsFromArray:aArray];
                    [self.showBrandTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                } andFailBlock:^{
                    [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
                    [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
                }
                                                                        voidBlock:^{
                                                                            [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
                                                                            [SVProgressHUD showErrorWithStatus:@"已无更多" cover:YES offsetY:kMainScreenHeight/2.0];
                                                                        } isIndex:NO];
        }
        else
        {
            [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
        }
    }];
}


#pragma mark 关注其他品牌
- (void)attentionBrand
{
    QSBrandCollectionViewController *brandCollectionVC = [[QSBrandCollectionViewController alloc] init];
    [ViewInteraction viewPushViewcontroller:brandCollectionVC];
}

#pragma mark tableView datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.brandArray.count>0?self.brandArray.count:4;
    return self.brandArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"brandCell";
    QSAttentionBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[QSAttentionBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    [cell showLike];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    QSMerchant *model = [self.brandArray objectAtIndex:indexPath.row];
    [cell setCellWithModel:model];
    cell.isfollow = YES;
    [cell.cancelBtn addTarget:self action:@selector(cancelAttention:) forControlEvents:UIControlEventTouchUpInside];
    cell.cancelBtn.tag = indexPath.row+100;
    NSArray *keyArray = [unLikeDict allKeys];
    for (int i=0; i<keyArray.count; i++)
    {
        NSString *str = [keyArray objectAtIndex:i];
        if (indexPath.row==[str intValue])
        {
            [cell showUnlike];
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSMerchant *model = [self.brandArray objectAtIndex:indexPath.row];
    QSMerchantDetailsViewController *vc = [[QSMerchantDetailsViewController alloc]
                                           initWithShopId:[model.externalShopId integerValue]];
    vc.navigationController.navigationBarHidden = NO;
    [ViewInteraction viewPushViewcontroller:vc];
}

- (void)cancelAttention:(UIButton *)aBtn
{
    deleteBrandIndex = aBtn.tag-100;
    QSAttentionBrandTableViewCell *cell = (QSAttentionBrandTableViewCell *)[self.showBrandTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:deleteBrandIndex inSection:0]];
    if (cell.isfollow==YES)
    {
        [self.alertView show];
    }
    else
    {
        [self addAttentionBrand];
    }
}

- (UIAlertView *)alertView
{
    if (!_alertView)
    {
        _alertView = [[UIAlertView alloc] initWithTitle:@"确定要取消关注吗" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        _alertView.delegate = self;
    }
    return _alertView;
}

- (void)addAttentionBrand
{
    QSMerchant *model = [self.brandArray objectAtIndex:deleteBrandIndex];
    QSAttentionBrandTableViewCell *cell = (QSAttentionBrandTableViewCell *)[self.showBrandTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:deleteBrandIndex inSection:0]];
    [unLikeDict removeObjectForKey:[NSString stringWithFormat:@"%d", deleteBrandIndex]];
    [cell.cancelBtn setImage:[UIImage imageNamed:@"QSBrandLiked"] forState:UIControlStateNormal];
    cell.isfollow = YES;
    [self.likeBrandManage likeBrand:[model.externalShopId intValue] andSuccBlock:^{
        
    } failBlock:^{
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        QSAttentionBrandTableViewCell *cell = (QSAttentionBrandTableViewCell *)[self.showBrandTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:deleteBrandIndex inSection:0]];
        [cell.cancelBtn setImage:[UIImage imageNamed:@"QSBrandUnlike"] forState:UIControlStateNormal];
        cell.isfollow = NO;
        QSMerchant *model = [self.brandArray objectAtIndex:deleteBrandIndex];
        [unLikeDict setObject:@"" forKey:[NSString stringWithFormat:@"%d", deleteBrandIndex]];
        [self.likeBrandManage unlikeBrand:[model.externalShopId intValue] andSuccBlock:^{
            
        } failBlock:^{
            
        }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
