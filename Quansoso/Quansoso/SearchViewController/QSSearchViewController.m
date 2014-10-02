//
//  QSSearchViewController.m
//  Quansoso
//
//  Created by qf on 14/9/23.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchViewController.h"
#import "SVPullToRefresh.h"
#import "SearchInfo.h"
@interface QSSearchViewController (){
	NSInteger currentPage;
	NSInteger totalPage;
	NSInteger pageSize;
	NSInteger totalCount;
	NSString *currentText;
	float keyboardHeight;
}

@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *historyTip;
@property (nonatomic,strong) UITableView *historyTable;
@property (nonatomic,strong) NSMutableArray *historyArr; //of  NSString
@property (nonatomic,strong) UIButton *feedback;	//反馈按钮
@end

@implementation QSSearchViewController

- (void)showSearchBar{
	[self setRightButton:nil title:@"搜索" target:self action:@selector(searchContent)];

	if (!_searchBar) {
		UIView *leftBarView = self.navigationItem.leftBarButtonItem.customView;
		UIView *rightBarView = self.navigationItem.rightBarButtonItem.customView;
		_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(leftBarView.width ,0, kMainScreenWidth - leftBarView.width - rightBarView.width , 44)];
		_searchBar.backgroundColor = [UIColor clearColor];
		_searchBar.delegate = self;
		_searchBar.Placeholder = @"搜索品牌/优惠";
		//		_searchBar.keyboardType = UIKeyboardTypeDefault;
		[_searchBar setTintColor:[UIColor blackColor]];
		[_searchBar becomeFirstResponder];
	}
	[self.navigationController.navigationBar addSubview:_searchBar];
}

- (void)hideSearchBar{
	[_searchBar removeFromSuperview];
	self.navigationItem.rightBarButtonItem = nil;
}

- (void)showHistoryTable{
	if(!_historyTable){
		_historyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - keyboardHeight) style:UITableViewStylePlain];
		_historyTable.tag = 1;
		_historyTable.delegate = self;
		_historyTable.dataSource = self;
		_historyTable.backgroundColor = [UIColor whiteColor];
		[self.view addSubview:_historyTable];
	}
	[self.view bringSubviewToFront:_historyTable];
}

- (void)hideHistoryTable{
	[self.view sendSubviewToBack:_historyTable];
	[self.view bringSubviewToFront:_tableView];
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

- (void)refreshHistoryData{
	[self.historyArr insertObject:_searchBar.text atIndex:0];
	[_historyTable beginUpdates];
	NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
	[_historyTable insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
	[_historyTable endUpdates];
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
	[self.view sendSubviewToBack:_historyTable];
	[self refreshHistoryData];
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

- (void)clearHistory{
	[self.historyArr removeAllObjects];
	[_historyTable reloadData];
}

- (void)userFeedback{
	MLOG(@"userFeedBack");
}

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - property lazy init
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

- (NSMutableArray *)historyArr{
	if (!_historyArr) {
		_historyArr = [QSDataSevice sharedQSDataSevice].searchHistoryArr;
	}
	return _historyArr;
}

- (UIButton *)feedback{
	if (!_feedback) {
		_feedback = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
		[_feedback setTitle:@"反馈" forState:UIControlStateNormal];
		_feedback.center = CGPointMake(self.tipLabel.center.x, self.tipLabel.center.y + 40);
		_feedback.backgroundColor = [UIColor redColor];
		[_feedback addTarget:self action:@selector(userFeedback) forControlEvents:UIControlEventTouchDown];
	}
	return _feedback;
}

- (UIActivityIndicatorView *)activityView{
	if (!_activityView) {
		_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityView.frame = CGRectMake(0, 0, 20, 20);
		_activityView.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2 - 100);
	}
	return _activityView;
}
#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (tableView.tag == 0) { //tableview
		if (currentPage == 0) {
			self.tipLabel.text = @"";
			[self.tableView addSubview:_tipLabel];
		}else if(_searchResult.count == 0){  //histroy为空时 将tiplabel和反馈按钮添加上去
			self.tipLabel.text = @"您想要的品牌还未入住券搜搜哦，\n请点击下方‘反馈’按钮，\n我们将尽快收录该品牌...";
			[self.tipLabel setNumberOfLines:3];
			if (![_tipLabel superview]) {
				[self.tableView addSubview:_tipLabel];
			}
			if (![self.feedback superview]) {
				[self.tableView addSubview:_feedback];
			}
		}else{ // _searchResult != nil and count>0
			[self.tipLabel removeFromSuperview];
			[self.feedback removeFromSuperview];
		}
		return _searchResult.count;
	}
	else {				//historytable
		
		if (self.historyArr.count == 0) {
			_historyTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 200)];
			[_historyTip setNumberOfLines:4];
			_historyTip.textColor = [UIColor lightGrayColor];
			_historyTip.text = @"还没有搜索记录";
			_historyTip.font = kFont13;
			_historyTip.textAlignment = NSTextAlignmentCenter;
			[_historyTable addSubview:_historyTip];
			_historyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
			
		}else{
			_historyTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
			if (_historyTip) {
				[_historyTip removeFromSuperview];
			}
		}
		return _historyArr.count;
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (tableView.tag == 0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		cell.textLabel.text = [[_searchResult objectAtIndex:indexPath.row] objectForKey:@"name"];
		return cell;
	}
	else{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryCell"];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchHistoryCell"];
		}
		cell.textLabel.text = [_historyArr objectAtIndex:indexPath.row];
		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (tableView.tag == 0) {
		[_searchBar resignFirstResponder];
		[self hideHistoryTable];
	}
	else{
		_searchBar.text = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
		[self searchContent];
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	if (tableView.tag == 1 && self.historyArr.count != 0) {
		return 30;
	}
	else{
		return 0;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	if (tableView.tag == 1 && self.historyArr.count != 0) {
		UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
		clearView.backgroundColor = [UIColor whiteColor];
		UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
		bt.center = clearView.center;
		[clearView addSubview:bt];
		[bt setTitle:@"清空历史纪录"  forState:UIControlStateNormal];
		bt.backgroundColor = [UIColor clearColor];
		//		bt.titleLabel.textColor = [UIColor blueColor];
		[bt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		bt.titleLabel.textAlignment = NSTextAlignmentCenter;
		[bt addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchDown];
		return clearView;
	}
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if (tableView.tag == 1) {
		return @"历史记录";
	}
	return nil;
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
#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification{
	NSDictionary *info = [notification userInfo];
	//获取高度
	NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
	CGSize hightSize = [value CGRectValue].size;
	_historyTable.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - hightSize.height - 64);
}
#pragma mark -
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	currentPage = 0;
	pageSize = 5;
	totalPage = NSIntegerMax;
	_searchResult = [[NSMutableArray alloc] initWithCapacity:42];
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) style:UITableViewStylePlain];
	
	_tableView.tag = 0;
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
	
	//初始化键盘通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[self setLeftButton:[UIImage imageNamed:@"back"] title:@"" target:self action:@selector(back)];
}

- (void)viewWillDisappear:(BOOL)animated{
	[self hideSearchBar];
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		[ud synchronize];
		NSInteger savaNum = 15;
		if(_historyArr.count > savaNum){
			[_historyArr removeObjectsInRange:NSMakeRange(savaNum, _historyArr.count-savaNum)];
		}
		[ud setValue:_historyArr forKey:@"SearchHistoryArr"];
	});
	
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
