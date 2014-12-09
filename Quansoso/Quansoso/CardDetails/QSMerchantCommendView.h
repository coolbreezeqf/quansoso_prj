//
//  QSMerchantCommendView.h
//  Quansoso
//
//  Created by qf on 14/11/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QSMerchantCommendDelegate <NSObject>

- (void)gotoMoreCard;
- (void)gotoShop;
- (void)gotoItem:(NSString *)item;
@end

@interface QSMerchantCommendView : UIView
@property (nonatomic,strong) NSString *webSiteUrl;
@property (nonatomic,strong) NSArray *itemArray; //of item;
@property (nonatomic,strong) id<QSMerchantCommendDelegate> delegate;
@property (nonatomic,strong) UITableView *tableView;

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items;
@end
