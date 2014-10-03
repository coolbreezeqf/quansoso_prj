//
//  QSBrandCollectionViewController.m
//  Quansoso
//
//  Created by Johnny's on 14-10-3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandCollectionViewController.h"
#import "SVPullToRefresh.h"

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
@end

@implementation QSBrandCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"品牌聚合";
    brandWidth = 80;
    brandHeight = 80;
    interval = (kMainScreenWidth-3*brandWidth)/4.0;
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
    attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-45, 5, 90, 30)];
    [attentionBtn addTarget:self action:@selector(payAttention) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn setTitle:@"关注这些品牌" forState:UIControlStateNormal];
    attentionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    attentionBtn.titleLabel.font = kFont12;
    attentionBtn.backgroundColor = [UIColor blueColor];
    [headerView addSubview:attentionBtn];
    [self.view addSubview:headerView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBottom(headerView)-1, kMainScreenWidth, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];
    
    lines = (kMainScreenHeight-66-headerView.frame.size.height)/(interval+brandHeight);
    UIView *tableBackView = [[UIView alloc]
                             initWithFrame:CGRectMake(5, ViewBottom(headerView)+5, kMainScreenWidth-10, kMainScreenHeight)];
    [self.view addSubview:tableBackView];
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:tableBackView.bounds];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addTableViewTrag];
    [tableBackView addSubview:self.showBrandTableView];
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
        });
    }];
}

#pragma mark 按钮 关注这些品牌
- (void)payAttention
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    cell.backgroundColor = RGBCOLOR(246, 246, 246);
    for (int i=0; i<3; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(interval/2+5+(interval+brandWidth)*i, interval/2, brandWidth, brandHeight)];
        btn.backgroundColor = [UIColor yellowColor];
        [cell addSubview:btn];
    }
    return cell;
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
