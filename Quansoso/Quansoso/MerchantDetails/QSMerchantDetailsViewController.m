//
//  QSMerchantDetailsViewController.m
//  Quansoso
//
//  Created by qf on 14/9/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSMerchantDetailsViewController.h"
#import "ResultCard.h"
#import "UIImageView+WebCache.h"
#import "QSCardTableViewCell.h"
#import "QSMerchantNetManager.h"
#import "QSMerchantDetails.h"
#import "QSMerchant.h"
#import "QSCards.h"
#import "QSCardDetailsViewController.h"
//#import "QSCardDetailsViewController.h"
@interface QSMerchantDetailsViewController (){
	double _topId;
}
//data
@property (nonatomic,strong) QSMerchantDetails *merchantDetails;
@property (nonatomic,strong) QSMerchant *merchant;
//UI
@property (nonatomic,strong) UIImageView *logoView;
@property (nonatomic,strong) UITextView *introduceText;
@property (nonatomic,strong) UITableView *cardTable;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *likeBt;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@end

@implementation QSMerchantDetailsViewController

- (void)setMerchantData:(NSDictionary *)dic{
	_merchantDetails = [QSMerchantDetails modelObjectWithDictionary:dic];
	_merchant = _merchantDetails.merchant;
}

- (void)setUI{
	self.navigationItem.title = _merchant.name;
	self.view.backgroundColor = [UIColor whiteColor];
	
	_logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 45)];
	_logoView.center = CGPointMake(self.view.center.x, 30);
	[_logoView setImageWithURL:[NSURL URLWithString:_merchant.picUrl]];
	_logoView.layer.borderWidth = 1;
	_logoView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	
	_likeBt = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 50, _logoView.top + 5 , 33, 33)];
	[_likeBt setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
	[_likeBt addTarget:self action:@selector(likeMerchant) forControlEvents:UIControlEventTouchDown];
	
	_introduceText = [[UITextView alloc] initWithFrame:CGRectMake(10, _logoView.bottom + 5, kMainScreenWidth - 10 , 54)];
	_introduceText.editable = NO;
	_introduceText.text = [NSString stringWithFormat:@"品牌介绍:\n  %@",	_merchant.merchantDescription];
	_introduceText.font = kFont13;
	_introduceText.textColor = [UIColor lightGrayColor];
	
	UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _introduceText.top - 1, kMainScreenWidth, 1)];
	line.backgroundColor = [UIColor lightGrayColor];
	
	UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _introduceText.bottom + 1, kMainScreenWidth , 1)];
	line2.backgroundColor = [UIColor lightGrayColor];
	
	
	_cardTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _introduceText.bottom+5, kMainScreenWidth, self.view.frame.size.height - _introduceText.bottom - 5) style:UITableViewStylePlain];
	_cardTable.delegate = self;
	_cardTable.dataSource = self;
	_cardTable.backgroundColor = [UIColor whiteColor];
	
	[self.view addSubview:_logoView];
	[self.view addSubview:_likeBt];
	[self.view addSubview:line];
	[self.view addSubview:_introduceText];
	[self.view addSubview:line2];
	[self.view addSubview:_cardTable];
}

- (void)likeMerchant{
	MLOG(@"like");
}

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview detegate and datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 90;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 1;  //用来消除多余的分割线
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	QSCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardCell"];
	if (!cell) {
		cell = [[QSCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardCell"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	QSCards *card = [_merchantDetails.cards objectAtIndex:indexPath.row];
	[cell.contentLabel setNumberOfLines:2];
	cell.contentLabel.font = kFont12;
	cell.contentLabel.text = [NSString stringWithFormat:@"%@\n 截止%@",card.name,card.endProperty];
	[cell.iconView setImageWithURL:[NSURL URLWithString:card.picUrl]];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (_merchantDetails.cards.count == 0) {
		tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		if (!_tipLabel) {
			_tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.left + 20, tableView.top + 20, tableView.width - 40, 44)];
			_tipLabel.textColor = [UIColor lightGrayColor];
			_tipLabel.text = @"该商家暂无优惠券";
			_tipLabel.font = kFont13;
		}
		[self.view addSubview:_tipLabel];
	}else{
		tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		if ([_tipLabel superview]) {
			[_tipLabel removeFromSuperview];
		}
	}
	return _merchantDetails.cards.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//	ResultCard *card = [_merchant.card objectAtIndex:indexPath.row];
//	QSCardDetailsViewController *cdvc = [[QSCardDetailsViewController alloc] initWithCard:card];
//	[self.navigationController pushViewController:cdvc animated:YES];
	QSCards *card = [_merchantDetails.cards objectAtIndex:indexPath.row];
	QSCardDetailsViewController *cdVC = [[QSCardDetailsViewController alloc] initWithCard:card];
	[self.navigationController pushViewController:cdVC animated:YES];

}
#pragma mark - view life

- (instancetype)initWithTopId:(double)topid{
	if (self = [super init]) {
		_topId = topid;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	_activityView.frame = CGRectMake(0, 0, 20, 20);
	_activityView.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
	[self.view addSubview:_activityView];
	[_activityView startAnimating];
	QSMerchantNetManager *netManager = [[QSMerchantNetManager alloc] init];
	__weak QSMerchantDetailsViewController *weakSelf = self;
	[netManager getMerchantWithTopID:_topId success:^(NSDictionary *successDict) {
		[weakSelf setMerchantData:successDict];
		[weakSelf setUI];
		[_activityView stopAnimating];
	} failure:^{
		
	}];
	
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
