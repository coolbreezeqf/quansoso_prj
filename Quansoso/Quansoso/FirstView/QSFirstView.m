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
#import "QSBrandCollectionViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "QSDayRecommends.h"
#import "QSDailyView.h"
#import "QSCards.h"

int btnCount; //关注的商家数量 包括加号按钮
@implementation QSFirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
//    btnCount = 10;
    btnCount = 1;
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth/720*478)];
    [headView setImage:[UIImage imageNamed:@"QSIndexTopView"]];
    headView.userInteractionEnabled = YES;
    
    self.tapSearchGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UITapGestureRecognizer *tapSGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UIButton *rightMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(headView.right-45, 40, 36, 24)];
    [rightMoreBtn setImage:[UIImage imageNamed:@"QSRightMoreBtn"] forState:UIControlStateNormal];
    [rightMoreBtn addTarget:self action:@selector(rightMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightMoreBtn];
    
    self.imagebrand = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-185)/2, 80, 185, 56)];
    [self.imagebrand setImage:[UIImage imageNamed:@"QSquansosoImg"]];
    self.imagebrand.userInteractionEnabled = YES;
    [headView addSubview:self.imagebrand];
    
    self.viewSearch = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-240)/2, ViewBottom(_imagebrand)+20, 240, 30)];
    self.viewSearch.userInteractionEnabled = YES;
    [self.viewSearch setImage:[UIImage imageNamed:@"QSSearchBack"]];
    
    UILabel *defalutLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 150, 20)];
    defalutLabel.font = kFont16;
    defalutLabel.text = @"搜索品牌优惠券";
    defalutLabel.textColor = RGBCOLOR(147, 192, 115);
    [self.viewSearch addSubview:defalutLabel];
    
    [headView addSubview:self.viewSearch];
    
    [self.imagebrand addGestureRecognizer:tapSGR];
    [self.viewSearch addGestureRecognizer:self.tapSearchGestureRecognizer];
    
    self.showQuanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.showQuanTableView.dataSource = self;
    self.showQuanTableView.delegate = self;
    self.showQuanTableView.backgroundColor = RGBCOLOR(245, 240, 232);
    self.showQuanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showQuanTableView.tableFooterView = [UIView new];
    self.showQuanTableView.tableHeaderView = headView;
    self.showQuanTableView.allowsSelection = NO;
    [self addSubview:self.showQuanTableView];
    
    self.activityDayRecommendView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2-20, 40, 40)];
//    self.activityDayRecommendView.backgroundColor = [UIColor blackColor];
    self.activityDayRecommendView.color = [UIColor blackColor];
    [self.activityDayRecommendView startAnimating];
    [self addSubview:self.activityDayRecommendView];
    
    [self addTableViewTrag];
    
#pragma mark 网络请求
//    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^{
//        
//    } andFailBlock:^{
//        
//    }];
    [self getDayRecommends];
    
    return self;
}

- (void)getDayRecommends
{
    [self.dayRecommendManage getDayRecommendSuccBlock:^(NSArray *dayRecomendModelArray) {
        self.dailyArray = dayRecomendModelArray;
        NSArray *indexArray = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil];
        [self.showQuanTableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        [self.activityDayRecommendView stopAnimating];
    } andFailBlock:^{
        
    }];
     
}

#pragma mark rightMoreBtn
- (void)touchRightMoreBtn:(void (^)(void))aBlock
{
    self.myBlock = aBlock;
}

- (void)rightMoreBtn
{
    self.myBlock();
}

#pragma mark getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 136*kMainScreenWidth/320)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        MLOG(@"%f", kMainScreenWidth);
        if (kMainScreenWidth==320)
        {
            _pageControl.frame = CGRectMake(kMainScreenWidth-50, 0, 39, 40);
        }
        else if (kMainScreenWidth==375)
        {
            _pageControl.frame = CGRectMake(kMainScreenWidth-80, 0, 39, 40);
        }
        else if (kMainScreenWidth==414)
        {
            _pageControl.frame = CGRectMake(kMainScreenWidth-100, 0, 39, 40);
        }
        _pageControl.pageIndicatorTintColor = RGBCOLOR(201, 223, 175);
        _pageControl.currentPageIndicatorTintColor = RGBCOLOR(75, 171, 14);
        _pageControl.numberOfPages = 3;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (UILabel *)labelPrivilege
{
    if (!_labelPrivilege) {
        _labelPrivilege = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 90, 20)];
        _labelPrivilege.text = @"我关注的商家";
        _labelPrivilege.textColor = RGBCOLOR(73, 167, 14);
        _labelPrivilege.font = kFont12;
        _labelPrivilege.textAlignment = NSTextAlignmentLeft;
    }
    return _labelPrivilege;
}

- (UILabel *)labelDaily
{
    if (!_labelDaily) {
        _labelDaily = [[UILabel alloc]
                        initWithFrame:CGRectMake(10, 10, 90, 20)];
        _labelDaily.text = @"本日推荐";
        _labelDaily.textColor = RGBCOLOR(73, 167, 14);
        _labelDaily.font = kFont12;
        _labelDaily.textAlignment = NSTextAlignmentLeft;
    }
    return _labelDaily;
}

- (QSAttentionBrandListManage *)attentionBrandListManage
{
    if (!_attentionBrandListManage)
    {
        _attentionBrandListManage = [[QSAttentionBrandListManage alloc] init];
    }
    return _attentionBrandListManage;
}

- (QSDayRecommendManage *)dayRecommendManage
{
    if (!_dayRecommendManage)
    {
        _dayRecommendManage = [[QSDayRecommendManage alloc] init];
    }
    return _dayRecommendManage;
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
//            [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^{
//                
//            } andFailBlock:^{
//                
//            }];
            [self getDayRecommends];
        });
    }];
    
    if (btnCount == 15)
    {
        [weakself.showQuanTableView addInfiniteScrollingWithActionHandler:^{
            int64_t delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
//                [self.attentionBrandListManage getNextAttentionBrandListSuccBlock:^{
//                    
//                } andFailBlock:^{
//                    
//                }];
            });
        }];
    }
    
}

#pragma mark tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (btnCount%3 == 0)
    {
        return btnCount/3+3;
    }
    return btnCount/3+1+3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40;
    }
    else if(indexPath.row==2)
    {
        return 30;
    }
    else if(indexPath.row==1)
    {
        return 136*kMainScreenWidth/320;
    }
    return 101;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<3) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row==0)
        {
            [cell addSubview:self.labelDaily];
            [cell addSubview:self.pageControl];
        }
        else if(indexPath.row==1)
        {
            self.scrollView.contentSize = CGSizeMake(3*kMainScreenWidth, 136*kMainScreenWidth/320);
            CGFloat interval = 5;
            for (int i=0; i<9; i++)
            {
                float width = 105*kMainScreenWidth/320;
                float height = 136*kMainScreenWidth/320;
                QSDailyView *btn = [[QSDailyView alloc] initWithFrame:CGRectMake((interval+102*(i%3))*kMainScreenWidth/320+i/3*kMainScreenWidth, 0, width, height)];
                if (self.dailyArray.count>0) {
                    QSCards *cardModel = [self.dailyArray objectAtIndex:i];
                    [btn setCardWithModel:cardModel];
                }
                [self.scrollView addSubview:btn];
            }
            [cell addSubview:self.scrollView];
        }
        else if(indexPath.row==2)
        {
            [cell addSubview:self.labelPrivilege];
        }
        return cell;
    }
    if (indexPath.row>=3) {
        if (btnCount == 1)
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            CGFloat temInterval = (kMainScreenWidth-300)/2;
            UIImageView *interestImg = [[UIImageView alloc] initWithFrame:CGRectMake(temInterval, 2.5, 197, 96)];
            [interestImg setImage:[UIImage imageNamed:@"QSTryToAttention"]];
            [cell addSubview:interestImg];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(interestImg.right+5, interestImg.top, 96, 96)];
            [btn addTarget:self action:@selector(touchPlusButton) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:@"QSPlusBtn"] forState:UIControlStateNormal];
            cell.backgroundColor = [UIColor clearColor];
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
                float temInterval = (kMainScreenWidth-300)/2;
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(temInterval+(96+5)*i, 2.5, 96, 96)];
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
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
    }
    return [UITableViewCell new];
}

#pragma mark scrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currPage = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    self.pageControl.currentPage = currPage;
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
    QSBrandCollectionViewController *brandCollectionVC = [[QSBrandCollectionViewController alloc] init];
    [ViewInteraction viewPushViewcontroller:brandCollectionVC];
}


@end
