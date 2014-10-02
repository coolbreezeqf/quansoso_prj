//
//  QSDataSevice.m
//  Quansoso
//
//  Created by qf on 14/10/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSDataSevice.h"
#import "SynthesizeSingleton.h"
@interface QSDataSevice ()

@end

@implementation QSDataSevice
SYNTHESIZE_SINGLETON_FOR_CLASS(QSDataSevice);

- (NSMutableArray *)searchHistoryArr{
	if (!_searchHistoryArr) {
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		[ud synchronize];
		_searchHistoryArr = [ud mutableArrayValueForKey:@"SearchHistoryArr"];
	}
	return _searchHistoryArr;
}


@end
