//
//  QSSearchView.m
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchView.h"
#import "QSSearchResultView.h"
#import "QSSearchNetManager.h"
#import "SVPullToRefresh.h"
#define kPageSize 5
@interface QSSearchView (){
	NSInteger currentPage;
	NSInteger totalPage;
	NSInteger pageSize;
	NSInteger totalCount;
	NSString *currentText;

}

@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation QSSearchView

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		currentPage = 0;
		pageSize = 5;
		totalPage = NSIntegerMax;
		_searchResult = [[NSMutableArray alloc] initWithCapacity:42];
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64) style:UITableViewStylePlain];
		
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		__weak QSSearchView *weakSelf = self;
		[_tableView addInfiniteScrollingWithActionHandler:^{
//			[weakSelf.tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
			[weakSelf addSearchData];
		}];
		[_tableView addPullToRefreshWithActionHandler:^{
			[weakSelf refreshData];
//			[weakSelf.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
		}];
		[self addSubview:_tableView];
		[self addSubview:self.activityView];
	}
	return self;
}

- (void)addSearchData{
	int64_t delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		//开始更新
		[_tableView beginUpdates];
		
		//请求并添加数据
		NSDictionary *dic = @{@"pageSize":@(pageSize),
							  @"keywords":currentText,
							  @"currentPage":@(currentPage + 1)};
		__weak QSSearchView *weakSelf = self;
		[QSSearchNetManager searchContent:dic success:^(NSDictionary *successDict) {
			[weakSelf searchEndAddContentUse:successDict];
		} failure:^{
			
		}];
	
		//结束更新
		[_tableView endUpdates];
		
		//停止菊花
		[_tableView.infiniteScrollingView stopAnimating];
	});

}

- (void)refreshData{
	int64_t delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		//开始更新
		[_tableView beginUpdates];
		
		//请求并更新数据
		NSDictionary *dic = @{@"pageSize":@(pageSize),
							  @"keywords":currentText,
							  @"currentPage":@1};
		__weak QSSearchView *weakSelf = self;
		[QSSearchNetManager searchContent:dic success:^(NSDictionary *successDict) {
			[weakSelf searchEndAddContentUse:successDict];
		} failure:^{
			
		}];
		//结束更新
		[_tableView endUpdates];
		
		//停止菊花
		[_tableView.pullToRefreshView stopAnimating];
	});
	
}

- (void)searchContent:(NSString *)content{
	[_activityView startAnimating];
	currentText = content;
	NSDictionary *dic = @{@"keywords":content,
						  @"pageSize":@(pageSize),
						  @"currentPage":@1};
	__weak QSSearchView *weakSelf = self;
	[QSSearchNetManager searchContent:dic success:^(NSDictionary *successDict) {
		[weakSelf searchEndAddContentUse:successDict];
		[_activityView stopAnimating];
	}
	failure:^{

	}];
}

- (void)searchEndAddContentUse:(NSDictionary* )result{
	totalPage = [[result objectForKey:@"totalPage"] integerValue];
	totalCount = [[result objectForKey:@"totalCount"] integerValue];
	currentPage = [[result objectForKey:@"currentPage"] integerValue];
	if (currentPage == 1) {
		[_searchResult removeAllObjects];
	}
	NSArray *arr = [result objectForKey:@"results"];
	if (arr) {
		[_searchResult addObjectsFromArray:arr];
	}
	[_tableView reloadData];
}

- (UILabel *)tipLabel{
	if (!_tipLabel) {
		_tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
		_tipLabel.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
		_tipLabel.font = kFont13;
		_tipLabel.textColor = [UIColor lightGrayColor];
		_tipLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _tipLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (currentPage == 0) {
		self.tipLabel.text = @"提示可以搜索的内容";
		[self addSubview:_tipLabel];
	}else if(_searchResult.count == 0){
		self.tipLabel.text = @"没有搜索到东西";
		if (![_tipLabel superview]) {
			[self addSubview:_tipLabel];
		}
	}else{ // _searchResult != nil and count>0
		[self.tipLabel removeFromSuperview];
	}
	return _searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
	}
	cell.textLabel.text = [[_searchResult objectAtIndex:indexPath.row] objectForKey:@"name"];
	return cell;
	
}

- (UIActivityIndicatorView *)activityView{
	if (!_activityView) {
		_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityView.frame = CGRectMake(0, 0, 20, 20);
		_activityView.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
	}
	return _activityView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
