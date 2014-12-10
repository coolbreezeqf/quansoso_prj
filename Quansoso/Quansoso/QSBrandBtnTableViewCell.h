//
//  QSBrandBtnTableViewCell.h
//  Quansoso
//
//  Created by Johnny's on 14/12/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QSBrandBtnTableViewCell;
@protocol QSBrandBtnTableViewCellDelegate <NSObject>

- (void)selectCell:(QSBrandBtnTableViewCell *)aCell withRow:(int)aRow andIndex:(int)aIndex;
- (void)selectBrandCell:(QSBrandBtnTableViewCell *)aCell withRow:(int)aRow andIndex:(int)aIndex;

@end


@interface QSBrandBtnTableViewCell : UITableViewCell
{
    float brandWidth;
    float brandHeight;
}

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int index;
@property(nonatomic, strong) id<QSBrandBtnTableViewCellDelegate>delegate;

@end
