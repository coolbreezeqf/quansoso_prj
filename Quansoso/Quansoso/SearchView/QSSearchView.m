//
//  QSSearchView.m
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchView.h"
#import "QSSearchResultView.h"

@interface QSSearchView ()

@property (nonatomic,strong) QSSearchResultView *resultView;
@end

@implementation QSSearchView

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		
	}
	return self;
}

- (void)decorateView{
	
}

- (void)searchContent:(NSString *)content{
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
