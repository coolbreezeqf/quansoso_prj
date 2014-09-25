//
//  QSSearchResultView.m
//  Quansoso
//
//  Created by qf on 14/9/22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchResultView.h"

@interface QSSearchResultView()


@end

@implementation QSSearchResultView

- (instancetype)initWithFrame:(CGRect)frame andResult:(NSArray *)resultArray{
	if (self = [super initWithFrame:frame]) {
		[self initResultView];
		_searchResult = [[NSArray alloc] initWithArray:resultArray];
	}
	return self;
}

- (void)initResultView{
	_tableview = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
	_tableview.delegate = self;
	_tableview.dataSource = self;
	_tableview.backgroundColor = [UIColor whiteColor];
	_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self addSubview:_tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
	}
	return cell;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
