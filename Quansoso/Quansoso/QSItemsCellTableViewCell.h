//
//  QSItemsCellTableViewCell.h
//  Quansoso
//
//  Created by qf on 14/12/1.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@protocol QSItemsCellDelegate <NSObject>

- (void)selectCellAtIndex:(NSInteger)index andRow:(NSInteger)row;

@end

@interface QSItemsCellTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic,strong) UILabel *titleLb1;
@property (nonatomic,strong) UILabel *titleLb2;
@property (nonatomic,strong) UILabel *priceLb1;
@property (nonatomic,strong) UILabel *priceLb2;
@property (nonatomic,strong) id<QSItemsCellDelegate> delegate;
@property (nonatomic,assign) NSInteger indexOfRow;
- (void)showItemWith:(NSInteger)num;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+ (CGFloat)heightOfCell;
@end
