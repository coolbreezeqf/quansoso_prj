//
//  QSRootLeftView.m
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSRootLeftView.h"
#import "UIImageView+WebCache.h"
#import <TAESDK/TAESDK.h>


NSArray *tableViewArray;
CGFloat cellHeight;
@implementation QSRootLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self createTableview];
        self.userInteractionEnabled = YES;
        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                        initWithTarget:self action:@selector(useBlock:)];
        [self addGestureRecognizer:swipeGestureRecognizer];
    }
    return self;
}

- (void)useBlock:(UISwipeGestureRecognizer *)aGestureRecongnizer
{
    if (aGestureRecongnizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        _fadeBlock();
    }
}

- (void)useFadeBlock:(void (^)(void))aBlock
{
    _fadeBlock = aBlock;
}

- (void)createTableview
{
    tableViewArray = @[@"首页", @"我的优惠券", @"我关注的品牌", @"分享app", @"", @"设置"];
    cellHeight = 44;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width*2/3, self.width*1/2)];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*1/3-30, ViewBottom(_topView)/2-30, 60, 60)];
    self.headImgView.backgroundColor = [UIColor blueColor];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[[TaeSession sharedInstance] getUser].iconUrl]
                        placeholderImage:[UIImage imageNamed:@"defaultImage"]];
    [_topView addSubview:self.headImgView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.width*1/2-1, self.width*2/3, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    [_topView addSubview:lineView];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(self.width*1/3, 0, self.width*2/3, self.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor whiteColor];
    _tableview.scrollEnabled = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.tableHeaderView = _topView;
    [self addSubview:_tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 4) {
        return cellHeight;
    }
    return kMainScreenHeight-(cellHeight*5+ViewBottom(_topView));
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftviewcell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftviewcell"];
    }
    if (indexPath.row != 4)
    {
        cell.textLabel.text = [tableViewArray objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        if (indexPath.row != 5)
        {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, _tableview.width, 0.5)];
            lineView.backgroundColor = [UIColor blackColor];
            [cell addSubview:lineView];
        }
    }
    else
    {
        cell.userInteractionEnabled = NO;
        UIView *lineView = [[UIView alloc]
                            initWithFrame:CGRectMake(0, kMainScreenHeight-(cellHeight*5+ViewBottom(_topView))-1, _tableview.width, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        [cell addSubview:lineView];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 4)
    {
        self.categoryType = indexPath.row;
    }
}

- (void)drawRect:(CGRect)rect
{
    
}

@end
