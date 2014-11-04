//
//  AttentionBrandListManage.h
//  Quansoso
//
//  Created by Johnny's on 14-10-6.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSAttentionBrandListManage : NSObject

@property(nonatomic) int nextPage;

- (void)getFirstAttentionBrandListSuccBlock:(void(^)(NSMutableArray *))aSuccBlock andFailBlock:(void(^)(void))aFailBlock;
- (void)getNextAttentionBrandListSuccBlock:(void(^)(NSArray *))aBlock andFailBlock:(void(^)(void))aFailBlock;
@end
