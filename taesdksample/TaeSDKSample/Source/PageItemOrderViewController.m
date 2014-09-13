//
//  PageItemOrderViewController.m
//  TaeSDKTest
//
//  Created by 千醒 on 14-9-9.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import "PageItemOrderViewController.h"

@interface PageItemOrderViewController ()

@end

@implementation PageItemOrderViewController
{
    tradeProcessSuccessCallback _tradeProcessSuccessCallback;
    tradeProcessFailedCallback _tradeProcessFailedCallback;
    
    CGFloat labelFontSize;
    NSString *labelFontName;
    
    CGFloat beginX;
    CGFloat beginY;
    
    CGFloat intervalItem;
    CGFloat settingUIY;
    
    CGFloat labelHeight;
    CGFloat textFieldHeight;
    
    char showtype;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        PageItemOrderViewController * __weak weakSelf=self;
        _tradeProcessSuccessCallback=^(TaeTradeProcessResult *tradeProcessResult){
            NSString *tip=[NSString stringWithFormat:@"交易成功:成功的订单%@，失败的订单%@",tradeProcessResult.paySuccessOrders,tradeProcessResult.payFailedOrders];
            [weakSelf alert:tip];
            
            
        };
        _tradeProcessFailedCallback=^(NSError *error){
            [weakSelf alert:[NSString stringWithFormat:@"交易失败:%@",error]];
            
        };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    labelFontName = @"Arial";
    labelFontSize = 12;
    
    beginX = 10;
    beginY = 70;
    intervalItem = 5;
    
    labelHeight = 20;
    textFieldHeight = 30;

    
    _lblPageItemOrder = [[UILabel alloc]init];
    _lblIsNeedPush = [[UILabel alloc]init];
    _lblTitle = [[UILabel alloc]init];
    _lblFontName = [[UILabel alloc]init];
    _lblFontSize = [[UILabel alloc]init];
    _lblColorX = [[UILabel alloc]init];
    _lblColorY = [[UILabel alloc]init];
    _lblItemType = [[UILabel alloc]init];
    _lblSkuId = [[UILabel alloc]init];
    _lblOrderQuantity = [[UILabel alloc]init];
    
    _tfPageItemOrder = [[UITextField alloc]init];
    _tfIsNeedPush = [[UITextField alloc]init];
    _tfTitle = [[UITextField alloc]init];
    _tfFontName = [[UITextField alloc]init];
    _tfFontSize = [[UITextField alloc]init];
    _tfColorX = [[UITextField alloc]init];
    _tfColorY = [[UITextField alloc]init];
    _tfItemType = [[UITextField alloc]init];
    _tfSkuId = [[UITextField alloc]init];
    _tfOrderQuantity = [[UITextField alloc]init];


    
    settingUIY = beginY;
    if ([self.title  isEqualToString: @"showPage"])
    {
        showtype = 0;
        [self addLabel:_lblPageItemOrder textName:@"PageUrl(*)" offsetX:beginX offsetY:beginY width:100 height:labelHeight];
        [self addTextField:_tfPageItemOrder placeHolder:@"URL地址" offsetX:beginX offsetY:settingUIY+labelHeight width:300 height:textFieldHeight];
        _tfPageItemOrder.text = @"http://h5.m.taobao.com/cm/snap/index.html?id=40785849030";
    }
        else if ([self.title  isEqualToString: @"showItemDetail"])
    {
        showtype = 1;
        [self addLabel:_lblPageItemOrder textName:@"ItemDetailId(*)" offsetX:beginX offsetY:settingUIY width:100 height:labelHeight];
        [self addTextField:_tfPageItemOrder placeHolder:@"商品详情Id" offsetX:beginX offsetY:(settingUIY+labelHeight) width:300 height:textFieldHeight];
        _tfPageItemOrder.text = @"AAEbIOpwABpJi95ZrWullHT3";
        
        
        settingUIY += labelHeight+textFieldHeight+intervalItem;
        [self addLabel:_lblItemType textName:@"ItemType(*)" offsetX:beginX offsetY:settingUIY width:100 height:labelHeight];
        [self addTextField:_tfItemType placeHolder:@"1：淘宝  2：天猫" offsetX:beginX offsetY:(settingUIY+labelHeight) width:300 height:textFieldHeight];
        _tfItemType.text = @"1";
        
    }
    else if ([self.title  isEqualToString: @"showOrder"])
    {
        showtype = 2;
        [self addLabel:_lblPageItemOrder textName:@"OrderItemId(*)" offsetX:beginX offsetY:settingUIY width:100 height:labelHeight];
        [self addTextField:_tfPageItemOrder placeHolder:@"混淆Id" offsetX:beginX offsetY:(settingUIY+labelHeight) width:300 height:textFieldHeight];
        _tfPageItemOrder.text = @"AAH6IOpwABpJi95ZrWvhL8Qv";
        
        
        settingUIY += labelHeight+textFieldHeight+intervalItem;
        [self addLabel:_lblSkuId textName:@"SkuId(*)" offsetX:beginX offsetY:settingUIY width:100 height:labelHeight];
        [self addTextField:_tfSkuId placeHolder:@"SkuId" offsetX:beginX offsetY:(settingUIY+labelHeight) width:300 height:textFieldHeight];
        _tfSkuId.text = @"75379956317";
        
        
        settingUIY += labelHeight+textFieldHeight+intervalItem;
        [self addLabel:_lblOrderQuantity textName:@"Order Quantity(*)" offsetX:beginX offsetY:settingUIY width:100 height:labelHeight];
        [self addTextField:_tfOrderQuantity placeHolder:nil offsetX:beginX offsetY:(settingUIY+labelHeight) width:300 height:textFieldHeight];
        _tfOrderQuantity.text = @"1";
        
    }
    else
    {
        [self alert:@"Error"];
        return;
    }
    
    
    settingUIY += labelHeight+textFieldHeight+intervalItem;
    [self addLabel:_lblTitle textName:@"UI Title" offsetX:beginX offsetY:settingUIY width:100 height:labelHeight];
    [self addTextField:_tfTitle placeHolder:@"页面标题，不填为空" offsetX:beginX offsetY:(settingUIY+labelHeight) width:210 height:textFieldHeight];
    _tfTitle.text = @"自定义页面";

    [self addLabel:_lblIsNeedPush textName:@"IsNeedPush" offsetX:beginX+220 offsetY:settingUIY width:100 height:labelHeight];
    [self addTextField:_tfIsNeedPush placeHolder:@"YES/NO" offsetX:beginX+220 offsetY:(settingUIY+labelHeight) width:80 height:textFieldHeight];
    _tfIsNeedPush.text = @"NO";
    
    settingUIY += labelHeight+textFieldHeight+intervalItem;
    [self addLabel:_lblFontName textName:@"FontName" offsetX:beginX offsetY:settingUIY width:100 height:labelHeight];
    [self addTextField:_tfFontName placeHolder:@"NULL" offsetX:beginX offsetY:(settingUIY+labelHeight) width:210 height:textFieldHeight];
    _tfFontName.text = @"Arial";
    
    [self addLabel:_lblFontSize textName:@"FontSize" offsetX:beginX+220 offsetY:settingUIY width:60 height:labelHeight];
    [self addTextField:_tfFontSize placeHolder:@"不填为0" offsetX:beginX+220 offsetY:(settingUIY+labelHeight) width:80 height:textFieldHeight];
    _tfFontSize.text = @"20";
    
    
//    [self addLabel:_lblColorX textName:@"ColorX" offsetX:beginX+105 offsetY:settingUIY width:60 height:labelHeight];
//    [self addTextField:_tfColorX placeHolder:@"不填为0" offsetX:beginX+105 offsetY:(settingUIY+labelHeight) width:90 height:textFieldHeight];
//    
//    [self addLabel:_lblColorY textName:@"ColorY" offsetX:beginX+210 offsetY:settingUIY width:60 height:labelHeight];
//    [self addTextField:_tfColorY placeHolder:@"不填为0" offsetX:beginX+210 offsetY:(settingUIY+labelHeight) width:90 height:textFieldHeight];
    
    
    settingUIY += labelHeight+textFieldHeight+intervalItem;
    _btnGoPageItemOrder = [[UIButton alloc]initWithFrame:CGRectMake(130, settingUIY+10, 60, 30)];
    
    [_btnGoPageItemOrder.layer setMasksToBounds:YES];
    [_btnGoPageItemOrder.layer setCornerRadius:10.0];
    [_btnGoPageItemOrder setTitle:@"go" forState:UIControlStateNormal];
    [_btnGoPageItemOrder setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:_btnGoPageItemOrder];
    [_btnGoPageItemOrder addTarget:self action:@selector(goPageItemOrder) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addLabel:(UILabel*) objLabel
       textName:(NSString*) textName
        offsetX:(CGFloat) offsetX
        offsetY:(CGFloat) offsetY
          width:(CGFloat) width
         height:(CGFloat) height{
    
    objLabel.frame = CGRectMake(offsetX, offsetY, width, height);
    [objLabel setText:textName];
    objLabel.font = [UIFont fontWithName:labelFontName size:labelFontSize];
    [self.view addSubview:objLabel];
}

-(void)addTextField:(UITextField*) objTextField
       placeHolder:(NSString*) placeHolder
        offsetX:(CGFloat) offsetX
        offsetY:(CGFloat) offsetY
          width:(CGFloat) width
         height:(CGFloat) height{
    
    objTextField.frame = CGRectMake(offsetX, offsetY, width, height);
    //objTextField = [[UITextField alloc]initWithFrame:CGRectMake(offsetX, offsetY, width, height)];
    objTextField.placeholder = placeHolder;

    objTextField.font = [UIFont fontWithName:labelFontName size:labelFontSize];
    objTextField.keyboardType = UIKeyboardTypeDefault;
    objTextField.borderStyle = UITextBorderStyleRoundedRect;
    objTextField.delegate = self;
    objTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:objTextField];
}


-(void)goPageItemOrder
{
    BOOL isneedpush;
    TaeWebViewUISettings *taewebViewUISettings = [[TaeWebViewUISettings alloc] init];
    
//    if ([self.tfPageItemOrder.text isEqualToString: @""]){
//       NSLog(@"input is not integrity\n");
//        [self alert:@"(*)输入参数不能为空"];
//        return;
//        }
    


    taewebViewUISettings.title = self.tfTitle.text;
    taewebViewUISettings.titleFont = [UIFont fontWithName:self.tfFontName.text size:[self.tfFontSize.text floatValue]];
    taewebViewUISettings.barTintColor = [UIColor colorWithWhite:[self.tfColorX.text floatValue] alpha:[self.tfColorY.text floatValue]];
    
    if ([self.tfIsNeedPush.text isEqualToString:@"NO"]) {
        isneedpush = NO;
    }
    else
    {
        isneedpush = YES;
    }
    
    //调用showPage
    if (showtype == 0) {
        [[TaeSDK sharedInstance] showPage:self.navigationController
                               isNeedPush:isneedpush
                                  pageUrl:self.tfPageItemOrder.text
                        webViewUISettings:taewebViewUISettings
              tradeProcessSuccessCallback:_tradeProcessSuccessCallback
               tradeProcessFailedCallback:_tradeProcessFailedCallback];
    }
    
    //调用showItemDetail
    else if (showtype == 1){
//               if([self.tfItemType.text isEqualToString:@""])
//               {
//                   NSLog(@"input is not integrity\n");
//                   [self alert:@"(*)输入参数不能为空"];
//                   return;
//               }
        
        [[TaeSDK sharedInstance] showItemDetail:self.navigationController
                                     isNeedPush:isneedpush
                              webViewUISettings:taewebViewUISettings
                                         itemId:self.tfPageItemOrder.text
                                       itemType:[self.tfItemType.text intValue]
                                         params:nil
                    tradeProcessSuccessCallback:_tradeProcessSuccessCallback
                     tradeProcessFailedCallback:_tradeProcessFailedCallback ];
    }
    
    //调用showOrder
    else if (showtype == 2){
        
//        if(([self.tfSkuId.text isEqualToString:@""])||([self.tfOrderQuantity.text isEqualToString:@""]))
//        {
//            NSLog(@"input is not integrity\n");
//            [self alert:@"(*)输入参数不能为空"];
//            return;
//        }
        
        TaeOrderItem *orderItem = [[TaeOrderItem alloc]init];
        orderItem.itemId = self.tfPageItemOrder.text;
        orderItem.skuId = self.tfSkuId.text;
        orderItem.quantity = [NSNumber numberWithInt:[self.tfOrderQuantity.text intValue]];
        
        [[TaeSDK sharedInstance] showOrder:self.navigationController
                                isNeedPush:isneedpush
                         webViewUISettings:taewebViewUISettings
                                orderItems:@[orderItem]
               tradeProcessSuccessCallback:_tradeProcessSuccessCallback
                tradeProcessFailedCallback:_tradeProcessFailedCallback];
    }
    else
    {
        NSLog(@"Error: 调用接口错误\n");
        return;
    }
    
}




-(void) alert:(NSString *)msg{
    NSLog(msg);
    [[MyAlertView alertViewWithTitle:@"提示" message:msg
                        onBtnClicked:^(int btnIndex) {
                            
                        }
                   cancelButtonTitle:@"close" otherButtonTitles:nil] show];
    
    
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tfPageItemOrder resignFirstResponder];
    [self.tfItemType resignFirstResponder];
    [self.tfSkuId resignFirstResponder];
    [self.tfOrderQuantity resignFirstResponder];
    
    [self.tfIsNeedPush resignFirstResponder];
    [self.tfTitle resignFirstResponder];
    [self.tfFontName resignFirstResponder];
    [self.tfFontSize resignFirstResponder];
    [self.tfColorX resignFirstResponder];
    [self.tfColorY resignFirstResponder];
}



#pragma TextField
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
