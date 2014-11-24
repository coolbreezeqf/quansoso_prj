//
//  QSLikeBrandManage.h
//  Quansoso
//
//  Created by Johnny's on 14/11/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSLikeBrandManage : NSObject

- (void)likeBrand:(int)aBrandId andSuccBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(void))aFailBlock;
- (void)likeMultiBrand:(NSArray *)aBrandIdArray andSuccBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(void))aFailBlock;
- (void)unlikeBrand:(int)aBrandId andSuccBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(void))aFailBlock;
@end
