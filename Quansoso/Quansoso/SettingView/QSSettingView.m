//
//  QSSettingView.m
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSettingView.h"

@interface QSSettingView (){
	NSArray *titles;
}

@end

@implementation QSSettingView

- (void)pushIntroduce{

}

- (void)attentionWeibo{
	
}

- (void)feedback{
	
}

- (void)aboutMe{
	
}

- (void)share{
	
}

- (void)cleanCache{
	
}

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = RGBCOLOR(242, 239, 233);
		titles = @[@"优惠消息推送",@"关注券搜搜微博",@"意见反馈",@"分享app",@"关于我们",@"清楚缓存"];
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kMainScreenWidth, 44*6) style:UITableViewStylePlain];
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		[self addSubview:_tableView];
	}
	return self;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//	return titles.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell;
//	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(10, 0, kMainScreenWidth - 100, 44)];
//	cell.textLabel.text = [titles objectAtIndex:indexPath.row];
	switch (indexPath.row) {
		case 0:{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textLabel.text = [titles objectAtIndex:indexPath.row];
		}
			break;
		case 1:{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textLabel.text = [titles objectAtIndex:indexPath.row];
			cell.detailTextLabel.text = @"每月有抽奖";
			cell.detailTextLabel.textColor = [UIColor lightGrayColor];
		}
			break;
		case 2:
		{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.text = [titles objectAtIndex:indexPath.row];
		cell.detailTextLabel.text = @"每月有抽奖";
		}
			break;
		case 3:
		{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.text = [titles objectAtIndex:indexPath.row];
		cell.detailTextLabel.text = @"每月有抽奖";
		}
			break;
		case 4:
		{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.text = [titles objectAtIndex:indexPath.row];
		}			break;
		case 5:
		{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.text = [titles objectAtIndex:indexPath.row];
		}			break;
		default:
			break;
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.row) {
		case 1:
			[self attentionWeibo];
			break;
		case 2:
			[self feedback];
			break;
		case 3:
			[self share];
			break;
		case 4:
			[self aboutMe];
			break;
		case 5:
			[self cleanCache];
			break;
		default:
			break;
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
