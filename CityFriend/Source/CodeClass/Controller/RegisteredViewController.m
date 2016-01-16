//
//  RegisteredViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "RegisteredViewController.h"

@interface RegisteredViewController ()

@end

@implementation RegisteredViewController
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
    //滚动视图
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    scrollView.contentSize=CGSizeMake(kWidth, kHeight*1.2);
    [self.view addSubview:scrollView];
    //这里一定要用self.xxxx,代表getter方法,若是用_xxxx则是属性,不会执行getter方法
    [scrollView addSubview:self.userNameLabel];
    [scrollView addSubview:self.pswLabel];
    [scrollView addSubview:self.psw1Label];
    [scrollView addSubview:self.mailLabel];
    [scrollView addSubview:self.phoneNumberLabel];
    [scrollView addSubview:self.userNameTextField];
    [scrollView addSubview:self.pswTextField];
    [scrollView addSubview:self.psw1TextField];
    [scrollView addSubview:self.mailTextField];
    [scrollView addSubview:self.phoneNumberTextField];
    
    
}
-(UILabel*)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/10, kWidth/11, 80, 40)];
        _userNameLabel.text=@"用户名:";
        
    }
    return _userNameLabel;
}
-(UILabel*)pswLabel
{
    if (!_pswLabel) {
        _pswLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/10, kWidth/11+kGap*7, 80, 40)];
        _pswLabel.text=@"密  码:";
        
    }
    return _pswLabel;
}
-(UILabel*)psw1Label
{
    if (!_psw1Label) {
        _psw1Label=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/10, kWidth/11+kGap*14, 80, 40)];
        _psw1Label.text=@"确认密码:";
        
    }
    return _psw1Label;
}
-(UILabel*)mailLabel
{
    if (!_mailLabel) {
        _mailLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/10, kWidth/11+kGap*21, 80, 40)];
        _mailLabel.text=@"邮箱:";
        
    }
    return _mailLabel;
}
-(UILabel*)phoneNumberLabel
{
    if (!_phoneNumberLabel) {
        _phoneNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/10, kWidth/11+kGap*28, 80, 40)];
        _phoneNumberLabel.text=@"联系方式:";
        
    }
    return _phoneNumberLabel;
}
-(UITextField*)userNameTextField
{
    if (!_userNameTextField) {
        _userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(kWidth/3, kWidth/11, 200, 40)];
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
        _pswTextField=[[UITextField alloc]initWithFrame:CGRectMake(kWidth/3, kWidth/11+kGap*7, 200, 40)];
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
        _psw1TextField=[[UITextField alloc]initWithFrame:CGRectMake(kWidth/3, kWidth/11+kGap*14, 200, 40)];
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
        _mailTextField=[[UITextField alloc]initWithFrame:CGRectMake(kWidth/3, kWidth/11+kGap*21, 200, 40)];
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
        _phoneNumberTextField=[[UITextField alloc]initWithFrame:CGRectMake(kWidth/3, kWidth/11+kGap*28, 200, 40)];
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
    //
    //    NSString*library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString*preferencePath=[library stringByAppendingString:@"/Preferences"];
    //    NSLog(@"%@",preferencePath);
    //  //  NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    ////    NSDictionary*resultDictionary=[NSDictionary dictionaryWithContentsOfFile:preferencePath];
    ////    NSLog(@"%@",resultDictionary);
    ////    for (NSString*key in userDefaults) {
    ////        if ([self.userNameTextField.text isEqualToString:key]) {
    ////            // 初始化一个弹窗控制器
    ////            UIAlertController *successdController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名被占用" preferredStyle:UIAlertControllerStyleAlert];
    ////            // 设置弹窗上的按钮 ----  确认
    ////            UIAlertAction *defultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:nil];
    ////            // 设置弹窗上的按钮 --- 返回
    ////            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    ////            // 把按钮添加到弹窗的控制器上
    ////            [successdController addAction:defultAction];
    ////            [successdController addAction:cancelAction];
    ////            // 模态到弹窗的控制器上(页面的跳转)
    ////            [self presentViewController:successdController animated:YES completion:nil];
    ////
    ////        }
    ////    }
    //            NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    //    if ([userDefaults arrayForKey:self.userNameTextField.text]==nil) {
    //                    // 初始化一个弹窗控制器
    //                    UIAlertController *successdController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名被占用" preferredStyle:UIAlertControllerStyleAlert];
    //                    // 设置弹窗上的按钮 ----  确认
    //                    UIAlertAction *defultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:nil];
    //                    // 设置弹窗上的按钮 --- 返回
    //                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    //                    // 把按钮添加到弹窗的控制器上
    //                    [successdController addAction:defultAction];
    //                    [successdController addAction:cancelAction];
    //                    // 模态到弹窗的控制器上(页面的跳转)
    //                    [self presentViewController:successdController animated:YES completion:nil];
    //    }else
    if ((self.userNameTextField.text&&self.pswTextField.text)&&(self.pswTextField.text==self.psw1TextField.text)) {
        NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
        NSString*userName=self.userNameTextField.text;
        NSString*psw=self.pswTextField.text;
        NSString*mail=self.mailTextField.text;
        NSString*phoneNumber=self.phoneNumberTextField.text;
        NSMutableArray*userArray=[NSMutableArray arrayWithCapacity:4];
        [userArray addObject:userName];
        [userArray addObject:psw];
        [userArray addObject:mail];
        [userArray addObject:phoneNumber];
        [userDefaults setObject:userArray forKey:userName];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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