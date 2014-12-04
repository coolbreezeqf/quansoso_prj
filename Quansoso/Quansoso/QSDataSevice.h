//
//  QSDataSevice.h
//  Quansoso
//
//  Created by qf on 14/10/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSDataSevice : NSObject{
	
}
@property (nonatomic,strong) NSMutableArray *searchHistoryArr;
@property (nonatomic,assign) BOOL pushIntroduceStatus;
+ (QSDataSevice *)sharedQSDataSevice;
- (void)saveData;
- (void)savePushIntroduceStatus;


- (void)saveTime:(NSString *)aTime;
- (NSString *)getTime;
- (void)saveRedDict:(NSMutableDictionary *)aDict;
- (NSMutableDictionary *)getDict;
@end
