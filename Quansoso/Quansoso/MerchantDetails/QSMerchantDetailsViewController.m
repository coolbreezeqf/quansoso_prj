//
//  QSMerchantDetailsViewController.m
//  Quansoso
//
//  Created by yato_kami on 14/11/10.
//  Copyright (c) 2014年 taobao. All rights reserved.
//
#import "QSMerchantDetailsViewController.h"
#import "ResultCard.h"
#import "UIImageView+WebCache.h"
#import "QSCardTableViewCell.h"
#import "QSMerchantNetManager.h"
#import "QSSActivities.h"
#import "QSSMerchant.h"
#import "QSCards.h"
#import "QSCardDetailsViewController.h"
#import "QSCardCell.h"
#import "SVProgressHUD.h"
#import "QSshowMerIntrodView.h"
#import "QSLikeBrandManage.h"
//#import "QSCardDetailsViewController.h"
#define logoViewWidth 130
#define logoImgWidth 100
#define kGrayColor RGBCOLOR(242, 239, 233)
#define isTest 0
#define showMerViewHeight 100

@interface QSMerchantDetailsViewController()<UITableViewDataSource,UITableViewDelegate>
{
	NSInteger _shopId;
    CGFloat _detailMercBtnCenterX;
}
//data
@property (strong, nonatomic) QSSMerchant *merchant;
@property (strong, nonatomic) NSArray *cardsArray;
//UI
@property (nonatomic,strong) UIView *logoView;
@property (nonatomic,strong) UIView *merchantToolView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) UIView *dimView;
@property (strong, nonatomic) QSshowMerIntrodView *showMerIntrodView;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) QSLikeBrandManage *likeManager;
@property (strong, nonatomic) UIImageView *backImageView;
@end

@implementation QSMerchantDetailsViewController

#pragma mark - getter and setter

- (QSLikeBrandManage *)likeManager
{
    if (!_likeManager) {
        _likeManager = [[QSLikeBrandManage alloc] init];
    }
    return _likeManager;
}

- (UIView *)dimView
{
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight)];
        _dimView.backgroundColor = [UIColor clearColor];
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.top, kMainScreenWidth, self.tableView.height)];
        blackView.backgroundColor = RGBACOLOR(200, 200, 200, 0.7);
        [_dimView addSubview:blackView];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeDimView)];
        [_dimView addGestureRecognizer:tapRecognizer];
    }
    return _dimView;
}

- (QSshowMerIntrodView *)showMerIntrodView
{
    if (!_showMerIntrodView) {
        _showMerIntrodView = [[QSshowMerIntrodView alloc] initWithFrame:CGRectMake(0, self.tableView.top-10, kMainScreenWidth, showMerViewHeight) AngleX:_detailMercBtnCenterX angleHeight:10];
    }
    return _showMerIntrodView;
}

#pragma mark - init

- (instancetype)initWithShopId:(NSInteger)shopid{
    if (self = [super init]) {
        _shopId = shopid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
	self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"加载中...";
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame = CGRectMake(0, 0, 20, 20);
    _activityView.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    QSMerchantNetManager *netManager = [[QSMerchantNetManager alloc] init];
    __weak QSMerchantDetailsViewController *weakSelf = self;
    [netManager getMerchantWithShopID:_shopId success:^(QSSMerchant *merchant,NSArray *cardsArray) {
        [weakSelf.activityView stopAnimating];
        weakSelf.merchant = merchant;
        weakSelf.cardsArray = cardsArray;
        weakSelf.title = merchant.name;
        NSInteger categoryType = 1;
        categoryType = [weakSelf.merchant.ekpCategory integerValue];
        MLOG(@"------%@--------",weakSelf.merchant.ekpCategory);
        weakSelf.backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"QSstoreBackImg%i",categoryType]];
        weakSelf.showMerIntrodView.text = weakSelf.merchant.merchantDescription;
        [weakSelf.logoImageView sd_setImageWithURL:[NSURL URLWithString:self.merchant.picUrl] placeholderImage:[UIImage imageNamed:@"QSUserDefualt"]];
        
        [weakSelf.tableView reloadData];
    } failure:^{
        [weakSelf.activityView stopAnimating];
        weakSelf.title = @"加载失败";
        [SVProgressHUD showErrorWithStatus:@"网络请求失败,请稍后重试" cover:YES offsetY:kMainScreenHeight/2.0];
    }];
    [self setUI];
}

- (void)setUI{
    self.navigationItem.title = self.merchant.name;
	self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"QSRightViewItem2"] style:UIBarButtonItemStylePlain target:self action:@selector(privateTheMerchant)];
    
    [self creatLogoView];
    [self creatMerchantToolView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.merchantToolView.bottom, kMainScreenWidth, kMainScreenHeight-64-self.logoView.height-self.merchantToolView.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kGrayColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.tableView.rowHeight = kCellHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self.tableView registerClass:[QSCardCell class] forCellReuseIdentifier:@"CardCellIdentifier"];
}

- (void)creatLogoView
{
    //---商家logo部分view---
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 160)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:logoView.frame];

    //self.merchant.type
    //imageView.image = [UIImage imageNamed:@"QSstoreBackImg1"];
    imageView.backgroundColor = [UIColor whiteColor];
    _backImageView = imageView;
    [logoView addSubview:imageView];
    //圆形logo背景
    UIView *logoBackview = [[UIView alloc] initWithFrame:CGRectMake((kMainScreenWidth-logoViewWidth)/2.0f, (160-logoViewWidth)/2.0, logoViewWidth, logoViewWidth)];
    logoBackview.layer.cornerRadius = logoBackview.width/2.0;
    logoBackview.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
    logoBackview.clipsToBounds = YES;
    [logoView addSubview:logoBackview];
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((logoViewWidth - logoImgWidth)/2.0, (logoViewWidth - logoImgWidth)/2.0, logoImgWidth, logoImgWidth)];
    _logoImageView = logoImageView;
    logoImageView.clipsToBounds = YES;
    logoImageView.layer.cornerRadius = logoImageView.width/2.0f;
    logoImageView.backgroundColor = [UIColor whiteColor];
    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [logoBackview addSubview:logoImageView];
    [self.view addSubview:logoView];
    _logoView = logoView;
}

- (void)creatMerchantToolView
{
    //---店铺信息 功能view
    UIView *merchantToolView = [[UIView alloc] initWithFrame:CGRectMake(0, _logoView.bottom, kMainScreenWidth, 40)];
    merchantToolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:merchantToolView];
    UILabel *titileLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 30)];
    titileLable.text = @"店铺优惠";
    [merchantToolView addSubview:titileLable];
    
    UIButton *goMercButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goMercButton setFrame:CGRectMake(kMainScreenWidth-55-10, 5, 55, 30)];
    [goMercButton setTitle:@"进入店铺" forState:UIControlStateNormal];
    [goMercButton addTarget:self action:@selector(touchGoMercButton) forControlEvents:UIControlEventTouchUpInside];
    goMercButton.titleLabel.font = kFont13;
    [goMercButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //goMercButton.backgroundColor = [UIColor blackColor];
    [merchantToolView addSubview:goMercButton];
    UIImageView *mImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QSgoMerc"]];
    mImageview.frame = CGRectMake(goMercButton.left-5-20, 12, 20, 15);
    [merchantToolView addSubview:mImageview];
    
    UIButton *detailMercButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailMercButton setFrame:CGRectMake(mImageview.left-10-55, 5, 55, 30)];
    [detailMercButton addTarget:self action:@selector(touchDetailMercButton:) forControlEvents:UIControlEventTouchUpInside];
    detailMercButton.titleLabel.font = kFont13;
    [detailMercButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [detailMercButton setTitle:@"品牌介绍" forState:UIControlStateNormal];
    _detailMercBtnCenterX = detailMercButton.centerX;
    [merchantToolView addSubview:detailMercButton];
    UIImageView *dImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QSmeIntro"]];
    dImageview.frame = CGRectMake(detailMercButton.frame.origin.x-5-20, 12, 20, 15);
    [merchantToolView addSubview:dImageview];
    _merchantToolView = merchantToolView;
}



#pragma mark - tableview detegate and datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isTest) {
        return 5;
    }
    if (self.cardsArray && self.cardsArray.count) {
        return self.cardsArray.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 1;  //用来消除多余的分割线
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CardCellIdentifier";
    QSCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QSCardCell alloc] initWithReuseIdentifier:cellIdentifier];
    }
    if (indexPath.row < self.cardsArray.count) {
        QSCards *card = [[QSCards alloc] initWithDictionary:self.cardsArray[indexPath.row]];//self.cardsArray[indexPath.row];
        //MLOG(@"%@",card.denomination);
        if(!isTest)	[cell setCellUIwithCardType:card.cardType
						   denomination:card.denomination? :@""
						Money_condition:card.moneyCondition? :@""
									end:card.endProperty? :@""
						   discountRate:card.discountRate
						   outdateState:0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSCards *card = [[QSCards alloc] initWithDictionary:self.cardsArray[indexPath.row]];
    //MLOG(@"%@",card);
    QSCardDetailsViewController *dVC = [[QSCardDetailsViewController alloc] initWithCard:card];
    [self.navigationController pushViewController:dVC animated:YES];
}


#pragma mark - action
//收藏
- (void)privateTheMerchant
{
    [self.likeManager likeBrand:[self.merchant.externalShopId integerValue] andSuccBlock:^{
        [SVProgressHUD showSuccessWithStatus:@"关注成功" cover:NO offsetY:0];
    } failBlock:^{
        [SVProgressHUD showErrorWithStatus:@"关注失败" cover:NO offsetY:0];
    }];
    
}

//进入店铺
- (void)touchGoMercButton
{
    if (self.merchant.websiteUrl && self.merchant.websiteUrl.length) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.merchant.websiteUrl]];
    }
    
}
//显示店铺详情
- (void)touchDetailMercButton:(UIButton *)sender
{
    self.showMerIntrodView.height = 1;
    [self.view addSubview:self.dimView];
    [self.dimView addSubview:self.showMerIntrodView];
    [UIView animateWithDuration:0.5f animations:^{
        self.showMerIntrodView.height = showMerViewHeight;
    }];
    
}

//隐藏dimView
- (void)removeDimView
{
    [UIView animateWithDuration:0.5f animations:^{
        self.showMerIntrodView.height = 1;
    } completion:^(BOOL finished) {
        [self.showMerIntrodView removeFromSuperview];
        [self.dimView removeFromSuperview];
    }];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
