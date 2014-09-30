//
//  QSFirstView.h
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSFirstView : UIView<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imagebrand;
@property(nonatomic, strong) UIView *viewSearch;
@property(nonatomic, strong) UILabel *labelDaily;
@property(nonatomic, strong) UILabel *labelPrivilege;
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UITableView *showQuanTableView;

@property(nonatomic, strong) UITapGestureRecognizer *tapSearchGestureRecognizer;

- (instancetype)initWithFrame:(CGRect)frame;
@end
