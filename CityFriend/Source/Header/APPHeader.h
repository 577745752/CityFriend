//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h
//第一个界面
#import "HomeViewController.h"

#import "LocationViewController.h"
#import "LocationCollectionViewCell.h"
#import "LocationCollectionReusableView.h"

#import "ClassificationCollectionViewCell.h"
#import "ClassificationCollectionReusableView.h"



#import "ShopTableViewController.h"
#import "ShopTableViewCell.h"
#import "Shop.h"

//第二个界面
#import "ActivityViewController.h"
//第三个界面
#import "FriendViewController.h"
//第四个界面
#import "UserTableViewController.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"



#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kGap kWidth/50

#endif
