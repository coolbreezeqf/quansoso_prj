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
#import "CAlertLabel.h"
#import "Result.h"
#import "QSMerchantTableViewCell.h"
#import "QSMerchantDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "QSSSearchBar.h"
#import "QSSearchNothingView.h"
@interface QSSearchViewController (){
	NSString *currentText;
	float keyboardHeight;
}

@property (nonatomic,strong) QSSSearchBar *searchBar;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *historyTip;
@property (nonatomic,strong) QSSearchHistoryView *historyTable;
@property (nonatomic,strong) NSMutableArray *historyArr; //of  NSString
@property (nonatomic,strong) QSSearchNetManager *netManager;
@property (nonatomic,strong) QSSearchNothingView *nothingView;
@property (nonatomic,strong) NSMutableArray *searchResults;		//of SearchInfo.result
@end

@implementation QSSearchViewController

- (void)showSearchBar{
	if (!_searchBar) {
		UIView *leftBarView = self.navigationItem.leftBarButtonItem.customView;
		if(kMainScreenWidth != 320){
			_searchBar = [[QSSSearchBar alloc] initWithFrame:CGRectMake(leftBarView.width ,0, kMainScreenWidth - leftBarView.width -10 , 46)];
		}else{
			_searchBar = [[QSSSearchBar alloc] initWithFrame:CGRectMake(leftBarView.width ,0, kMainScreenWidth - leftBarView.width - 10, 46)];
		}
		[_searchBar becomeFirstResponder];
		_searchBar.delegate = self;
	}
	[self.navigationController.navigationBar addSubview:_searchBar];
}

- (void)hideSearchBar{
	[_searchBar removeFromSuperview];
	self.navigationItem.rightBarButtonItem = nil;
}

- (void)showHistoryTable{
	if(!_historyTable){
		_historyTable = [[QSSearchHistoryView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - keyboardHeight) withHistoryArr:self.historyArr];
		_historyTable.tag = 1;
		_historyTable.delegate = self;
		[self.view addSubview:_historyTable];
	}
	[self.view bringSubviewToFront:_historyTable];
}

- (void)hideHistoryTable{
	[self.view sendSubviewToBack:_historyTable];
	[self.view bringSubviewToFront:_tableView];
}


//添加历史纪录
- (void)refreshHistoryData{
	[self.historyArr insertObject:_searchBar.text atIndex:0];
	for (int i = 1; i < self.historyArr.count; i++) {
		if ([_historyArr[i] isEqualToString:_historyArr[0]]) {
			[_historyArr removeObjectAtIndex:i];
		}
	}
	if(self.historyArr.count > 10){
		[_historyArr removeLastObject];
	}
	[self.historyTable reloadHistory:_historyArr];
}

- (void)addSearchData{
	int64_t delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		
		//请求并添加数据
		
		__weak QSSearchViewController *weakSelf = self;
		[_netManager searchNextContentWithSuccess:^(NSArray *results) {
			NSInteger lastIndex = _searchResults.count;
			if (results) {
				[weakSelf.searchResults addObjectsFromArray:results];
			}
			NSMutableArray *insertArr = [[NSMutableArray alloc] initWithCapacity:42];
			for (int i = 0; i < results.count; i++) {
				[insertArr addObject:[NSIndexPath indexPathForRow:lastIndex + i inSection:0]];
			}
			//开始更新
			[_tableView beginUpdates];
			[_tableView insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationFade];
			//结束更新
			[_tableView endUpdates];
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

		__weak QSSearchViewController *weakSelf = self;
		[_netManager searchContent:currentText success:^(NSArray *results) {
			[weakSelf searchEndAddContentUse:results];
		} failure:^{
			
		}];
		
		//停止菊花
		[_tableView.pullToRefreshView stopAnimating];
	});
	
}


- (void)searchContent{
	[self.view bringSubviewToFront:self.tableView];
	[_activityView startAnimating];
	currentText = _searchBar.text;
	if ([currentText isEqualToString:@""]) {
		CAlertLabel *al = [CAlertLabel alertLabelWithAdjustFrameForText:@"输入你要搜索的品牌"];
		[al showAlertLabel];
		return ;
	}
	__weak QSSearchViewController *weakSelf = self;
	[_netManager searchContent:currentText success:^(NSArray *results) {
		[weakSelf searchEndAddContentUse:results];
		[_activityView stopAnimating];
	} failure:^{
		
	}];
	[_searchBar resignFirstResponder];
	[self.view sendSubviewToBack:_historyTable];
	[self refreshHistoryData];
}

- (void)searchEndAddContentUse:(NSArray* )result{
	[_searchResults removeAllObjects];
	[_searchResults addObjectsFromArray:result];
	//下拉刷新时 用插入会有问题
	[_tableView reloadData];
}

- (void)cleanHistory{
	[self.historyArr removeAllObjects];
}

- (void)userFeedback{
	MLOG(@"userFeedBack");
}

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - history delegate

- (void)historySearch:(NSString *)searchContent{
	_searchBar.text = searchContent;
	[self searchContent];
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

	if (!currentText) {
		self.tipLabel.text = @"请输入你要搜索的品牌";
		[self.tableView addSubview:_tipLabel];
	}else if(_searchResults.count == 0){  //result为空时 将nothingview置顶
		if (!_nothingView) {
			_nothingView = [[QSSearchNothingView alloc] initWithFrame:self.view.bounds];
			[self.view addSubview:_nothingView];
		}
		[self.view bringSubviewToFront:_nothingView];
	}else{ // _searchResult != nil and count>0
		[self.tipLabel removeFromSuperview];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	}
	return _searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	QSMerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantCell"];
	if (!cell) {
		cell = [[QSMerchantTableViewCell alloc] initWithFrame:CGRectNull];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	Result *result = [_searchResults objectAtIndex:indexPath.row];
	cell.titleLb.text = result.name;
	CGRect rect = cell.titleLb.frame;
	rect.size.width = kMainScreenWidth - cell.iconImageView.right;
	[cell.titleLb setFrame:rect];
	[cell.iconImageView setImageWithURL:[NSURL URLWithString:result.picUrl]];
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[_searchBar resignFirstResponder];
	[self hideHistoryTable];
	Result *result = [_searchResults objectAtIndex:indexPath.row];
	QSMerchantDetailsViewController *mdvc = [[QSMerchantDetailsViewController alloc] initWithTopId:result.topId];
	[self.navigationController pushViewController:mdvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 1; //用来消除searchResult的table里多余的分割线
}

#pragma mark touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if([_searchBar isFirstResponder]){
		[_searchBar resignFirstResponder]; //点击空白部分 取消_searchBar的第一响应者
	}
//	[self hideHistoryTable];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	if([_searchBar isFirstResponder]){
		[_searchBar resignFirstResponder]; //点击空白部分 取消_searchBar的第一响应者
	}//	[self hideHistoryTable];
}

#pragma mark UISearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[self searchContent];
	[_searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	/*
		弹出历史搜索清单
	 */
	
	[self showHistoryTable];
	return YES;
}
#pragma mark - keyboard
//- (void)keyboardWillShow:(NSNotification *)notification{
//	NSDictionary *info = [notification userInfo];
//	//获取高度
//	NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
//	CGSize hightSize = [value CGRectValue].size;
//}
#pragma mark -
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	_netManager = [[QSSearchNetManager alloc] init];
	_searchResults = [[NSMutableArray alloc] initWithCapacity:42];
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) style:UITableViewStylePlain];
	
	_tableView.tag = 0;
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor whiteColor];
//	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	
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
