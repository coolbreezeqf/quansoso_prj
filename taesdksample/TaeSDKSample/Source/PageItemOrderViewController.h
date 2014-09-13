//
//  PageItemOrderViewController.h
//  TaeSDKTest
//
//  Created by 千醒 on 14-9-9.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageItemOrderViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UILabel *lblPageItemOrder;
@property (strong, nonatomic) UILabel *lblIsNeedPush;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UILabel *lblFontName;
@property (strong, nonatomic) UILabel *lblFontSize;
@property (strong, nonatomic) UILabel *lblColorX;
@property (strong, nonatomic) UILabel *lblColorY;

@property (strong, nonatomic) UILabel *lblItemType;
@property (strong, nonatomic) UILabel *lblSkuId;
@property (strong, nonatomic) UILabel *lblOrderQuantity;



@property (strong, nonatomic) UITextField *tfPageItemOrder;
@property (strong, nonatomic) UITextField *tfIsNeedPush;
@property (strong, nonatomic) UITextField *tfTitle;
@property (strong, nonatomic) UITextField *tfFontName;
@property (strong, nonatomic) UITextField *tfFontSize;
@property (strong, nonatomic) UITextField *tfColorX;
@property (strong, nonatomic) UITextField *tfColorY;

@property (strong, nonatomic) UITextField *tfItemType;
@property (strong, nonatomic) UITextField *tfSkuId;
@property (strong, nonatomic) UITextField *tfOrderQuantity;

@property (strong, nonatomic) UIButton *btnGoPageItemOrder;
@property (strong, nonatomic) UIButton *btnClear;

@end
