//
//  QSBrandCollectionViewController.m
//  Quansoso
//
//  Created by Johnny's on 14-10-3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandCollectionViewController.h"
#import "SVPullToRefresh.h"
#import "QSBrandListManage.h"

//#define brandWidth 80;
//#define brandHeight 80;
@interface QSBrandCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *headerView;
    UIButton *attentionBtn;
    int lines;
    CGFloat interval;
    int brandWidth;
    int brandHeight;
}
@property(nonatomic ,strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic ,strong) QSBrandListManage *brandListManage;
@end

@implementation QSBrandCollectionViewController

- (instancetype)init
{
    self = [super init];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"品牌聚合";
    brandWidth = 80;
    brandHeight = 80;
    interval = (kMainScreenWidth-3*brandWidth)/4.0;
    lines = (kMainScreenHeight-66-40)/(interval+brandHeight);
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-45, 5, 90, 30)];
    [attentionBtn addTarget:self action:@selector(payAttention) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn setTitle:@"关注这些品牌" forState:UIControlStateNormal];
    attentionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    attentionBtn.titleLabel.font = kFont12;
    attentionBtn.backgroundColor = [UIColor blueColor];
    [headerView addSubview:attentionBtn];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
    topLineView.backgroundColor = [UIColor blackColor];
    [headerView addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor blackColor];
    [headerView addSubview:bottomLineView];
    
//    UIView *tableBackView = [[UIView alloc]
//                             initWithFrame:CGRectMake(5, ViewBottom(headerView)+5, kMainScreenWidth-10, kMainScreenHeight)];
//    [self.view addSubview:tableBackView];
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.allowsSelection = NO;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showBrandTableView.tableHeaderView = headerView;
    [self addTableViewTrag];
    [self.view addSubview:self.showBrandTableView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                  initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2-20, 40, 40)];
    [self.activityIndicatorView startAnimating];
    [self.view addSubview:self.activityIndicatorView];
    
#pragma mark 网络请求
    [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^{
        [self.activityIndicatorView stopAnimating];
    }];
}

#pragma mark getter
- (QSBrandListManage *)brandListManage
{
    if (!_brandListManage)
    {
        _brandListManage = [[QSBrandListManage alloc] init];
    }
    return _brandListManage;
}

#pragma mark 增加上拉下拉
- (void)addTableViewTrag
{
    __weak QSBrandCollectionViewController *weakself = self;
    [weakself.showBrandTableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showBrandTableView.pullToRefreshView stopAnimating];
            [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^{
                [self.activityIndicatorView stopAnimating];
            }];
            [self.showBrandTableView reloadData];
        });
    }];
}

#pragma mark 按钮 关注这些品牌
- (void)payAttention
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSMutableArray *array = [NSMutableArray new];
    for(int i=1; i<lines*3+1; i++)
    {
        if([self.showBrandTableView viewWithTag:i])
        {
            [array addObject:[NSString stringWithFormat:@"%d", i-1]];
        }
    }
    MLOG(@"%@", array);
}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lines;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return brandHeight+interval;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, kMainScreenWidth-10, brandHeight+interval)];
    backGroundView.backgroundColor = RGBCOLOR(246, 246, 246);
    [cell addSubview:backGroundView];
    for (int i=0; i<3; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(interval/2+5+(interval+brandWidth)*i, interval/2, brandWidth, brandHeight)];
        btn.backgroundColor = [UIColor yellowColor];
        [btn addTarget:self action:@selector(chooseBrand:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+indexPath.row*3+i+1;
        [backGroundView addSubview:btn];
    }
    return cell;
}

#pragma mark 按钮事件
- (void)chooseBrand:(UIButton *)aBtn
{
    if (aBtn.tag>=100)
    {
        aBtn.backgroundColor = [UIColor blueColor];
        aBtn.tag -= 100;
    }
    else
    {
        aBtn.backgroundColor = [UIColor yellowColor];
        aBtn.tag += 100;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
