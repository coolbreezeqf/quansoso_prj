//
//  QSMyCardModel.h
//  Quansoso
//
//  Created by Johnny's on 14/12/15.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSCards.h"

@interface QSMyCardModel : NSObject

@property(nonatomic, strong) QSCards *card;
@property(nonatomic, strong) NSString *shopId;

@end
