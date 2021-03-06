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
@property (nonatomic,strong) NSString *lastVersion;
@end

@implementation QSDataSevice
SYNTHESIZE_SINGLETON_FOR_CLASS(QSDataSevice);

- (void)saveData{
	[self saveSearchHistoryArr];
}

- (void)saveTime:(NSString *)aTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    [ud setValue:aTime forKey:@"time"];
}

- (NSString *)getTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    return [ud stringForKey:@"time"];
}

- (void)saveRedDict:(NSMutableDictionary *)aDict
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    [ud setValue:aDict forKey:@"dict"];
}

- (NSMutableDictionary *)getDict
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    return [[ud dictionaryForKey:@"dict"] mutableCopy];
}

- (void)saveLastVersion:(NSString *)lastVersion{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud synchronize];
	[ud setValue:lastVersion forKey:@"lastVersion"];
}

- (NSString*)lastVersion{
	if (!_lastVersion){
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		[ud synchronize];
		_lastVersion = [ud stringForKey:@"lastVersion"];
	}
	return _lastVersion;
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
