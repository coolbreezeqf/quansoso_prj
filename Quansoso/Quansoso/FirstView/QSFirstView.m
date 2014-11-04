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

int btnCount; //关注的商家数量 包括加号按钮
@implementation QSFirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
//    btnCount = 10;
    btnCount = 1;
    
    self.headView = [[UIView alloc] init];
    
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth/720*478)];
    [backImgView setImage:[UIImage imageNamed:@"QSIndexTopView"]];
    [self.headView addSubview:backImgView];
    
    self.tapSearchGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UITapGestureRecognizer *tapSGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UIButton *rightMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(backImgView.right-30, 40, 18, 12)];
    [rightMoreBtn setImage:[UIImage imageNamed:@"QSRightMoreBtn"] forState:UIControlStateNormal];
    [backImgView addSubview:rightMoreBtn];
    
    self.imagebrand = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-185)/2, 80, 185, 56)];
    [self.imagebrand setImage:[UIImage imageNamed:@"QSquansosoImg"]];
    self.imagebrand.userInteractionEnabled = YES;
    [backImgView addSubview:self.imagebrand];
    
    self.viewSearch = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-300)/2, ViewBottom(_imagebrand)+20, 300, 35)];
    self.viewSearch.userInteractionEnabled = YES;
    [self.viewSearch setImage:[UIImage imageNamed:@"QSSearchBack"]];
    
    
    self.labelNike = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 35)];
    self.labelNike.text = @"耐克跑鞋";
    self.labelNike.font = kFont18;
    self.labelNike.textAlignment = NSTextAlignmentCenter;
    self.labelNike.textColor = [UIColor whiteColor];
    [self.viewSearch addSubview:self.labelNike];
    
    UIView *shulineView = [[UIView alloc] initWithFrame:CGRectMake(self.labelNike.right, 5, 1, 25)];
    shulineView.backgroundColor = [UIColor whiteColor];
    [self.viewSearch addSubview:shulineView];
    
    [self.headView addSubview:self.viewSearch];
    
    [self.imagebrand addGestureRecognizer:tapSGR];
    [self.viewSearch addGestureRecognizer:self.tapSearchGestureRecognizer];

    self.labelDaily = [[UILabel alloc]
                           initWithFrame:CGRectMake(10, backImgView.bottom+10, 90, 20)];
    self.labelDaily.text = @"本日推荐";
    self.labelDaily.textColor = RGBCOLOR(73, 167, 14);
    self.labelDaily.font = kFont12;
    self.labelDaily.textAlignment = NSTextAlignmentLeft;
    [self.headView addSubview:self.labelDaily];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-50, self.labelDaily.top-10, 39, 37)];
    self.pageControl.pageIndicatorTintColor = RGBCOLOR(201, 223, 175);
    self.pageControl.currentPageIndicatorTintColor = RGBCOLOR(75, 171, 14);
    self.pageControl.numberOfPages = 3;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPage = 0;
    [self.headView addSubview:self.pageControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ViewBottom(self.labelDaily)+5, kMainScreenWidth, 136)];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    CGFloat interval = (kMainScreenWidth-310)/2;
    for (int i=0; i<9; i++)
    {
        QSDailyView *btn = [[QSDailyView alloc] initWithFrame:CGRectMake(interval+102*(i%3)+i/3*kMainScreenWidth, 0, 105, 136)];
        if (i%3==1) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"50%"];
            [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(253, 82, 88) range:NSMakeRange(0, string.length)];
            btn.preferentialLabel.attributedText = string;
            btn.preferentialDetailLabel.text = @"OFF";
            btn.brandNameLabel.text = @"素缕";
        }
        if (i%3==2) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"包邮"];
            [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(26, 167, 124) range:NSMakeRange(0, string.length)];
            btn.preferentialLabel.attributedText = string;
            btn.preferentialDetailLabel.text = @"满400元";
            btn.brandNameLabel.text = @"正山堂";
        }
//        btn.tag = 10+i;
//        [btn setImage:[UIImage imageNamed:@"QSDailyBackGround"] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(touchQuanButton:) forControlEvents:UIControlEventTouchUpInside];
//        self.scrollView.showsHorizontalScrollIndicator = NO;
//        btn.userInteractionEnabled = NO;
        [self.scrollView addSubview:btn];
    }
    [self.headView addSubview:self.scrollView];
    self.labelPrivilege = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBottom(self.scrollView)+5, 90, 20)];
    self.labelPrivilege.text = @"我关注的商家";
    self.labelPrivilege.textColor = RGBCOLOR(73, 167, 14);
    self.labelPrivilege.font = kFont12;
    self.labelPrivilege.textAlignment = NSTextAlignmentLeft;
    [self.headView addSubview:self.labelPrivilege];
    
    
    self.headView.frame = CGRectMake(0, 0, kMainScreenWidth, ViewBottom(self.labelPrivilege)+5);
    self.headView.backgroundColor = RGBCOLOR(245, 240, 232);
    
    self.showQuanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.showQuanTableView.dataSource = self;
    self.showQuanTableView.delegate = self;
    self.showQuanTableView.backgroundColor = RGBCOLOR(245, 240, 232);
    self.showQuanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showQuanTableView.tableFooterView = [UIView new];
    self.showQuanTableView.tableHeaderView = self.headView;
    self.showQuanTableView.allowsSelection = NO;
    [self addSubview:self.showQuanTableView];
    
    self.activityDayRecommendView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2-20, 40, 40)];
    self.activityDayRecommendView.backgroundColor = [UIColor blackColor];
    [self.activityDayRecommendView startAnimating];
    [self addSubview:self.activityDayRecommendView];
    
    [self addTableViewTrag];
    
#pragma mark 网络请求
    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^{
        
    } andFailBlock:^{
        
    }];
    [self getDayRecommends];
    
    return self;
}

- (void)getDayRecommends
{
    [self.dayRecommendManage getDayRecommendSuccBlock:^(NSArray *dayRecomendModelArray) {
        for (int i=0; i<9; i++)
        {
            UIButton *btn = (UIButton *)[self viewWithTag:i+10];
//            QSDayRecommends *model = [dayRecomendModelArray objectAtIndex:i];
//            UIImageView *couponImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
//            [couponImgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
//            [btn addSubview:couponImgView];
//            UILabel *couponLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
//            couponLabel.text = model.name;
//            couponLabel.font = kFont12;
//            couponLabel.textAlignment = NSTextAlignmentCenter;
//            [btn addSubview:couponLabel];
            btn.userInteractionEnabled = YES;
//            [self.scrollView addSubview:btn];
        }
        int width;
        width = kMainScreenWidth*9/3;
//        if (dayRecomendModelArray.count/3 == 0)
//        {
//            width = kMainScreenWidth*dayRecomendModelArray.count/3;
//        }
//        else
//        {
//            width = kMainScreenWidth*dayRecomendModelArray.count/3+1;
//        }
        self.scrollView.contentSize = CGSizeMake(width, 80);
        [self.activityDayRecommendView stopAnimating];
    } andFailBlock:^{
        
    }];
     
}

#pragma mark getter
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
            [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^{
                
            } andFailBlock:^{
                
            }];
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
                [self.attentionBrandListManage getNextAttentionBrandListSuccBlock:^{
                    
                } andFailBlock:^{
                    
                }];
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
    return 101;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
