//
//  QSshowMerIntrodView.m
//  Quansoso
//
//  Created by yato_kami on 14/11/12.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSshowMerIntrodView.h"
#define angleWidth 20
@interface QSshowMerIntrodView()
@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UITextView *textView;
@end
@implementation QSshowMerIntrodView


- (id)initWithFrame:(CGRect)frame AngleX:(CGFloat)angleX angleHeight:(CGFloat)angleHeight
{
    self = [super initWithFrame:frame];
    
    [self pathWithAngleX:angleX angleHeight:angleHeight frame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, angleHeight+10, kMainScreenWidth-20, frame.size.height - angleHeight-10-5)];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = RGBCOLOR(171, 171, 171);
    self.textView.font = kFont12;
    self.textView.text = (self.text ? self.text : @"");
    [self addSubview:self.textView];
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [RGBCOLOR(245, 245, 245) setFill];
    [self.path fill];
    [[UIColor lightTextColor] setStroke];
    [self.path stroke];
    self.backgroundColor = [UIColor clearColor];
    //self.textFiled.text = @"slakdjflkajsdflk";
}

- (void)pathWithAngleX:(CGFloat)angleX angleHeight:(CGFloat)angleHeight frame:(CGRect)frame
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, angleHeight)];
    [path addLineToPoint:CGPointMake(angleX-angleWidth/2.0f, angleHeight)];
    [path addLineToPoint:CGPointMake(angleX, 0)];
    [path addLineToPoint:CGPointMake(angleX + angleWidth/2.0f, angleHeight)];
    [path addLineToPoint:CGPointMake(frame.size.width, angleHeight)];
    [path addLineToPoint:CGPointMake(frame.size.width, frame.size.height)];
    [path addLineToPoint:CGPointMake(0, frame.size.height)];
    [path addLineToPoint:CGPointMake(0, angleHeight)];
    [path closePath];
    path.lineWidth = 0.5f;
    [path addClip];
    self.path = path;
    [self setNeedsDisplay];
}

@end
