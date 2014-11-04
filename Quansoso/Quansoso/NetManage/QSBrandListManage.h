//
//  BrandListManage.h
//  Quansoso
//
//  Created by Johnny's on 14-10-6.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSBrandListManage : NSObject

- (void)getBrandListPageSize:(int)aPageSize andSuccBlock:(void(^)(NSMutableArray *aArray))aBlock andFailBlock:(void(^)(void))aFailBlock;

- (void)getNextBrandListSuccBlock:(void(^)(NSArray *aArray))aSuccBlock andFailBlock:(void(^)(void))aFailBlock;
@end
