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
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.title=@"用户登录";
        [self drawView];
        
    }
    return self;
}
-(void)drawView
{
    //这里一定要用self.xxxx,代表getter方法,若是用_xxxx则是属性,不会执行getter方法
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.pswLabel];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.pswTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.getPasswordButton];
}
-(UILabel*)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, kHeight/6,kWidth/4,5*kGap)];
        _userNameLabel.text=@"用户名:";
        
    }
    return _userNameLabel;
}
-(UILabel*)pswLabel
{
    if (!_pswLabel) {
        _pswLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, kHeight/4+2*kGap,kWidth/4,5*kGap)];
        _pswLabel.text=@"密码:";
        
    }
    return _pswLabel;
}
-(UITextField*)userNameTextField
{
    if (!_userNameTextField) {
        _userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, kHeight/6, kWidth/2, 5*kGap)];
        _userNameTextField.placeholder=@"请输入用户名";
        _userNameTextField.layer.borderWidth=1;
        _userNameTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _userNameTextField.layer.cornerRadius=5;
        _userNameTextField.layer.masksToBounds=YES;
        _userNameTextField.alpha=0.5;
    }
    return _userNameTextField;
}
-(UITextField*)pswTextField
{
    if (!_pswTextField) {
        _pswTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, kHeight/4+2*kGap, kWidth/2, 5*kGap)];
        _pswTextField.placeholder=@"请输入密码";
        _pswTextField.layer.borderWidth=1;
        _pswTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _pswTextField.layer.cornerRadius=5;
        _pswTextField.layer.masksToBounds=YES;
        _pswTextField.secureTextEntry=YES;
        _pswTextField.alpha=0.5;
    }
    return _pswTextField;
}
-(UIButton*)loginButton{
    if (!_loginButton) {
        _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame=CGRectMake(kWidth/16, kHeight/3+7*kGap,kWidth/4, 5*kGap);
        _loginButton.layer.cornerRadius=5;
        _loginButton.layer.masksToBounds=YES;
        _loginButton.backgroundColor=[UIColor colorWithRed:164/255.0 green:203/255.0 blue:70/255.0 alpha:1];
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
-(UIButton*)registerButton{
    if (!_registerButton) {
        _registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.frame=CGRectMake(6*kWidth/16,kHeight/3+7*kGap,kWidth/4, 5*kGap);
        _registerButton.layer.cornerRadius=5;
        _registerButton.layer.masksToBounds=YES;
        _registerButton.backgroundColor=[UIColor colorWithRed:164/255.0 green:203/255.0 blue:70/255.0 alpha:1];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
-(UIButton*)getPasswordButton{
    if (!_getPasswordButton) {
        _getPasswordButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _getPasswordButton.frame=CGRectMake(11*kWidth/16, kHeight/3+7*kGap,kWidth/4, 5*kGap);
        _getPasswordButton.layer.cornerRadius=5;
        _getPasswordButton.layer.masksToBounds=YES;
        _getPasswordButton.backgroundColor=[UIColor colorWithRed:164/255.0 green:203/255.0 blue:70/255.0 alpha:1];
        [_getPasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
        [_getPasswordButton addTarget:self action:@selector(getPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getPasswordButton;
}
-(void)login:(UIButton*)button
{

    [AVUser logInWithUsernameInBackground:_userNameTextField.text password:_pswTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登陆成功");
            [self initDataBase];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"登陆失败");
        }
    }];
}
//初始化数据库,建表操作
-(void)initDataBase
{
    NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
    DataBaseTool*db=[DataBaseTool shareDataBase];
    //连接数据库
    [db connectDB:dataBasePath];
    //建表
    [db execDDLSql:[NSString stringWithFormat:@"create table if not exists %@_friends(\
                    friendname text not null,\
                    groupname text not null,\
                    primary key \(friendname)\
                    )",[AVUser currentUser].username]];
    [db disconnectDB];
    NSLog(@"%@",dataBasePath);
}

-(void)registerAction:(UIButton*)button
{
    RegisterViewController*regist=[RegisterViewController new];
    [self.navigationController pushViewController:regist animated:YES];
}
-(void)getPasswordAction:(UIButton*)button
{
    GetBackPwdViewController*getBackPwdVC=[GetBackPwdViewController new];
    [self.navigationController pushViewController:getBackPwdVC animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
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
