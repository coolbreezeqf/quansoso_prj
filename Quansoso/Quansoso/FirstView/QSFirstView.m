//
//  QSFirstView.m
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSFirstView.h"
#import "SVPullToRefresh.h"
#import "ViewInteraction.h"
#import "QSSearchViewController.h"

int btnCount;
@implementation QSFirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
//    btnCount = 10;
    btnCount = 1;
    
    self.headView = [[UIView alloc] init];
    
    self.tapSearchGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UITapGestureRecognizer *tapSGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    self.imagebrand = [[UIImageView alloc] initWithFrame:CGRectMake(50, 20, kMainScreenWidth-100, 100)];
    self.imagebrand.backgroundColor = [UIColor blueColor];
    self.imagebrand.userInteractionEnabled = YES;
    [self.headView addSubview:self.imagebrand];
    
    self.viewSearch = [[UIView alloc] initWithFrame:CGRectMake(30, ViewBottom(_imagebrand)+20, kMainScreenWidth-60, 40)];
    self.viewSearch.backgroundColor = [UIColor blueColor];
    self.viewSearch.userInteractionEnabled = YES;
    [self.headView addSubview:self.viewSearch];
    
    [self.imagebrand addGestureRecognizer:tapSGR];
    [self.viewSearch addGestureRecognizer:self.tapSearchGestureRecognizer];

    
//    CGRect frameRect = _viewSearch.frame;
//    UIView *frameView = [[UIView alloc] initWithFrame:frameRect] ;
//    frameView.layer.borderWidth = 1;
//    frameView.layer.borderColor = [[UIColor blackColor] CGColor];
//    [self.headView addSubview:frameView];
    
    self.labelDaily = [[UILabel alloc]
                           initWithFrame:CGRectMake(10, ViewBottom(_viewSearch)+10, 90, 20)];
    self.labelDaily.text = @"本日推荐";
    self.labelDaily.font = kFont12;
    self.labelDaily.textAlignment = NSTextAlignmentLeft;
    [self.headView addSubview:self.labelDaily];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ViewBottom(self.labelDaily)+5, kMainScreenWidth, 80)];
    self.scrollView.contentSize = CGSizeMake(2*kMainScreenWidth, 80);
    self.scrollView.pagingEnabled = YES;
    CGFloat interval = (kMainScreenWidth-240)/4;
    for (int i=0; i<6; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(interval+(interval+80)*i+interval*(i/3), 0, 80, 80)];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(touchQuanButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor blueColor];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView addSubview:btn];
    }
    [self.headView addSubview:self.scrollView];
    self.labelPrivilege = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBottom(self.scrollView)+5, 90, 20)];
    self.labelPrivilege.text = @"我关注的商家";
    self.labelPrivilege.font = kFont12;
    self.labelPrivilege.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.labelPrivilege];
    
    
    self.headView.frame = CGRectMake(0, 0, kMainScreenWidth, ViewBottom(self.labelPrivilege)+5);
    
    self.showQuanTableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.showQuanTableView.dataSource = self;
    self.showQuanTableView.delegate = self;
    self.showQuanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showQuanTableView.tableFooterView = [UIView new];
    self.showQuanTableView.tableHeaderView = self.headView;
    [self addSubview:self.showQuanTableView];
    
    [self addTableViewTrag];
    
    return self;
}

#pragma mark 跳转到搜索页面
- (void)pushToSearchVC
{
    QSSearchViewController *searchVC = [[QSSearchViewController alloc] init];
    [ViewInteraction viewPushViewcontroller:searchVC];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSFirstView *weakself = self;
    [weakself.showQuanTableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showQuanTableView.pullToRefreshView stopAnimating];
        });
    }];
    
    if (btnCount == 15)
    {
        [weakself.showQuanTableView addInfiniteScrollingWithActionHandler:^{
            int64_t delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
            });
        }];
    }
    
}

#pragma mark tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (btnCount%3 == 0)
    {
        return btnCount/3;
    }
    return btnCount/3+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (btnCount == 1)
    {
        float temInterval = (kMainScreenWidth-240)/4;
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        UILabel *interestLabel = [[UILabel alloc] initWithFrame:CGRectMake(temInterval, 5, 160+temInterval, 80)];
        interestLabel.text = @"你想要实时了解品牌最优惠信息吗？赶快关注您喜欢的品牌吧!";
        interestLabel.numberOfLines = 0;
        [cell addSubview:interestLabel];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(160+temInterval*3, 5, 80, 80)];
        [btn addTarget:self action:@selector(touchPlusButton) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor blackColor];
        [cell addSubview:btn];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        CGRect frame = cell.frame;
        frame.size.width = kMainScreenWidth;
        cell.frame = frame;
        int j = btnCount-3*indexPath.row;
        for (int i=0; i<(j>=3?3:j%3); i++)
        {
            float temInterval = (kMainScreenWidth-240)/4;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(temInterval+(temInterval+80)*i, 5, 80, 80)];
            btn.tag = 100+indexPath.row*3+i;
            if (i+indexPath.row*3 != btnCount-1)
            {
                [btn addTarget:self action:@selector(touchStoreButton:) forControlEvents:UIControlEventTouchUpInside];
                btn.backgroundColor = [UIColor blueColor];
            }
            else
            {
                [btn addTarget:self action:@selector(touchPlusButton) forControlEvents:UIControlEventTouchUpInside];
                btn.backgroundColor = [UIColor blackColor];
            }
            
            [cell addSubview:btn];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


#pragma mark 优惠券按钮
- (void)touchQuanButton:(UIButton *)aBtn
{
    NSLog(@"%d", aBtn.tag);
}

#pragma mark 店铺按钮
- (void)touchStoreButton:(UIButton *)aBtn
{
    NSLog(@"%d", aBtn.tag);
}

#pragma mark 加号按钮
- (void)touchPlusButton
{
    NSLog(@"ok");
}


@end
