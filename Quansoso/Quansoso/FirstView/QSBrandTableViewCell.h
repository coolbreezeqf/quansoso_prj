//
//  QSBrandTableViewCell.h
//  Quansoso
//
//  Created by Johnny's on 14/12/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QSBrandTableViewCell;
@protocol QSBrandTableViewCellDelegate <NSObject>

- (void)selectCell:(QSBrandTableViewCell *)aCell withRow:(int)aRow andIndex:(int)aIndex;

@end

@interface QSBrandTableViewCell : UITableViewCell
{
    float interval;
}

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int index;
@property(nonatomic, strong) id<QSBrandTableViewCellDelegate>delegate;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
