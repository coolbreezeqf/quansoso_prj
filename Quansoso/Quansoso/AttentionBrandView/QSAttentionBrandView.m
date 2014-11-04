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
    
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.showBrandTableView];
    
    [self addTableViewTrag];
    
#pragma mark 网络请求
    [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^{
        
    } andFailBlock:^{
        
    }];
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
    topview.backgroundColor = [UIColor whiteColor];
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
    topLineView.backgroundColor = [UIColor greenColor];
    [topview addSubview:topLineView];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor blackColor];
    [topview addSubview:bottomLineView];
    UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-15, 5, 31, 28)];
    [attentionBtn setImage:[UIImage imageNamed:@"QSLikeBrandImg"] forState:UIControlStateNormal];
    [attentionBtn addTarget:self action:@selector(attentionBrand) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:attentionBtn];

    return topview;
}

- (QSAttentionBrandListManage *)attentionBrandListManage
{
    if (!_attentionBrandListManage)
    {
        _attentionBrandListManage = [[QSAttentionBrandListManage alloc] init];
    }
    return _attentionBrandListManage;
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
            [self.attentionBrandListManage getFirstAttentionBrandListSuccBlock:^{
                [self.showBrandTableView reloadData];
            } andFailBlock:^{
                
            }];
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
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSAttentionBrandTableViewCell *cell = [[QSAttentionBrandTableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell.cancelBtn addTarget:self action:@selector(cancelAttention:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLOG(@"%d", indexPath.row);
}

- (void)cancelAttention:(UIButton *)aBtn
{
    if ([aBtn.titleLabel.text isEqualToString:@"取消关注"])
    {
        [self.alertView show];
        self.cellBolck = ^(void)
        {
            [aBtn setTitle:@"添加关注" forState:UIControlStateNormal];
        };
    }
    else
    {
        [aBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    }
}

- (UIAlertView *)alertView
{
    if (!_alertView)
    {
        _alertView = [[UIAlertView alloc] initWithTitle:@"确定要取消关注吗" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        _alertView.delegate = self;
    }
    return _alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        self.cellBolck();
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
