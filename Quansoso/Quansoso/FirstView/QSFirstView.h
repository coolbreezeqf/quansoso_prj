//
//  QSFirstView.h
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSAttentionBrandListManage.h"
#import "QSDayRecommendManage.h"

@interface QSFirstView : UIView<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imagebrand;
@property(nonatomic, strong) UIView *viewSearch;
@property(nonatomic, strong) UILabel *labelDaily;
@property(nonatomic, strong) UILabel *labelNike;
@property(nonatomic, strong) UILabel *labelPrivilege;
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UITableView *showQuanTableView;
@property(nonatomic, strong) QSAttentionBrandListManage *attentionBrandListManage;
@property(nonatomic, strong) QSDayRecommendManage *dayRecommendManage;
@property(nonatomic, strong) UITapGestureRecognizer *tapSearchGestureRecognizer;
@property(nonatomic, strong) UIActivityIndicatorView *activityDayRecommendView;
@property(nonatomic, strong) UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame;
@end
