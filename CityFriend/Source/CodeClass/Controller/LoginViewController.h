//
//  LoginViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController
@property(nonatomic,strong)UILabel*userNameLabel;
@property(nonatomic,strong)UILabel*pswLabel;
@property(nonatomic,strong)UITextField*userNameTextField;
@property(nonatomic,strong)UITextField*pswTextField;
@property(nonatomic,strong)UIButton*loginButton;
@property(nonatomic,strong)UIButton*registerButton;
@property(nonatomic,strong)UIButton*getPasswordButton;
@end
