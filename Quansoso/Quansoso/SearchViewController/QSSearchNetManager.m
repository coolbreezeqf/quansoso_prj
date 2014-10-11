//
//  QSSearchNetManager.m
//  Quansoso
//
//  Created by qf on 14/9/23.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSSearchNetManager.h"
#import "NetManager.h"
#define kURLSearch @"http://repository.api.ekupeng.com/search/merchant"
#import "SearchInfo.h"
@interface QSSearchNetManager (){
	NSInteger currentPage;
	NSInteger pageSize;
	NSString *currentText;
}

@property (nonatomic,strong) SearchInfo *searchInfo;
@end

@implementation QSSearchNetManager

- (instancetype)init{
	if (self = [super init]) {
		currentPage = 0;
		pageSize = (kMainScreenHeight - 44) / 90 ;
	}
	return self;
}

- (void)searchNextContentWithSuccess:(void (^)(NSArray *results))succ failure:(void (^)())failure{
	NSDictionary *dic = @{@"pageSize":@(pageSize),
						  @"keywords":currentText,
						  @"currentPage":@(currentPage + 1)};
	[NetManager requestWith:dic url:kURLSearch method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
		_searchInfo = [SearchInfo modelObjectWithDictionary:successDict];
		currentPage = _searchInfo.currentPage;
		
		succ(_searchInfo.results);
		
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
}

- (void)searchContent:(NSString *)content success:(void (^)(NSArray *results))succ failure:(void (^)())failure{
	currentText = content;
	NSDictionary *dic = @{@"pageSize":@(pageSize),
						  @"keywords":currentText,
						  @"currentPage":@1};
	[NetManager requestWith:dic url:kURLSearch method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
		_searchInfo = [SearchInfo modelObjectWithDictionary:successDict];
		currentPage = _searchInfo.currentPage;
		
		succ(_searchInfo.results);
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure();
	}];
}
@end
