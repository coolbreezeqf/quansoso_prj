//
//  QSCouponView.m
//  Quansoso
//
//  Created by Johnny's on 14-9-27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCouponView.h"
#import "QSCouponTableViewCell.h"
#import "SVPullToRefresh.h"
#import "UIImageView+WebCache.h"
#import <TAESDK/TAESDK.h>

@implementation QSCouponView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
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
    [self.activityIndicatorView startAnimating];
    [self addSubview:self.activityIndicatorView];
#pragma mark 网络请求
    [self.userCouponListManage getFirstUserCouponListSuccBlock:^{
        [self.activityIndicatorView stopAnimating];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CouponCell";
    QSCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[QSCouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = RGBCOLOR(239, 235, 227);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
