//
//  QSAttentionBrandView.h
//  Quansoso
//
//  Created by Johnny's on 14-10-3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSAttentionBrandListManage.h"
#import "QSLikeBrandManage.h"

@interface QSAttentionBrandView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    int deleteBrandIndex;
}
@property(nonatomic, strong) UITableView *showBrandTableView;
@property(nonatomic, strong) QSAttentionBrandListManage *attentionBrandListManage;
@property(nonatomic, strong) UIAlertView *alertView;
@property(nonatomic, strong) NSMutableArray *brandArray;
@property(nonatomic, strong) UIView *failView;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, strong) QSLikeBrandManage *likeBrandManage;

- (instancetype)initWithFrame:(CGRect)frame;
@end
