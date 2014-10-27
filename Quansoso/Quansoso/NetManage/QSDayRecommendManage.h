//
//  QSDayRecommend.h
//  Quansoso
//
//  Created by able on 14-10-11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSDayRecommendManage : NSObject

- (void)getDayRecommendSuccBlock:(void(^)(NSArray *dayRecomendModelArray))aBlock andFailBlock:(void(^)(void))aFailBlock;
@end
