//
//  QSSearchView.h
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QSSearchView : UIView<UITableViewDataSource,UITableViewDelegate>{
}

@property (nonatomic,strong) NSMutableArray *searchResult;		//of SearchInfo
@property (nonatomic,strong) UITableView *tableView;

- (void)searchContent:(NSString *)content;

@end
