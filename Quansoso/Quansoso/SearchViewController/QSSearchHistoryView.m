//
//  QSSearchHistoryView.m
//  Quansoso
//
//  Created by qf on 14/11/5.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchHistoryView.h"
#define kTitleHeight 30

@interface QSSearchHistoryView (){
	UILabel *_historyNilTip;
	NSMutableArray *_historyBlockArr;
	NSArray *_historyArr;
//	UIButton *_cleanHistoryBt;
}

@end

@implementation QSSearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame withHistoryArr:(NSArray *)arr{
	if (self = [super initWithFrame:frame]) {
		_historyArr = arr;
		[self initUI];
	}
	return self;
}

- (void)setTitle{
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth-20, kTitleHeight-20)];
	titleLabel.text = @"历史记录";
	titleLabel.font = kFont13;
	titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:titleLabel];
}

- (void)initUI{
	self.backgroundColor = RGBCOLOR(242, 239, 233);
	[self setTitle];
	//分隔线
	UIView *separateline = [[UIView alloc] initWithFrame:CGRectMake(0, kTitleHeight, kMainScreenWidth, 1)];
	separateline.backgroundColor = [UIColor lightGrayColor];
	[self addSubview:separateline];
	
	[self setHistoryInfo];
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (void)reloadHistory:(NSArray *)historyarr{
	if ([_historyNilTip superview]) {
		[_historyNilTip removeFromSuperview];
	}
	_historyArr = historyarr;
	if (!_historyBlockArr) {
		_historyBlockArr = [[NSMutableArray alloc] initWithCapacity:15];
	}
	NSArray *arr = [_historyBlockArr copy];
	if (_historyBlockArr.count != 0) {
		for (UIButton *bt in arr) {
			[bt removeFromSuperview];
		}
	}
	[_historyBlockArr removeAllObjects];
	int offsetX = 20,offsetY = kTitleHeight+20;
	//遍历history
	for (NSString *his in historyarr) {
		int len = [self widthOfString:his withFont:kFont15];
		int width = len + 30;
		if (width > kMainScreenWidth/2 - 40) {
			width = kMainScreenWidth/2 - 30;
		}
		if (offsetX + width + 20 > kMainScreenWidth) {
			offsetX = 20;
			offsetY += 40;
		}
		UIButton *hisBt = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, offsetY, width, 30)];
		[hisBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
		[hisBt setTitle:his forState:UIControlStateNormal];
		hisBt.titleLabel.font = kFont15;
		hisBt.layer.borderWidth = 1;
		hisBt.layer.cornerRadius = 5;
		hisBt.layer.borderColor = [UIColor lightGrayColor].CGColor;
		[hisBt addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchDown];
		[self addSubview:hisBt];
		offsetX += width + 20;
		[_historyBlockArr addObject:hisBt];
	}
/*
	if (!_cleanHistoryBt) {
		_cleanHistoryBt	= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
		[_cleanHistoryBt setTitle:@"清空历史纪录" forState:UIControlStateNormal];
		_cleanHistoryBt.titleLabel.textAlignment = NSTextAlignmentCenter;
		_cleanHistoryBt.backgroundColor = [UIColor redColor];
		[_cleanHistoryBt addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchDown];
		_cleanHistoryBt.layer.cornerRadius = 5;
		[self addSubview:_cleanHistoryBt];
	}
	_cleanHistoryBt.center = CGPointMake(kMainScreenWidth/2, offsetY+60);
 */
}

//- (void)clean{
//	[UIView animateWithDuration:0.5 animations:^{
//		[self reloadHistory:nil];
//	}];
//	[_delegate cleanHistory];
//}

- (void)search:(id)sender{
	UIButton *bt = (UIButton *)sender;
	[_delegate historySearch:bt.titleLabel.text];
}

- (void)setHistoryInfo{
	if (!_historyArr || _historyArr.count==0) {
		if(!_historyNilTip){
			_historyNilTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
			_historyNilTip.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2-100);
			_historyNilTip.text = @"暂无搜索记录";
			_historyNilTip.textAlignment = NSTextAlignmentCenter;
			_historyNilTip.textColor = [UIColor lightGrayColor];
		}
		[self addSubview:_historyNilTip];
	}else{

		[self reloadHistory:_historyArr];
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
