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

- (void)saveData{
	[self saveSearchHistoryArr];
}

- (BOOL)pushIntroduceStatus{
	if (!_pushIntroduceStatus) {
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		[ud synchronize];
		_pushIntroduceStatus = [ud boolForKey:@"pushIntroduceStatus"];
	}
	return _pushIntroduceStatus;
}

- (void)savePushIntroduceStatus{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud synchronize];
	[ud setValue:[NSNumber numberWithBool:_pushIntroduceStatus] forKey:@"pushIntroduceStatus"];
}

- (NSMutableArray *)searchHistoryArr{
	if (!_searchHistoryArr) {
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		[ud synchronize];
		_searchHistoryArr = [ud mutableArrayValueForKey:@"SearchHistoryArr"];
	}
	return _searchHistoryArr;
}

- (void)saveSearchHistoryArr{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud synchronize];
	NSInteger saveNum = 10;
	if(_searchHistoryArr.count > saveNum){
		[_searchHistoryArr removeObjectsInRange:NSMakeRange(saveNum, _searchHistoryArr.count-saveNum)];
	}
	[ud setValue:_searchHistoryArr forKey:@"SearchHistoryArr"];
}

@end
