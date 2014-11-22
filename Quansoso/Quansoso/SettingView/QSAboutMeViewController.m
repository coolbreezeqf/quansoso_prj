//
//  QSAboutMeViewController.m
//  Quansoso
//
//  Created by qf on 14/11/22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSAboutMeViewController.h"

@interface QSAboutMeViewController ()

@end

@implementation QSAboutMeViewController

- (void)showUI{
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QSSicon"]];
	imageView.frame = CGRectMake(0, 0, 70, 70);
	imageView.center = CGPointMake(kMainScreenWidth/2, 90);
	[self.view addSubview:imageView];
	
	UILabel *versionLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
	versionLb.text = @"券搜搜 v1.0.0";
	versionLb.textAlignment = NSTextAlignmentCenter;
	versionLb.textColor = RGBCOLOR(129, 199, 47);
	versionLb.backgroundColor = [UIColor clearColor];
	versionLb.center = CGPointMake(imageView.centerX, imageView.centerY+70);
	[self.view addSubview:versionLb];
	
	UIView *fgx = [[UIView alloc] initWithFrame:CGRectMake(0, versionLb.bottom+40, kMainScreenWidth, 1)];
	fgx.backgroundColor = RGBCOLOR(129, 199, 47);
	[self.view addSubview:fgx];
	
	UIImageView *contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutMe"]];
	contentView.frame = CGRectMake(0, 0, 194, 74);
	contentView.center = CGPointMake(kMainScreenWidth/2, fgx.bottom+90);
	[self.view addSubview:contentView];
	
	UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 291, 140)];
	bkView.backgroundColor = [UIColor clearColor];
	bkView.center = contentView.center;
	bkView.layer.cornerRadius = 5;
	bkView.layer.borderWidth = 1;
	bkView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	[self.view addSubview:bkView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"关于我们";
	self.view.backgroundColor = [UIColor whiteColor];
	[self showUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
