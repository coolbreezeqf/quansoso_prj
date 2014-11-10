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
#import "QSBrandBtn.h"
#import "QSMerchant.h"
#import "UIImageView+WebCache.h"

//#define brandWidth 80;
//#define brandHeight 80;
@interface QSBrandCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *headerView;
    UIButton *attentionBtn;
    int lines;
    CGFloat interval;
    CGFloat brandWidth;
    CGFloat brandHeight;
}
@property(nonatomic ,strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic ,strong) QSBrandListManage *brandListManage;
@property(nonatomic, strong) NSMutableArray *brandArray;
@end

@implementation QSBrandCollectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (instancetype)init
{
    self = [super init];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    brandWidth = kMainScreenWidth/3;
    brandHeight = brandWidth/0.85;
    interval = 1;
    MLOG(@"%f %f", kMainScreenHeight-66, interval+brandHeight);
//    lines = (kMainScreenHeight-66)/(interval+brandHeight);
    if (kMainScreenHeight>500) {
        lines=4;
    }
    else
    {
        lines=3;
    }
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 8, 16)];
    [backBtn setImage:[UIImage imageNamed:@"QSBackItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-85, 8, 80, 24)];
    [attentionBtn addTarget:self action:@selector(payAttention) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn setImage:[UIImage imageNamed:@"QSLikeBrand"] forState:UIControlStateNormal];
//    [self.navigationController.navigationBar addSubview:attentionBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:attentionBtn];
    
    self.showBrandTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.showBrandTableView.delegate = self;
    self.showBrandTableView.dataSource = self;
    self.showBrandTableView.allowsSelection = NO;
    self.showBrandTableView.tableFooterView = [UIView new];
    self.showBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.showBrandTableView.tableHeaderView = headerView;
    [self addTableViewTrag];
    [self.view addSubview:self.showBrandTableView];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                  initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2-40, 40, 40)];
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView.color = [UIColor blackColor];
    [self.view addSubview:self.activityIndicatorView];
    
#pragma mark 网络请求
    [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
        [self.activityIndicatorView stopAnimating];
        self.brandArray = aArray;
        [self.showBrandTableView reloadData];
    } andFailBlock:^{
        
    }];
}

- (void)back
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
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

- (NSMutableArray *)brandArray
{
    if (!_brandArray) {
        _brandArray = [[NSMutableArray alloc] init];
    }
    return _brandArray;
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
            [self.brandListManage getBrandListPageSize:lines*3 andSuccBlock:^(NSMutableArray *aArray) {
                self.brandArray = aArray;
                [self.showBrandTableView reloadData];
            } andFailBlock:^{
                
            }];
            [self.showBrandTableView reloadData];
        });
    }];
    
    [weakself.showBrandTableView addInfiniteScrollingWithActionHandler:^{
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [weakself.showBrandTableView.infiniteScrollingView stopAnimating];
            [self.brandListManage getNextBrandListSuccBlock:^(NSArray *aArray) {
                [self.brandArray addObjectsFromArray:aArray];
                [self.showBrandTableView reloadData];
            } andFailBlock:^{
                
            }];
            });
    }];
    
}

#pragma mark 按钮 关注这些品牌
- (void)payAttention
{
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
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
    return self.brandArray.count/3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return brandHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"brandCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = RGBCOLOR(228, 222, 214);
    for (int i=0; i<3; i++)
    {
        QSMerchant *model = [self.brandArray objectAtIndex:indexPath.row*3+i];
        QSBrandBtn *btn = [[QSBrandBtn alloc] initWithFrame:CGRectMake(brandWidth*i, 0, brandWidth, brandHeight)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBrand:)];
        [btn addGestureRecognizer:tapGesture];
        btn.tag = 100+indexPath.row*3+i+1;
        [btn.brandImgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@""]];
        [cell addSubview:btn];
    }
    return cell;
}

#pragma mark 按钮事件
- (void)chooseBrand:(UITapGestureRecognizer *)aGestureRecognizer
{
    QSBrandBtn *aBtn = (QSBrandBtn *)aGestureRecognizer.view;
    if (aBtn.tag>=100)
    {
        [aBtn.brandLikeView setImage:[UIImage imageNamed:@"QSBrandLiked"]];
        aBtn.tag -= 100;
    }
    else
    {
        [aBtn.brandLikeView setImage:[UIImage imageNamed:@"QSBrandUnlike"]];
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
