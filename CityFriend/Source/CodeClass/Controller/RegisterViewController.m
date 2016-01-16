//
//  RegisterViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(register1:)];
        self.navigationItem.title=@"注册";
        [self drawView];
        
    }
    return self;
}
-(void)drawView
{
    //这里一定要用self.xxxx,代表getter方法,若是用_xxxx则是属性,不会执行getter方法
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.pswLabel];
    [self.view addSubview:self.psw1Label];
    [self.view addSubview:self.mailLabel];
    [self.view addSubview:self.phoneNumberLabel];
    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.pswTextField];
    [self.view addSubview:self.psw1TextField];
    [self.view addSubview:self.mailTextField];
    [self.view addSubview:self.phoneNumberTextField];
    
    
}
-(UILabel*)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 12*kGap,kWidth/4,5*kGap)];
        _userNameLabel.text=@"用户名:";
        
    }
    return _userNameLabel;
}
-(UILabel*)pswLabel
{
    if (!_pswLabel) {
        _pswLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 20*kGap,kWidth/4,5*kGap)];
        _pswLabel.text=@"密  码:";
        
    }
    return _pswLabel;
}
-(UILabel*)psw1Label
{
    if (!_psw1Label) {
        _psw1Label=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 28*kGap,kWidth/4,5*kGap)];
        _psw1Label.text=@"确认密码:";
        
    }
    return _psw1Label;
}
-(UILabel*)mailLabel
{
    if (!_mailLabel) {
        _mailLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 36*kGap,kWidth/4,5*kGap)];
        _mailLabel.text=@"邮箱:";
        
    }
    return _mailLabel;
}
-(UILabel*)phoneNumberLabel
{
    if (!_phoneNumberLabel) {
        _phoneNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 44*kGap,kWidth/4,5*kGap)];
        _phoneNumberLabel.text=@"联系方式:";
        
    }
    return _phoneNumberLabel;
}
-(UITextField*)userNameTextField
{
    if (!_userNameTextField) {
        _userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 12*kGap, kWidth/2, 5*kGap)];
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
        _pswTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 20*kGap, kWidth/2, 5*kGap)];
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
-(UITextField*)psw1TextField
{
    if (!_psw1TextField) {
        _psw1TextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 28*kGap, kWidth/2, 5*kGap)];
        _psw1TextField.placeholder=@"再次输入密码";
        _psw1TextField.layer.borderWidth=1;
        _psw1TextField.layer.borderColor=[UIColor grayColor].CGColor;
        _psw1TextField.layer.cornerRadius=5;
        _psw1TextField.layer.masksToBounds=YES;
        _psw1TextField.secureTextEntry=YES;
        _psw1TextField.alpha=0.5;
    }
    return _psw1TextField;
}
-(UITextField*)mailTextField
{
    if (!_mailTextField) {
        _mailTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 36*kGap, kWidth/2, 5*kGap)];
        _mailTextField.placeholder=@"请输入邮箱";
        _mailTextField.layer.borderWidth=1;
        _mailTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _mailTextField.layer.cornerRadius=5;
        _mailTextField.layer.masksToBounds=YES;
        _mailTextField.alpha=0.5;
    }
    return _mailTextField;
}
-(UITextField*)phoneNumberTextField
{
    if (!_phoneNumberTextField) {
        _phoneNumberTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 44*kGap, kWidth/2, 5*kGap)];
        _phoneNumberTextField.placeholder=@"请输入联系方式";
        _phoneNumberTextField.layer.borderWidth=1;
        _phoneNumberTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _phoneNumberTextField.layer.cornerRadius=5;
        _phoneNumberTextField.layer.masksToBounds=YES;
        _phoneNumberTextField.alpha=0.5;
        _phoneNumberTextField.keyboardType=UIKeyboardTypeNumberPad;
    }
    return _phoneNumberTextField;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)register1:(UIBarButtonItem*)item
{
    
    
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
