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

- (void)tuisong{

}

- (void)guanzhuweibo{
	
}

- (void)fankui{
	
}

- (void)fenxiang{
	
}

- (void)qingchuhuancun{
	
}

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		titles = @[@"优惠消息推送",@"关注券搜搜微博",@"意见反馈",@"分享app",@"清楚缓存"];
		_tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		[self addSubview:_tableView];
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(10, 0, kMainScreenWidth - 100, 44)];
	cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
	cell.layer.borderWidth = 1;
	cell.layer.cornerRadius = 6;
	cell.textLabel.text = [titles objectAtIndex:indexPath.section];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.section) {
		case 0:
			[self tuisong];
			break;
		case 1:
			[self guanzhuweibo];
			break;
		case 2:
			[self fankui];
			break;
		case 3:
			[self fenxiang];
			break;
		case 4:
			[self qingchuhuancun];
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
