//
//  ViewInteraction.h
//  YOChangeWord
//
//  Created by  striveliu on 14-9-2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewInteraction : NSObject
+ (void)viewPresentAnimationFromBottom:(UIView*)aFromView
                                toView:(UIView*)aToView;
+ (void)viewDissmissAnimationToBottom:(UIView*)aToView;

+ (void)viewPresentAnimationFromRight:(UIView*)aFromView
                               toView:(UIView*)aToView;

+ (void)viewDissmissAnimationToRight:(UIView*)aToView isRemove:(BOOL)aIsRemove;

+ (void)viewPresentAnimationFromLeft:(UIView*)aFromView
                              toView:(UIView*)aToView;

+ (void)viewDissmissAnimationToLeft:(UIView*)aToView isRemove:(BOOL)aIsRemove;
@end
