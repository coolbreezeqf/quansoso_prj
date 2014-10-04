//
//  QSRootViewController.h
//  Quansoso
//
//  Created by  striveliu on 14-9-17.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBKVOController.h"
#import "QSRootLeftView.h"
#import "QSFirstView.h"
#import "QSCrazyQGView.h"
#import "QSSearchView.h"
#import "QSSettingView.h"
#import "QSCouponView.h"
#import "QSShareAppView.h"
#import "QSAttentionBrandView.h"

@interface QSRootViewController : BaseViewController<UISearchBarDelegate>
{
    FBKVOController *fbkvo;
    QSRootLeftView *leftView;
    QSFirstView *firstview;
    QSCrazyQGView *crazyQGView;
    QSSearchView *searchView;
    QSSettingView *settingView;
    QSCouponView *couponView;
    QSShareAppView *shareAppView;
    QSAttentionBrandView *attentionBrandView;
}
@end
