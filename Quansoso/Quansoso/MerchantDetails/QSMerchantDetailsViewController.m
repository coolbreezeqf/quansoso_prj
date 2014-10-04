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
#import "UILabel+dynamicSizeMe.h"
@interface QSMerchantDetailsViewController ()
//data
@property (nonatomic,strong) Result *merchant;
//UI
@property (nonatomic,strong) UIImageView *logoView;
@property (nonatomic,strong) UITextView *introduceText;
@property (nonatomic,strong) UITableView *cardTable;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIButton *likeBt;
@property (nonatomic,strong) UIButton *shareBt;
@end

@implementation QSMerchantDetailsViewController


- (void)likeMerchant{
	MLOG(@"like");
}

- (void)shareAction{
	MLOG(@"share");
}

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview detegate and datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardCell"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	ResultCard *card = [_merchant.card objectAtIndex:indexPath.row];
	cell.textLabel.text = card.name;
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (_merchant.card.count == 0) {
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
	return _merchant.card.count;
}

#pragma mark - view life
- (instancetype)initWithMerchant:(Result *)merchant{
	if (self = [super init]) {
		_merchant = merchant;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
	self.navigationItem.title = _merchant.name;
	self.view.backgroundColor = [UIColor whiteColor];
	
	_logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 45)];
	_logoView.center = CGPointMake(self.view.center.x, 50);
	[_logoView setImageWithURL:[NSURL URLWithString:_merchant.picUrl]];
	
	_likeBt = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 50, _logoView.top, 22, 22)];

	[_likeBt setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
	[_likeBt addTarget:self action:@selector(likeMerchant) forControlEvents:UIControlEventTouchDown];
	_shareBt = [[UIButton alloc] initWithFrame:CGRectMake(_likeBt.left, _likeBt.bottom + 1, 22, 22)];
	[_shareBt setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
	[_shareBt addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchDown];
	
	_introduceText = [[UITextView alloc] initWithFrame:CGRectMake(10, _logoView.bottom + 5, kMainScreenWidth - 10 , 54)];
	_introduceText.editable = NO;
	_introduceText.text = [NSString stringWithFormat:@"品牌介绍:\n  %@",_merchant.resultsDescription];
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
	[self.view addSubview:_shareBt];
	[self.view addSubview:_likeBt];
	[self.view addSubview:line];
	[self.view addSubview:_introduceText];
	[self.view addSubview:line2];
	[self.view addSubview:_cardTable];
	
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
