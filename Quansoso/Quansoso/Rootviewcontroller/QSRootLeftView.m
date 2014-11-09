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
    
    UIImageView *backGroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*1/3, 0, kMainScreenWidth*2/3, kMainScreenHeight)];
    [backGroundImg setImage:[UIImage imageNamed:@"QSrightViewBack"]];
    [self addSubview:backGroundImg];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width*2/3, self.width*1/2+40)];
    _topView.backgroundColor = [UIColor clearColor];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, ViewBottom(_topView)/2-40, 80, 80)];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[[TaeSession sharedInstance] getUser].iconUrl]
                        placeholderImage:[UIImage imageNamed:@"QSUserDefualt"]];
    self.headImgView.layer.cornerRadius = 40;
    self.headImgView.clipsToBounds = YES;
    [_topView addSubview:self.headImgView];
    
    UILabel *logInLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImgView.right+20, self.headImgView.bottom-50, 40, 21)];
    logInLabel.font = kFont16;
    logInLabel.textColor = RGBCOLOR(126, 165, 97);
    logInLabel.text = @"登录";
    logInLabel.textAlignment = NSTextAlignmentLeft;
    [_topView addSubview:logInLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.bottom-1, self.width*2/3, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    [_topView addSubview:lineView];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(self.width*1/3, 0, self.width*2/3, self.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor clearColor];
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
    if (indexPath.row==5) {
        return cellHeight+20;
    }
    if (indexPath.row != 4) {
        return cellHeight;
    }
    return kMainScreenHeight-(cellHeight*4+cellHeight+20+ViewBottom(_topView));
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.row != 4)
    {
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/3-15, cellHeight/2-10, 100, 20)];
        itemLabel.text = [tableViewArray objectAtIndex:indexPath.row];
        itemLabel.font = kFont14;
        itemLabel.textColor = RGBCOLOR(126, 165, 97);
        itemLabel.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:itemLabel];
        UIImageView *itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(itemLabel.left-45, cellHeight/2-8, 16, 16)];
        [itemImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"QSRightViewItem%d", indexPath.row]]];
        [cell addSubview:itemImg];
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
                            initWithFrame:CGRectMake(0, kMainScreenHeight-(cellHeight*4+cellHeight+20+_topView.bottom)-1, _tableview.width, 0.5)];
        lineView.backgroundColor = [UIColor blackColor];
        [cell addSubview:lineView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
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
