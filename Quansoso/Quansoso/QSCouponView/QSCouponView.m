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

    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                  initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2-20, 40, 40)];
    self.activityIndicatorView.color = [UIColor blackColor];
    [self.activityIndicatorView startAnimating];
    [self addSubview:self.activityIndicatorView];
#pragma mark 网络请求
//    [self.userCouponListManage getFirstUserCouponListSuccBlock:^{
//        [self.activityIndicatorView stopAnimating];
//    }];
    [self.dailyManage getDayRecommendSuccBlock:^(NSArray *dayRecomendModelArray) {
        self.dataArray = [dayRecomendModelArray mutableCopy];
        [self.activityIndicatorView stopAnimating];
        [self.tableViewShow reloadData];
    } andFailBlock:^{
        
    }];
    return self;
}

#pragma mark getter方法
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
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.tableViewShow.pullToRefreshView stopAnimating];
            [self.userCouponListManage getFirstUserCouponListSuccBlock:^{
                
            }];
        });
    }];
    
    [weakself.tableViewShow addInfiniteScrollingWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.tableViewShow.infiniteScrollingView stopAnimating];
            [self.userCouponListManage getNextUserCouponListSuccBlock:^{
                
            }];
        });
    }];
    
}

#pragma mark tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count>0?self.dataArray.count:4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count>0)
    {
        NSString *cellIdentifier = @"CouponCell";
        QSCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[QSCardCell alloc] initWithReuseIdentifier:cellIdentifier];
        }
        QSCards *cardModel = [self.dataArray objectAtIndex:indexPath.row];
        MLOG(@"%@", cardModel);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellUIwithCardType:cardModel.cardType denomination:cardModel.denomination Money_condition:cardModel.moneyCondition end:cardModel.endProperty discountRate:cardModel.discountRate outdateState:3];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        if (indexPath.row==3) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-60, 20, 120, 20)];
            label.text = @"暂无数据";
            label.textColor = [UIColor lightGrayColor];
            label.font = kFont14;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            [cell addSubview:label];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
