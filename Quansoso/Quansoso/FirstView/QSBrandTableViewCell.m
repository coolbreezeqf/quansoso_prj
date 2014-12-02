//
//  QSBrandTableViewCell.m
//  Quansoso
//
//  Created by Johnny's on 14/12/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandTableViewCell.h"
#import "QSAttentionBtn.h"
@implementation QSBrandTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        interval = (kMainScreenWidth-298)/6;
        CGRect temFrame = self.frame;
        temFrame.size.width = kMainScreenWidth;
        self.frame = temFrame;
        for (int i=0; i<3; i++) {
            QSAttentionBtn *attentionbtn = [[QSAttentionBtn alloc]
                                            initWithFrame:CGRectMake(interval*2+(96+5+interval)*i, 8, 96, 96)];
            attentionbtn.tag = i+1;
            [self addSubview:attentionbtn];
        }
        
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y>8)
    {
        if (point.x>interval*2+(96+5+interval)*0&&point.x<interval*2+(96+5+interval)*0+96)
        {
            _index=0;
        }
        else if (point.x>interval*2+(96+5+interval)*1&&point.x<interval*2+(96+5+interval)*1+96)
        {
            _index=1;
        }
        else if (point.x>interval*2+(96+5+interval)*2&&point.x<interval*2+(96+5+interval)*2+96)
        {
            _index=2;
        }
        QSAttentionBtn *attentionbtn = (QSAttentionBtn *)[self viewWithTag:_index+1];
        [attentionbtn removeRedView];
        [self.delegate selectCell:self withRow:_row andIndex:_index];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
