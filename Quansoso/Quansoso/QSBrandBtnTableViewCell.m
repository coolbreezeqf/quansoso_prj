//
//  QSBrandBtnTableViewCell.m
//  Quansoso
//
//  Created by Johnny's on 14/12/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandBtnTableViewCell.h"
#import "QSBrandBtn.h"

@implementation QSBrandBtnTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        brandWidth = kMainScreenWidth/3;
        brandHeight = brandWidth/0.85;
        for (int i=0; i<3; i++) {
            QSBrandBtn *btn = [[QSBrandBtn alloc] initWithFrame:CGRectMake(brandWidth*i, 0, brandWidth, brandHeight)];
            btn.tag = i+1;
            btn.brandLikeView.tag = i+10;
            btn.brandImgView.tag = i+100;
            [btn.brandLikeView addTarget:self action:@selector(likeButton:) forControlEvents:UIControlEventTouchUpInside];
            [btn.brandImgView addTarget:self action:@selector(touchImg:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)touchImg:(UIButton *)aBtn
{
    _index=aBtn.tag-100;
    [self.delegate selectBrandCell:self withRow:_row andIndex:_index];
}

- (void)likeButton:(UIButton *)aBtn
{
    _index=aBtn.tag-10;
    [self.delegate selectCell:self withRow:_row andIndex:_index];
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    if (point.x<brandWidth)
//    {
//        _index=0;
//    }
//    else if(point.x<brandWidth*2)
//    {
//        _index=1;
//    }
//    else
//    {
//        _index=2;
//    }
//    [self.delegate selectCell:self withRow:_row andIndex:_index];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
