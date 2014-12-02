//
//  QSMerchantCommendView.m
//  Quansoso
//
//  Created by qf on 14/11/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSMerchantCommendView.h"
#import "SVProgressHUD.h"
#import <TAESDK/TAESDK.h>
#import "QSItem.h"
#import "QSItemsCellTableViewCell.h"
@interface QSMerchantCommendView ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,QSItemsCellDelegate>
@property (nonatomic,strong) NSArray *itemArray; //of item;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation QSMerchantCommendView

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items{
	if (self = [super initWithFrame:frame]) {
		[self setUI];
		_itemArray = items;
	}
	return self;
}

- (void)setUI{
	UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 60, 20)];
	titleLb.text = @"热门商品";
	titleLb.textColor = [UIColor blackColor];
	titleLb.textAlignment = NSTextAlignmentLeft;
	titleLb.font = kFont15;
	[self addSubview:titleLb];
	
//gotoShop
	UILabel *gotoShopLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
	gotoShopLb.width = [self widthOfString:@"进入店铺" withFont:kFont13];
	gotoShopLb.right = kMainScreenWidth - 10;
	gotoShopLb.text = @"进入店铺";
	gotoShopLb.textColor = [UIColor lightGrayColor];
	gotoShopLb.font = kFont13;
	[self addSubview:gotoShopLb];
	
	UIImageView *gotoShopImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 20, 20)];
	gotoShopImg.image = [UIImage imageNamed:@"QSgoMerc"];
	gotoShopImg.right = gotoShopLb.left-5;
	[self addSubview:gotoShopImg];
	
	UIButton *gotoShopBt = [[UIButton alloc] initWithFrame:CGRectMake(gotoShopImg.left, 20, gotoShopLb.right-gotoShopImg.left, 30)];
	[gotoShopBt addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchDown];
	[self addSubview:gotoShopBt];
//gotoshop end
	
//more
	UILabel *more = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
	more.width = [self widthOfString:@"更多优惠" withFont:kFont13];
	more.right = gotoShopBt.left-10;
	more.text = @"更多优惠";
	more.textColor = [UIColor lightGrayColor];
	more.font = kFont13;
	[self addSubview:more];
	
	UIImageView *moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 20, 20)];
	moreImg.image = [UIImage imageNamed:@"QSMore"];
	moreImg.right = more.left-5;
	[self addSubview:moreImg];

	UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(moreImg.left, 20, more.right - moreImg.left, 30)];
	[moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
	[self addSubview:moreButton];
//more end
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLb.bottom+5, kMainScreenWidth, self.height-titleLb.bottom+5) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.allowsSelection = NO;
	[self addSubview:_tableView];
}

- (void)gotoShop
{
	[_delegate gotoShop];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 0){
		NSString *str = [self.webSiteUrl substringFromIndex:[self.webSiteUrl rangeOfString:@"http"].location+4];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao%@",str]];
		[[UIApplication sharedApplication] openURL:url];
	}
}

- (void)more{
	[_delegate gotoMoreCard];
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return (_itemArray.count+1)/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return [QSItemsCellTableViewCell heightOfCell];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *identifier = @"QSItemsCell";
	QSItemsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[QSItemsCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		cell.delegate = self;
	}
	cell.indexOfRow = indexPath.row;
	NSInteger num = 1;
	QSItem *item1 = [[QSItem alloc] initWithDictionary:[_itemArray objectAtIndex:indexPath.row*2]];
	[cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:item1.picUrl]];
	cell.titleLb1.text = item1.title;
	cell.priceLb1.text = [NSString stringWithFormat:@"¥%@元",item1.price];
	if (_itemArray.count > indexPath.row*2+1) {
		num = 2;
		QSItem *item2 = [[QSItem alloc] initWithDictionary:[_itemArray objectAtIndex:indexPath.row*2+1]];
		[cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:item2.picUrl]];
		cell.titleLb2.text = item2.title;
		cell.priceLb2.text = [NSString stringWithFormat:@"¥%@元",item2.price];
	}
	
	[cell showItemWith:num];
	return cell;
}

- (void)selectCellAtIndex:(NSInteger)index andRow:(NSInteger)row{
	NSInteger num = row*2+index;
	QSItem *item = [[QSItem alloc] initWithDictionary:[_itemArray objectAtIndex:num]];
	[_delegate gotoItem:item.openIid];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
