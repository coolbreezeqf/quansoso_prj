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

- (void)getFirstAttentionBrandListSuccBlock:(void(^)(NSMutableArray *aArray))aSuccBlock andFailBlock:(void(^)(void))aFailBlock isIndex:(BOOL)aBool;
- (void)getNextAttentionBrandListSuccBlock:(void(^)(NSArray *aArray))aBlock andFailBlock:(void(^)(void))aFailBlock voidBlock:(void(^)(void))aVoidBlock;
@end
