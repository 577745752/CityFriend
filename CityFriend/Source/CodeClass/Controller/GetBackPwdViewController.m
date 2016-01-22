//
//  GetBackPwdViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "GetBackPwdViewController.h"

@interface GetBackPwdViewController ()

@end

@implementation GetBackPwdViewController
-(instancetype)init
{
    if (self=[super init]) {
        [self drawView];
    }
    return self;
}
-(void)drawView
{
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.getButton];
}
-(UITextField*)emailTextField
{
    if (!_emailTextField) {
        _emailTextField=[[UITextField alloc]initWithFrame:CGRectMake(5*kGap,64+5*kGap , kWidth-10*kGap, 10*kGap)];
        _emailTextField.placeholder=@"请输入邮箱";
        _emailTextField.layer.borderWidth=1;
        _emailTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _emailTextField.layer.cornerRadius=5;
        _emailTextField.layer.masksToBounds=YES;
        _emailTextField.alpha=0.5;
    }
    return _emailTextField;
}
-(UIButton*)getButton{
    if (!_getButton) {
        _getButton=[UIButton buttonWithType:UIButtonTypeSystem];
        _getButton.frame=CGRectMake(5*kGap,64+ 20*kGap, 10*kGap, 5*kGap);
        [_getButton setTitle:@"找回" forState:UIControlStateNormal];
        [_getButton addTarget:self action:@selector(getButtonAction:) forControlEvents:UIControlEventTouchUpInside ];
    }
    return _getButton;
}
-(void)getButtonAction:(UIButton*)button
{
    [AVUser requestPasswordResetForEmailInBackground:self.emailTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"666666");
        } else {
            
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
