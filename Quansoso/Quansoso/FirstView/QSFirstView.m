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
#import "QSMerchantDetailsViewController.h"
#import "QSCardDetailsViewController.h"
#import "UIImage+GIF.h"
#import "SVProgressHUD.h"
#import <TAESDK/TAESDK.h>
#import "QSAttentionBtn.h"


#define times kMainScreenWidth/320
@implementation QSFirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = RGBCOLOR(245, 240, 232);
    self.brandArray = [NSMutableArray new];
    
    if (kMainScreenWidth==320)
    {
        pageControlEndX = kMainScreenWidth-10;
    }
    else if (kMainScreenWidth==375)
    {
        pageControlEndX = kMainScreenWidth-40;
    }
    else if (kMainScreenWidth==414)
    {
        pageControlEndX = kMainScreenWidth-60;
    }
    
    UIView *stautsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 20)];
    stautsView.backgroundColor = [UIColor whiteColor];
    [self addSubview:stautsView];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth/720*478)];
    [headView setImage:[UIImage imageNamed:@"QSIndexTopView"]];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.userInteractionEnabled = YES;
    
    self.tapSearchGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UITapGestureRecognizer *tapSGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToSearchVC)];
    
    UIButton *rightMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(headView.right-45, 25, 36, 24)];
    [rightMoreBtn setImage:[UIImage imageNamed:@"QSRightMoreBtn"] forState:UIControlStateNormal];
    [rightMoreBtn addTarget:self action:@selector(rightMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightMoreBtn];
    
    self.imagebrand = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-180)/2, 80, 180, 54)];
    [self.imagebrand setImage:[UIImage imageNamed:@"QSquansosoImg"]];
    self.imagebrand.userInteractionEnabled = YES;
    [headView addSubview:self.imagebrand];
    
    self.viewSearch = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-300)/2, ViewBottom(_imagebrand)+20, 300, 35)];
    self.viewSearch.userInteractionEnabled = YES;
    [self.viewSearch setImage:[UIImage imageNamed:@"QSSearchBack"]];
    
    UILabel *defalutLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, (self.viewSearch.bottom-self.viewSearch.top)/2-10, 150, 20)];
    defalutLabel.backgroundColor = [UIColor clearColor];
    defalutLabel.font = kFont16;
    defalutLabel.text = @"搜索品牌优惠券";
    defalutLabel.textColor = RGBCOLOR(147, 192, 115);
    [self.viewSearch addSubview:defalutLabel];
    
    [headView addSubview:self.viewSearch];
    
    [self.imagebrand addGestureRecognizer:tapSGR];
    [self.viewSearch addGestureRecognizer:self.tapSearchGestureRecognizer];
    
    self.showQuanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kMainScreenWidth, kMainScreenHeight-20)];
    self.showQuanTableView.dataSource = self;
    self.showQuanTableView.delegate = self;
    self.showQuanTableView.backgroundColor = RGBCOLOR(245, 240, 232);
    self.showQuanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showQuanTableView.tableFooterView = [UIView new];
    self.showQuanTableView.tableHeaderView = headView;
    self.showQuanTableView.allowsSelection = NO;
    [self addSubview:self.showQuanTableView];
    
    [self addTableViewTrag];
                    
    [self.showQuanTableView addSubview:self.loadingImgView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:kTaeSDKInitSuccessMsg object:nil];

    return self;
}

- (void)getData
{
#pragma mark 网络请求
    if ([[TaeSession sharedInstance] isLogin])
    {
        [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
            self.brandArray = aArray;
            dailyShopIdArray = [[NSMutableArray alloc] init];
            [self.showQuanTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            if (self.loadingImgView.superview) {
                [self.loadingImgView removeFromSuperview];
            }
        } andFailBlock:^{
            if (self.loadingImgView.superview) {
                [self.loadingImgView removeFromSuperview];
            }
            [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
        } isIndex:YES];
    }
    
    [self getDayRecommends];
}


- (void)getDayRecommends
{
    [self.dayRecommendManage getDayRecommendSuccBlock:^(NSArray *dayRecomendModelArray) {
        self.dailyArray = dayRecomendModelArray;
        NSArray *indexArray = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], [NSIndexPath indexPathForRow:0 inSection:0],nil];
        [self.showQuanTableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        if (self.loadingImgView.superview) {
            [self.loadingImgView removeFromSuperview];
        }
    } andFailBlock:^{
        if (self.loadingImgView.superview) {
            [self.loadingImgView removeFromSuperview];
        }
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
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
- (UIImageView *)loadingImgView
{
    if (!_loadingImgView) {
        _loadingImgView = [[UIImageView alloc]
                           initWithFrame:CGRectMake(kMainScreenWidth/2-8, kMainScreenHeight/2-8, 16, 16)];
        [_loadingImgView setImage:[UIImage sd_animatedGIFNamed:@"loading"]];
    }
    return _loadingImgView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 136)];
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
        _labelPrivilege.backgroundColor = [UIColor clearColor];
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
        _labelDaily.backgroundColor = [UIColor clearColor];
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
	searchVC.navigationController.navigationBarHidden = NO;
    [ViewInteraction viewPushViewcontroller:searchVC];
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSFirstView *weakself = self;
    [weakself.showQuanTableView addPullToRefreshWithActionHandler:^{
            [self getDayRecommends];
            if ([[TaeSession sharedInstance] isLogin])
            {
                [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^(NSMutableArray *aArray) {
                    [weakself.showQuanTableView.pullToRefreshView stopAnimating];
                    self.brandArray = aArray;
                    [self.showQuanTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                } andFailBlock:^{
                    [weakself.showQuanTableView.pullToRefreshView stopAnimating];
                    [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
                } isIndex:YES];
            }
            else
            {
                [weakself.showQuanTableView.pullToRefreshView stopAnimating];
                self.brandArray = [NSMutableArray new];
                [SVProgressHUD showErrorWithStatus:@"你还没登陆" cover:YES offsetY:kMainScreenHeight/2.0];
            }
    }];

    [weakself.showQuanTableView addInfiniteScrollingWithActionHandler:^{
        if(self.brandArray.count>0&&self.brandArray.count%9==0)
        {
                if ([[TaeSession sharedInstance] isLogin])
                {
                    [self.attentionBrandListManage getNextAttentionBrandListSuccBlock:^(NSArray *aArray) {
                        [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
                        [self.brandArray addObjectsFromArray:aArray];
                        [self.showQuanTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                    } andFailBlock:^{
                        [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
                        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
                    } voidBlock:^{
                        [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
                        [SVProgressHUD showErrorWithStatus:@"已无更多" cover:YES offsetY:kMainScreenHeight/2.0];
                    }];
                }
                else
                {
                    [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
                    self.brandArray = [NSMutableArray new];
                    [SVProgressHUD showErrorWithStatus:@"你还没登陆" cover:YES offsetY:kMainScreenHeight/2.0];
                }
        }
        else
        {
            [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
        }
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
        if (self.brandArray.count>0) {
            int btnCount = (self.brandArray.count%3==0?self.brandArray.count/3+1:self.brandArray.count/3)*3;
            //self.brandArray.count%9==0?self.brandArray.count:self.brandArray.count+1;
            return btnCount/3;
        }
        else
        {
            return 1;
        }
        
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
            return 136;
        }
    }
    else
    {
        float cellHeight = 105;
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
        int count = self.dailyArray.count%3==0?self.dailyArray.count/3:self.dailyArray.count/3+1;
        if (indexPath.row==0)
        {
            [cell addSubview:self.labelDaily];
            [cell addSubview:self.pageControl];
            if (self.dailyArray.count>0)
            {
                self.pageControl.numberOfPages=count;
                CGRect temFrame = self.pageControl.frame;
                temFrame.size.width = 14*count;
                temFrame.origin.x = pageControlEndX-temFrame.size.width;
                self.pageControl.frame = temFrame;
            }
        }
        else if(indexPath.row==1)
        {
            self.scrollView.contentSize = CGSizeMake(count*kMainScreenWidth, 136);
            CGFloat interval = (kMainScreenWidth-310)/6;
            int btnCount = self.dailyArray.count>0?self.dailyArray.count:3;
            for (int i=0; i<btnCount; i++)
            {
                float width = 105;
                float height = 136;
                QSDailyView *btn = [[QSDailyView alloc] initWithFrame:CGRectMake((interval*2+(102+interval)*(i%3))+i/3*kMainScreenWidth, 0, width, height)];
                btn.tag = 1000+i;
                if (self.dailyArray.count>0)
                {
                    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchQuanButton:)];
                    [btn addGestureRecognizer:tapGestureRecognizer];
                    QSDayRecommends *model = [self.dailyArray objectAtIndex:i];
                    [btn setCardWithModel:model];
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
            NSMutableDictionary *dict = [[QSDataSevice sharedQSDataSevice] getDict];
            QSBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[QSBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                cell.delegate = self;
            }
            cell.row = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (int i=0; i<3; i++)
            {
                QSAttentionBtn *btn = (QSAttentionBtn *)[cell viewWithTag:i+1];
                [btn removeRedView];
                if (i+indexPath.row*3<self.brandArray.count)
                {
                    QSMerchant *model = [self.brandArray objectAtIndex:i+indexPath.row*3];
                    [btn setWithModel:model];
                    int count = [[dict objectForKey:model.externalShopId] intValue];
                    if (count && count>0)
                    {
                        [btn addRedViewWithCount:count];
                    }
                }
                else
                {
                    btn.imgView.image = [UIImage imageNamed:@"QSPlusBtn"];
                }
            }
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        else
        {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.backgroundColor = [UIColor clearColor];
            CGFloat interval = (kMainScreenWidth-298)/6;
            for (int i=0; i<3; i++)
            {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(interval*2+(96+5+interval)*i, 2.5, 96, 96)];
                btn.backgroundColor = [UIColor whiteColor];
                [btn setImage:[UIImage imageNamed:@"QSPlusBtn"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(touchPlusButton) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btn];
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(interval*2+(96+5+interval)*0, 105, 300, 15)];
            label.font = kFont12;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = RGBCOLOR(120, 120, 120);
            label.text = @"关注品牌，随时了解最新优惠信息";
            [cell addSubview:label];
            return cell;
        }
    }
    return [UITableViewCell new];
}

- (void)selectCell:(QSBrandTableViewCell *)aCell withRow:(int)aRow andIndex:(int)aIndex
{
    int index = aRow*3+aIndex;
    if (index<self.brandArray.count)
    {
        [self touchStoreButton:index andBtn:(QSAttentionBtn *)[aCell viewWithTag:aIndex+1]];
    }
    else
    {
        [self touchPlusButton];
    }
}

#pragma mark scrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currPage = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    self.pageControl.currentPage = currPage;
}

#pragma mark 优惠券按钮
- (void)touchQuanButton:(UITapGestureRecognizer *)TapGestureRecognizer
{
    QSDayRecommends *model = [self.dailyArray objectAtIndex:TapGestureRecognizer.view.tag-1000];
    int type = [model.couponType intValue];
    if (type==1)
    {
        QSCardDetailsViewController *vc = [[QSCardDetailsViewController alloc] initWithCard:model.card shopId:model.externalShopId andSellerId:model.externalId];
        vc.navigationController.navigationBarHidden = NO;
        [ViewInteraction viewPushViewcontroller:vc];
    }
    else
    {
        QSCardDetailsViewController *vc = [[QSCardDetailsViewController alloc] initWithActivity:model.activity shopId:model.externalShopId andSellerId:model.externalId];
        vc.navigationController.navigationBarHidden = NO;
        [ViewInteraction viewPushViewcontroller:vc];
    }
    
}

#pragma mark 店铺按钮
- (void)touchStoreButton:(int)aindex andBtn:(QSAttentionBtn *)aBtn
{
    QSMerchant *model = [self.brandArray objectAtIndex:aindex];
    [aBtn removeRedView];
    NSMutableDictionary *dict = [[QSDataSevice sharedQSDataSevice] getDict];
    [dict removeObjectForKey:model.externalShopId];
    [[QSDataSevice sharedQSDataSevice] saveRedDict:dict];
    QSMerchantDetailsViewController *vc = [[QSMerchantDetailsViewController alloc]
                                           initWithShopId:[model.externalShopId integerValue]];
    vc.navigationController.navigationBarHidden = NO;
    [ViewInteraction viewPushViewcontroller:vc];
}

#pragma mark 加号按钮
- (void)touchPlusButton
{
    QSBrandCollectionViewController *brandCollectionVC = [[QSBrandCollectionViewController alloc] init];
    [ViewInteraction viewPushViewcontroller:brandCollectionVC];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
