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
#import "QSMerchant.h"

#define times kMainScreenWidth/320
@implementation QSFirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.brandArray = [NSMutableArray new];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth/720*478)];
    [headView setImage:[UIImage imageNamed:@"QSIndexTopView"]];
    headView.userInteractionEnabled = YES;
    
    self.tapSearchGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UITapGestureRecognizer *tapSGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UIButton *rightMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(headView.right-45, 40, 36, 24)];
    [rightMoreBtn setImage:[UIImage imageNamed:@"QSRightMoreBtn"] forState:UIControlStateNormal];
    [rightMoreBtn addTarget:self action:@selector(rightMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightMoreBtn];
    
    self.imagebrand = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-185*times)/2, 80, 185*times, 56*times)];
    [self.imagebrand setImage:[UIImage imageNamed:@"QSquansosoImg"]];
    self.imagebrand.userInteractionEnabled = YES;
    [headView addSubview:self.imagebrand];
    
    self.viewSearch = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-240*times)/2, ViewBottom(_imagebrand)+20, 240*times, 30*times)];
    self.viewSearch.userInteractionEnabled = YES;
    [self.viewSearch setImage:[UIImage imageNamed:@"QSSearchBack"]];
    
    UILabel *defalutLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, (self.viewSearch.bottom-self.viewSearch.top)/2-10, 150, 20)];
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
    self.activityDayRecommendView.color = [UIColor blackColor];
    [self.activityDayRecommendView startAnimating];
    [self addSubview:self.activityDayRecommendView];
    
    [self addTableViewTrag];
    
#pragma mark 网络请求
    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
        self.brandArray = aArray;
        [self.showQuanTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } andFailBlock:^{
        
    }];
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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 136*times)];
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

    [weakself.showQuanTableView addInfiniteScrollingWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
                [self.attentionBrandListManage getNextAttentionBrandListSuccBlock:^(NSArray *aArray) {
                    [self.brandArray addObjectsFromArray:aArray];
                    [self.showQuanTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
                } andFailBlock:^{
                    
                }];
        });
    }];
    
}

#pragma mark tableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    else
    {
        int btnCount = self.brandArray.count+1;
        return btnCount%3==0?btnCount/3:btnCount/3+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0) {
            return 40;
        }
        else if(indexPath.row==2)
        {
            return 30;
        }
        else
        {
            return 136*times;
        }
    }
    else
    {
        float cellHeight = 101*times;
        return self.brandArray.count>0?cellHeight:cellHeight+30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row==0)
        {
            [cell addSubview:self.labelDaily];
            [cell addSubview:self.pageControl];
        }
        else if(indexPath.row==1)
        {
            self.scrollView.contentSize = CGSizeMake(3*kMainScreenWidth, 136*times);
            CGFloat interval = 5;
            for (int i=0; i<9; i++)
            {
                float width = 105*times;
                float height = 136*times;
                QSDailyView *btn = [[QSDailyView alloc] initWithFrame:CGRectMake((interval+102*(i%3))*times+i/3*kMainScreenWidth, 0, width, height)];
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
    else
    {
        if (self.brandArray.count>0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifer"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifer"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            CGRect frame = cell.frame;
            frame.size.width = kMainScreenWidth;
            cell.frame = frame;
            int btnCount = self.brandArray.count+1;
            int j = btnCount-3*indexPath.row;
            for (int i=0; i<(j>=3?3:j%3); i++)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((11+(96+5)*i)*times, 2.5*times, 96*times, 96*times)];
                btn.tag = 100+indexPath.row*3+i;
                btn.backgroundColor = [UIColor whiteColor];
                if (i+indexPath.row*3 != btnCount-1)
                {
                    QSMerchant *model = [self.brandArray objectAtIndex:i+indexPath.row*3];
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((96/2-40)*times, (96/2-40)*times, 80*times, 80*times)];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@""]];
                    [btn addSubview:imgView];
                    [btn addTarget:self action:@selector(touchStoreButton:) forControlEvents:UIControlEventTouchUpInside];
                }
                else
                {
                    [btn addTarget:self action:@selector(touchPlusButton) forControlEvents:UIControlEventTouchUpInside];
                    [btn setImage:[UIImage imageNamed:@"QSLikeBrandImg"] forState:UIControlStateNormal];
                }

                [cell addSubview:btn];
            }
            cell.backgroundColor = [UIColor clearColor];
            return cell;

        }
        else
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            for (int i=0; i<3; i++)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((11+(96+5)*i)*times, 2.5*times, 96*times, 96*times)];
                btn.backgroundColor = [UIColor whiteColor];
                [btn setImage:[UIImage imageNamed:@"QSLikeBrandImg"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(touchPlusButton) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btn];
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11*times, 105*times, 300, 15)];
            label.font = kFont12;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = RGBCOLOR(120, 120, 120);
            label.text = @"关注品牌，随时了解最新优惠信息";
            [cell addSubview:label];
            return cell;
        }
    }
//    if (indexPath.row>=3) {
//        if (btnCount == 1)
//        {
//            
//        }
//        else
//        {
//            UITableViewCell *cell = [[UITableViewCell alloc] init];
//            CGRect frame = cell.frame;
//            frame.size.width = kMainScreenWidth;
//            cell.frame = frame;
//            int j = btnCount-3*indexPath.row;
//            for (int i=0; i<(j>=3?3:j%3); i++)
//            {
//                float temInterval = (kMainScreenWidth-300)/2;
//                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(temInterval+(96+5)*i, 2.5, 96, 96)];
//                btn.tag = 100+indexPath.row*3+i;
//                if (i+indexPath.row*3 != btnCount-1)
//                {
//                    [btn addTarget:self action:@selector(touchStoreButton:) forControlEvents:UIControlEventTouchUpInside];
//                    btn.backgroundColor = [UIColor blueColor];
//                }
//                else
//                {
//                    [btn addTarget:self action:@selector(touchPlusButton) forControlEvents:UIControlEventTouchUpInside];
//                    btn.backgroundColor = [UIColor blackColor];
//                }
//                
//                [cell addSubview:btn];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = [UIColor clearColor];
//            return cell;
//        }
//    }
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
