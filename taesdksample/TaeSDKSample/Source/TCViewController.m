//
//  TCViewController.m
//  TaeSDKTest
//
//  Created by 千醒 on 14-9-9.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import "TCViewController.h"
#import "PageItemOrderViewController.h"

@interface TCViewController ()

@end

@implementation TCViewController
{
    NSMutableArray *testCase;
    tradeProcessSuccessCallback _tradeProcessSuccessCallback;
    tradeProcessFailedCallback _tradeProcessFailedCallback;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        TCViewController * __weak weakSelf=self;
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
    // Do any additional setup after loading the view from its nib.
    
    testCase = [NSMutableArray arrayWithObjects:@"SDK初始化",@"登录授权",@"showPage",@"showItemDetail",@"showOrder",@"Logout",@"重置SDK",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [testCase count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tcViewController = @"TCViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tcViewController];
    
    // Configure the cell...
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tcViewController];
    }
    cell.textLabel.text = [testCase objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *testCell = cell.textLabel.text;
    
    //UIView animateWithDuration:7 animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>
    //    InitSDKViewController *initSDK = [[InitSDKViewController alloc]init];
    //    [self.navigationController pushViewController:initSDK animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //init SDK
            [[TaeSDK sharedInstance] asyncInit:^{
                [self alert:@"初始化成功"];
                
            } failedCallback:^(NSError *error) {
                [self alert:@"初始化失败"];
            }];
            break;
        }
        case 1:
        {
            //Login
            if(![[TaeSession sharedInstance] isLogin]){
                [[TaeSDK sharedInstance] showLogin:self.navigationController  successCallback:^(TaeSession *session) {
                    
                    NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
                    [self alert:tip];
                } failedCallback:^(NSError *error) {
                    
                    NSString *tip=[NSString stringWithFormat:@"登录失败:%@",error];
                    [self alert:tip];
                    
                }];
            }else{
                TaeSession *session=[TaeSession sharedInstance];
                NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
                [self alert:tip];
            }
            break;
        }
        case 2:
        case 3:
        case 4:
        {
            //showPage, showItemDetail, showOrder
            PageItemOrderViewController *pageItemOrderViewComtroller = [[PageItemOrderViewController alloc]init];
            [self.navigationController pushViewController:pageItemOrderViewComtroller animated:YES];
            pageItemOrderViewComtroller.title = testCell;
            break;
        }
        case 5:
        {
            //Logout
            [[TaeSDK sharedInstance] logout];
            break;
        }
        case 6:
        {
            //Reset SDK
            [TaeTest resetTaeSDKDemo];
            break;
        }
        default:
            break;
    }
    
    
}


-(void) alert:(NSString *)msg{
    NSLog(msg);
    [[MyAlertView alertViewWithTitle:@"提示" message:msg
                        onBtnClicked:^(int btnIndex) {
                            
                        }
                   cancelButtonTitle:@"close" otherButtonTitles:nil] show];
    
    
}

@end
