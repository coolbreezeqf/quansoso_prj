//
//  QSFeedBackViewController.m
//  Quansoso
//
//  Created by qf on 14/11/22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSFeedBackViewController.h"

@interface QSFeedBackViewController ()<UITextViewDelegate>{
	UITextField *numberTf;
	UITextView *contentView;
	UILabel *tipLabel;
}

@end

@implementation QSFeedBackViewController

- (void)setUI{
	numberTf = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, kMainScreenWidth-40, 40)];
	numberTf.placeholder = @"QQ、Email或手机号码";
	numberTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	numberTf.layer.cornerRadius = 5;
	numberTf.layer.borderColor = [UIColor lightGrayColor].CGColor;
	numberTf.layer.borderWidth = 1;
	UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
	leftlabel.text = @" ";
	leftlabel.backgroundColor = [UIColor clearColor];
	numberTf.leftView = leftlabel;
	numberTf.leftViewMode = UITextFieldViewModeAlways;
	[numberTf becomeFirstResponder];
	[self.view addSubview:numberTf];
	
	contentView = [[UITextView alloc] initWithFrame:CGRectMake(20, numberTf.bottom+10, kMainScreenWidth-40, self.view.bounds.size.height - numberTf.bottom - 64 - 30)];
	contentView.backgroundColor = [UIColor clearColor];
	contentView.font = kFont13;
	contentView.layer.cornerRadius = 5;
	contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	contentView.layer.borderWidth = 1;
	contentView.delegate = self;
	[self.view addSubview:contentView];
	
	tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, contentView.top, kMainScreenWidth - 50, 30)];
	tipLabel.enabled = NO;
	tipLabel.backgroundColor = [UIColor clearColor];
	tipLabel.textColor = [UIColor lightGrayColor];
	tipLabel.text = @"您的建议对我们至关重要，谢谢！";
	[self.view addSubview:tipLabel];
}

- (void)textViewDidChange:(UITextView *)textView{
	if (textView.text.length == 0) {
		tipLabel.text = @"您的建议对我们至关重要，谢谢！";
	}else{
		tipLabel.text = @"";
	}
}

- (void)sendFeedback{
	MLOG(@"sendFeedback");
}

- (void)keyboardWillShow:(NSNotification *)notification{
	NSDictionary *info = [notification userInfo];
	//获取高度
	NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
	CGSize hightSize = [value CGRectValue].size;
	contentView.height = self.view.height - hightSize.height - numberTf.bottom - 20;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"反馈建议";
	self.view.backgroundColor = RGBCOLOR(242, 239, 233);
	[self setUI];
	UIButton *sendBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
	[sendBt addTarget:self action:@selector(sendFeedback) forControlEvents:UIControlEventTouchDown];
	[sendBt setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBt];
	//初始化键盘通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
