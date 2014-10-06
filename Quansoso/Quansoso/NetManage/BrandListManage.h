//
//  BrandListManage.h
//  Quansoso
//
//  Created by Johnny's on 14-10-6.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandListManage : NSObject

+ (void)getBrandListArray:(int)aPageSize andSuccBlock:(void(^)(void))aBlock;
@end
