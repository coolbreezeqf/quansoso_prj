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

@implementation QSAttentionBrandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
    UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-110, 5, 100, 30)];
    [attentionBtn setTitle:@"关注其他品牌" forState:UIControlStateNormal];
    [attentionBtn addTarget:self action:@selector(attentionBrand) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = kFont14;
    [attentionBtn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [attentionBtn.layer setBorderWidth:0.5];
    [attentionBtn.layer setCornerRadius:5];
    [topview addSubview:attentionBtn];
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showBrandTableView.tableHeaderView = topview;
    [self addSubview:self.showBrandTableView];
    
    [self addTableViewTrag];
    
    return self;
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
            
        });
    }];
    
//    if (btnCount == 15)
//    {
//        [weakself.showQuanTableView addInfiniteScrollingWithActionHandler:^{
//            int64_t delayInSeconds = 2.0;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^{
//                [weakself.showQuanTableView.infiniteScrollingView stopAnimating];
//                [self.attentionBrandListManage getNextAttentionBrandListSuccBlock:^{
//                    
//                }];
//            });
//        }];
//    }
    
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSAttentionBrandTableViewCell *cell = [[QSAttentionBrandTableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
