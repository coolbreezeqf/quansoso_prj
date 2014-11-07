//
//  QSSearchHistoryView.h
//  Quansoso
//
//  Created by qf on 14/11/5.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QSSearchHistoryDelegate <NSObject>

- (void)historySearch:(NSString*)searchContent;
- (void)cleanHistory;
@end

@interface QSSearchHistoryView : UIView
@property (nonatomic,strong) id<QSSearchHistoryDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame withHistoryArr:(NSArray *)arr;
- (void)reloadHistory:(NSArray *)historyarr;
@end
