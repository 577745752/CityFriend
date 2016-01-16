//
//  LoginViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *userNamelabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/6, kHeight/8,kWidth/6,3*kGap)];
    userNamelabel.text=@"用户名";
    userNamelabel.layer.cornerRadius=10;
    userNamelabel.layer.masksToBounds=YES;
    [self.view addSubview:userNamelabel];
    UITextField *userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(kWidth/3+5*kGap, kHeight/8, kWidth/3,3*kGap)];
    userNameTextField.borderStyle=UITextBorderStyleRoundedRect;
    userNameTextField.placeholder=@"请输入用户名";
    userNameTextField.layer.cornerRadius=10;
    userNameTextField.layer.masksToBounds=YES;
    [self.view addSubview:userNameTextField];
    
    UILabel *pswLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/6, kHeight/5,kWidth/6,3*kGap)];
    pswLabel.text=@"密码";
    pswLabel.layer.cornerRadius=10;
    pswLabel.layer.masksToBounds=YES;
    [self.view addSubview:pswLabel];
    
    UITextField *pswTextField=[[UITextField alloc]initWithFrame:CGRectMake(kWidth/3+5*kGap, kHeight/5,kWidth/3,3*kGap)];
    pswTextField.borderStyle=UITextBorderStyleRoundedRect;
    pswTextField.placeholder=@"请输入密码";
    pswTextField.layer.cornerRadius=10;
    pswTextField.layer.masksToBounds=YES;
    [self.view addSubview:pswTextField];
    
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame=CGRectMake(kWidth/6+kGap, kHeight/4+2*kGap, 6*kGap, 4*kGap);
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton addTarget:self.parentViewController action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    UIButton *getPasswordButton=[UIButton buttonWithType:UIButtonTypeSystem];
    getPasswordButton.frame =CGRectMake(kWidth/3+2.5*kGap, kHeight/4+2*kGap, 8*kGap, 4*kGap);
    [getPasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [getPasswordButton addTarget:self action:@selector(changeTion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getPasswordButton];
    
    UIButton *registerButton=[UIButton buttonWithType:UIButtonTypeSystem];
   registerButton.frame=CGRectMake(kWidth/2+6*kGap, kHeight/4+2*kGap, 6*kGap, 4*kGap);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}

-(void)changePage:(UIButton *)button
{
    
    
}
-(void)changeTion:(UIButton *)utton
{
    
    
}
-(void)changeAction:(UIButton *)button
{
    RegisteredViewController *regist=[RegisteredViewController new];
    [self.navigationController pushViewController:regist animated:YES];
    
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
