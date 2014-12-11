//
//  QSCouponView.m
//  Quansoso
//
//  Created by Johnny's on 14-9-27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCouponView.h"
#import "SVPullToRefresh.h"
#import "UIImageView+WebCache.h"
#import <TAESDK/TAESDK.h>
#import "QSCardCell.h"
#import "QSCards.h"
#import "SVProgressHUD.h"

@implementation QSCouponView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray new];
    
    self.tableViewShow = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableViewShow.delegate = self;
    self.tableViewShow.dataSource = self;
    self.tableViewShow.tableFooterView = [[UIView alloc] init];
    self.tableViewShow.backgroundColor = RGBCOLOR(239, 235, 227);
    self.tableViewShow.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addTableViewTrag];
    [self addSubview:self.tableViewShow];

    [self addSubview:self.loadingView];
#pragma mark 网络请求
    [self.userCouponListManage getFirstUserCouponListSuccBlock:^(NSArray *aArray) {
        self.dataArray = [aArray mutableCopy];
        if (self.dataArray.count==0) {
            [self addSubview:self.failView];
        }
        [self.loadingView removeFromSuperview];
        [self.tableViewShow reloadData];
    } andFailBlock:^{
        [self addSubview:self.failView];
        [self.loadingView removeFromSuperview];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
    }];
    return self;
}

#pragma mark getter方法
- (LoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[LoadingView alloc] initWithFrame:self.tableViewShow.bounds];
    }
    return _loadingView;
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
//    [self.activityIndicatorView startAnimating];
    [self addSubview:self.loadingView];
    [self.userCouponListManage getFirstUserCouponListSuccBlock:^(NSArray *aArray) {
        self.dataArray = [aArray mutableCopy];
        if (self.dataArray.count==0) {
            [self addSubview:self.failView];
        }
//        [self.activityIndicatorView stopAnimating];
        [self.loadingView removeFromSuperview];
        [self.tableViewShow reloadData];
    } andFailBlock:^{
        [self addSubview:self.failView];
        [self.loadingView removeFromSuperview];
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
    }];
}

- (QSUserCouponListManage *)userCouponListManage
{
    if (!_userCouponListManage)
    {
        _userCouponListManage = [[QSUserCouponListManage alloc] init];
    }
    return _userCouponListManage;
}

- (QSDayRecommendManage *)dailyManage
{
    if (!_dailyManage) {
        _dailyManage = [[QSDayRecommendManage alloc] init];
    }
    return _dailyManage;
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSCouponView *weakself = self;
    [weakself.tableViewShow addPullToRefreshWithActionHandler:^{
            [self.userCouponListManage getFirstUserCouponListSuccBlock:^(NSArray *aArray) {
                [weakself.tableViewShow.pullToRefreshView stopAnimating];
                self.dataArray = [aArray mutableCopy];
                [self.tableViewShow reloadData];
            } andFailBlock:^{
                [weakself.tableViewShow.pullToRefreshView stopAnimating];
                [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
            }];
    }];
    
    [weakself.tableViewShow addInfiniteScrollingWithActionHandler:^{
        if (self.dataArray.count>0&&self.dataArray.count%20==0) {
                [self.userCouponListManage getNextUserCouponListSuccBlock:^(NSArray *aArray) {
                    [weakself.tableViewShow.infiniteScrollingView stopAnimating];
                    NSMutableArray *insertIndexPaths = [NSMutableArray new];
                    for (unsigned long i=self.dataArray.count; i<self.dataArray.count+aArray.count; i++) {
                        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
                        [insertIndexPaths addObject:indexpath];
                    }
                    [self.dataArray addObjectsFromArray:aArray];
                    [self.tableViewShow insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                } andFailBlock:^{
                    [weakself.tableViewShow.infiniteScrollingView stopAnimating];
                    [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
                }];
        }
        else
        {
            [weakself.tableViewShow.infiniteScrollingView stopAnimating];
        }
        
    }];
    
}

#pragma mark tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count>0?self.dataArray.count:4;
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CouponCell";
    QSCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[QSCardCell alloc] initWithReuseIdentifier:cellIdentifier];
    }
    QSCards *cardModel = [self.dataArray objectAtIndex:indexPath.row];
    MLOG(@"%@", cardModel);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	NSString *endDate = cardModel.endProperty?[cardModel.endProperty substringWithRange:NSMakeRange(0, [cardModel.endProperty rangeOfString:@" "].location)]:@"";
    [cell setCellUIwithCardType:cardModel.cardType denomination:cardModel.denomination Money_condition:cardModel.moneyCondition end:endDate discountRate:cardModel.discountRate outdateState:[cardModel.status integerValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
