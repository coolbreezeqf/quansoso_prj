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

@implementation QSAttentionBrandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.brandArray = [NSMutableArray new];
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    topview.backgroundColor = [UIColor whiteColor];
    UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-40, 15, 100, 30)];
    [attentionBtn setImage:[UIImage imageNamed:@"QSLikeBrand"] forState:UIControlStateNormal];
    [attentionBtn addTarget:self action:@selector(attentionBrand) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:attentionBtn];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [topview addSubview:bottomLineView];
    [self addSubview:topview];
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight-60-62)];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.showBrandTableView];
    
    [self addTableViewTrag];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                  initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2, 40, 40)];
    self.activityIndicatorView.color = [UIColor blackColor];
    [self.activityIndicatorView startAnimating];
    [self.showBrandTableView addSubview:self.activityIndicatorView];
    
#pragma mark 网络请求
    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
        self.brandArray = [aArray mutableCopy];
        if (self.brandArray.count==0) {
            [self addSubview:self.failView];
        }
        [self.activityIndicatorView stopAnimating];
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        [self addSubview:self.failView];
    }];
    return self;
}

- (UIView *)failView
{
    if (!_failView) {
        _failView = [[UIView alloc] initWithFrame:self.bounds];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-60, kMainScreenHeight/2-60, 120, 20)];
        label.text = @"暂无数据";
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
    [self.activityIndicatorView startAnimating];
    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
        self.brandArray = [aArray mutableCopy];
        if (self.brandArray.count==0) {
            [self addSubview:self.failView];
        }
        [self.activityIndicatorView stopAnimating];
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        [self addSubview:self.failView];
    }];
}

- (QSAttentionBrandListManage *)attentionBrandListManage
{
    if (!_attentionBrandListManage)
    {
        _attentionBrandListManage = [[QSAttentionBrandListManage alloc] init];
    }
    return _attentionBrandListManage;
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSAttentionBrandView *weakself = self;
    [weakself.showBrandTableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showBrandTableView.pullToRefreshView stopAnimating];
            [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
                [self.showBrandTableView reloadData];
            } andFailBlock:^{
                
            }];
             });
    }];


    [weakself.showBrandTableView addInfiniteScrollingWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
            [self.attentionBrandListManage getNextAttentionBrandListSuccBlock:^(NSArray *aArray) {
                NSMutableArray *insertIndexPaths = [NSMutableArray new];
                for (unsigned long i=self.brandArray.count; i<self.brandArray.count+aArray.count; i++) {
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
//    if (self.brandArray.count>0) {
        NSString *cellIdentifer = @"brandCell";
        QSAttentionBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell) {
            cell = [[QSAttentionBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        QSMerchant *model = [self.brandArray objectAtIndex:indexPath.row];
        [cell setCellWithModel:model];
        //    [cell.cancelBtn addTarget:self action:@selector(cancelAttention:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
//    }
//    else
//    {
//        UITableViewCell *cell = [[UITableViewCell alloc] init];
//        if (indexPath.row==3) {
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-50, 20, 100, 20)];
//            label.text = @"暂无数据";
//            label.font = kFont14;
//            label.textColor = [UIColor lightGrayColor];
//            label.textAlignment = NSTextAlignmentCenter;
//            [cell addSubview:label];
//        }
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        cell.backgroundColor = [UIColor clearColor];
//        return cell;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSMerchant *model = [self.brandArray objectAtIndex:indexPath.row];
    QSMerchantDetailsViewController *vc = [[QSMerchantDetailsViewController alloc]
                                           initWithTopId:[model.externalShopId doubleValue]];
    vc.navigationController.navigationBarHidden = NO;
    [ViewInteraction viewPushViewcontroller:vc];
}

- (void)cancelAttention:(UIButton *)aBtn
{
    if ([aBtn.titleLabel.text isEqualToString:@"取消关注"])
    {
        [self.alertView show];
        self.cellBolck = ^(void)
        {
            [aBtn setTitle:@"添加关注" forState:UIControlStateNormal];
        };
    }
    else
    {
        [aBtn setTitle:@"取消关注" forState:UIControlStateNormal];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        self.cellBolck();
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
