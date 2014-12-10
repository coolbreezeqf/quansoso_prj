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
#import "QSBrandTableViewCell.h"

@interface QSFirstView : UIView<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, QSBrandTableViewCellDelegate>
{
    NSMutableArray *dailyShopIdArray;
    float pageControlEndX;
    int currPage;
    BOOL isFirst;
}
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imagebrand;
@property(nonatomic, strong) UIImageView *viewSearch;
@property(nonatomic, strong) UILabel *labelDaily;
@property(nonatomic, strong) UILabel *labelPrivilege;
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UITableView *showQuanTableView;
@property(nonatomic, strong) QSAttentionBrandListManage *attentionBrandListManage;
@property(nonatomic, strong) QSDayRecommendManage *dayRecommendManage;
@property(nonatomic, strong) UITapGestureRecognizer *tapSearchGestureRecognizer;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) UIImageView *loadingImgView;
@property(nonatomic, strong) void(^ myBlock)(void);

@property(nonatomic, strong) NSArray *dailyArray;
@property(nonatomic, strong) NSMutableArray *brandArray;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)touchRightMoreBtn:(void(^)(void))aBlock;
@end
