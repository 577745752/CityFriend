//
//  ChatViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
//正在聊天的好友的名称
@property(nonatomic,strong)NSString*friendName;
//用一个BOOL值来标记显示好友还是是群组   好友为yes
@property(nonatomic,assign)BOOL page;
//正在群聊的群名
@property(nonatomic,strong)NSString*groupName;
//聊天界面右按钮(群成员界面)
@property(nonatomic,strong)UIBarButtonItem*Right;
//用来存储群成员的数组
@property(nonatomic,strong)NSMutableArray*qunMemberArray;
@end
