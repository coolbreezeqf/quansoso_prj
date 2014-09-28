//
//  QSSearchViewController.m
//  Quansoso
//
//  Created by qf on 14/9/23.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchViewController.h"
#import "SVPullToRefresh.h"
#import "QSSearchHistoryView.h"
@interface QSSearchViewController (){
	NSInteger currentPage;
	NSInteger totalPage;
	NSInteger pageSize;
	NSInteger totalCount;
	NSString *currentText;
	
}

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) QSSearchHistoryView *historyTable;
@end

@implementation QSSearchViewController

- (void)showSearchBar{
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchContent)];
//	rightItem.tintColor = [UIColor whiteColor];
	rightItem.width = 44;
	self.navigationItem.rightBarButtonItem = rightItem;
	self.navigationItem.backBarButtonItem.title = @"";
	if (!_searchBar) {
		UIView *leftBarView = self.navigationItem.leftBarButtonItem.customView;
		UIBarButtonItem *rightBarButton = self.navigationItem.rightBarButtonItem;
		_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(leftBarView.width + 20,0, kMainScreenWidth - leftBarView.width - rightBarButton.width -15, 44)];
		_searchBar.backgroundColor = [UIColor clearColor];
		_searchBar.delegate = self;
		_searchBar.Placeholder = @"搜索品牌/优惠";
		_searchBar.keyboardType = UIKeyboardTypeDefault;
		[_searchBar setTintColor:[UIColor blackColor]];
		[_searchBar becomeFirstResponder];
//		[self showHistoryTable];
	}
	[self.navigationController.navigationBar addSubview:_searchBar];
}

- (void)hideSearchBar{
	[_searchBar removeFromSuperview];
	self.navigationItem.rightBarButtonItem = nil;
}

- (void)showHistoryTable{
	MLOG(@"show historyTable");
}

- (void)hideHistoryTable{
	MLOG(@"hide historyTable");
}


- (void)addSearchData{
	int64_t delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

		//请求并添加数据
		NSDictionary *dic = @{@"pageSize":@(pageSize),
							  @"keywords":currentText,
							  @"currentPage":@(currentPage + 1)};
		__weak QSSearchViewController *weakSelf = self;
		[QSSearchNetManager searchContent:dic success:^(NSDictionary *successDict) {
			[weakSelf searchEndAddContentUse:successDict];
		} failure:^{
			
		}];
		
		//停止菊花
		[_tableView.infiniteScrollingView stopAnimating];
	});
	
}

- (void)refreshData{
	int64_t delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

		//请求并更新数据
		NSDictionary *dic = @{@"pageSize":@(pageSize),
							  @"keywords":currentText,
							  @"currentPage":@1};
		__weak QSSearchViewController *weakSelf = self;
		[QSSearchNetManager searchContent:dic success:^(NSDictionary *successDict) {
			[weakSelf searchEndAddContentUse:successDict];
		} failure:^{
			
		}];

		//停止菊花
		[_tableView.pullToRefreshView stopAnimating];
	});
	
}

- (void)searchContent{
	[_activityView startAnimating];
	currentText = _searchBar.text;
	NSDictionary *dic = @{@"keywords":currentText,
						  @"pageSize":@(pageSize),
						  @"currentPage":@1};
	__weak QSSearchViewController *weakSelf = self;
	[QSSearchNetManager searchContent:dic success:^(NSDictionary *successDict) {
		[weakSelf searchEndAddContentUse:successDict];
		[_activityView stopAnimating];
	}
	failure:^{
								  
	}];
	[_searchBar resignFirstResponder];
}

- (void)searchEndAddContentUse:(NSDictionary* )result{
	totalPage = [[result objectForKey:@"totalPage"] integerValue];
	totalCount = [[result objectForKey:@"totalCount"] integerValue];
	currentPage = [[result objectForKey:@"currentPage"] integerValue];
	if (currentPage == 1) { // currentPage = 1 说明进行了新的请求 清空数组
		[_searchResult removeAllObjects];
	}
	NSInteger lastIndex = _searchResult.count;
	NSArray *arr = [result objectForKey:@"results"];
	if (arr) {
		[_searchResult addObjectsFromArray:arr];
	}
	if (currentPage == 1) {	//下拉刷新时 用插入会有问题
		[_tableView reloadData];
		return ;
	}
	NSMutableArray *insertArr = [[NSMutableArray alloc] initWithCapacity:42];
	for (int i = 0; i < arr.count; i++) {
		[insertArr addObject:[NSIndexPath indexPathForRow:lastIndex + i inSection:0]];
	}
	//开始更新
	[_tableView beginUpdates];
	[_tableView insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationFade];
	//结束更新
	[_tableView endUpdates];
}

- (UILabel *)tipLabel{
	if (!_tipLabel) {
		_tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
		_tipLabel.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
		_tipLabel.font = kFont13;
		_tipLabel.textColor = [UIColor lightGrayColor];
		_tipLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _tipLabel;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (currentPage == 0) {
		self.tipLabel.text = @"提示可以搜索的内容";
		[self.view addSubview:_tipLabel];
	}else if(_searchResult.count == 0){
		self.tipLabel.text = @"您想要的品牌还未入住券搜搜哦，\n请点击下方‘反馈’按钮，\n我们将尽快收录该品牌...";
		[self.tipLabel setNumberOfLines:3];
		if (![_tipLabel superview]) {
			[self.view addSubview:_tipLabel];
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
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	cell.textLabel.text = [[_searchResult objectAtIndex:indexPath.row] objectForKey:@"name"];
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[_searchBar resignFirstResponder];
	[self hideHistoryTable];
}

- (UIActivityIndicatorView *)activityView{
	if (!_activityView) {
		_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityView.frame = CGRectMake(0, 0, 20, 20);
		_activityView.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
	}
	return _activityView;
}


#pragma mark touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[_searchBar resignFirstResponder]; //点击空白部分 取消_searchBar的第一响应者
	[self hideHistoryTable];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[_searchBar resignFirstResponder];
	[self hideHistoryTable];
}

#pragma mark UISearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[self searchContent];
	[_searchBar resignFirstResponder];
	[self hideHistoryTable];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	/*
		弹出历史搜索清单
	 */
	
	[self showHistoryTable];
	return YES;
}

#pragma -
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	currentPage = 0;
	pageSize = 5;
	totalPage = NSIntegerMax;
	_searchResult = [[NSMutableArray alloc] initWithCapacity:42];
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64) style:UITableViewStylePlain];
	
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor whiteColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	
	__weak QSSearchViewController *weakSelf = self;
	[_tableView addInfiniteScrollingWithActionHandler:^{
		//			[weakSelf.tableView.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
		[weakSelf addSearchData];
	}];
	[_tableView addPullToRefreshWithActionHandler:^{
		[weakSelf refreshData];
		//			[weakSelf.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
	}];
	[self.view addSubview:_tableView];
	[self.view addSubview:self.activityView];
}

- (void)viewWillDisappear:(BOOL)animated{
	[self hideSearchBar];
}

- (void)viewWillAppear:(BOOL)animated{
	[self showSearchBar];
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
