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
    
    self.viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 190)];
    
    self.imgViewUserHead = [[UIImageView alloc]
                            initWithFrame:CGRectMake(kMainScreenWidth/2-30, 20, 60, 60)];
    self.imgViewUserHead.backgroundColor = [UIColor blueColor];
    [self.imgViewUserHead sd_setImageWithURL:[NSURL URLWithString:[[TaeSession sharedInstance] getUser].iconUrl]
                        placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    [self.viewHead addSubview:self.imgViewUserHead];
    
    self.labelStore = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBottom(self.imgViewUserHead)+10, kMainScreenWidth, 20)];
    self.labelStore.text = [[TaeSession sharedInstance] getUser].nick;
    self.labelStore.font = kFont16;
    self.labelStore.textAlignment = NSTextAlignmentCenter;
    [self.viewHead addSubview:self.labelStore];
    
    self.couponLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBottom(self.imgViewUserHead)+40, kMainScreenWidth, 40)];
    self.couponLabel.backgroundColor = [UIColor blueColor];
    self.couponLabel.text = @"我的优惠券";
    self.couponLabel.textAlignment = NSTextAlignmentCenter;
    [self.viewHead addSubview:self.couponLabel];
    
    self.tableViewShow = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-ViewBottom(self.viewHead))];
    self.tableViewShow.delegate = self;
    self.tableViewShow.dataSource = self;
    self.tableViewShow.tableFooterView = [[UIView alloc] init];
    self.tableViewShow.tableHeaderView = self.viewHead;
    [self addTableViewTrag];
    [self addSubview:self.tableViewShow];
    return self;
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
        });
    }];
    
    //    [weakself.tableViewShow addInfiniteScrollingWithActionHandler:^{
    //        int64_t delayInSeconds = 2.0;
    //        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //        dispatch_after(popTime, dispatch_get_main_queue(), ^{
    //            [weakself.tableViewShow.infiniteScrollingView stopAnimating];
    //        });
    //    }];
    
}

#pragma mark tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSCouponTableViewCell *cell = [[QSCouponTableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
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
