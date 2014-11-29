//
//  QSRootLeftView.h
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMainFirstPage   0
#define kCrazyQGPage  1
#define kSearchPage  2
#define kSettingPage 3

@interface QSRootLeftView : UIView<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) int categoryType;
@property(nonatomic, strong) UIImageView *headImgView;
@property(nonatomic, strong) UILabel *logInLabel;

@property(nonatomic ,copy) void(^ fadeBlock)(void);
@property(nonatomic, copy) void(^ loginBlock)(void);

- (void)useLoginBlock:(void(^)(void))aBlock;
- (void)useFadeBlock:(void(^)(void))aBlock;
@end
