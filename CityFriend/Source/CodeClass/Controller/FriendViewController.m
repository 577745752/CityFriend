//
//  FriendViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()<UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>
//好友界面右按钮
@property(nonatomic,strong)UIBarButtonItem*friendRight;
//群界面右按钮加群
@property(nonatomic,strong)UIBarButtonItem*joinQunRight;
//群界面右按钮建群
@property(nonatomic,strong)UIBarButtonItem*setQunRight;
//提示登陆的背景视图
@property(nonatomic,strong)HintLoginView*loginBackView;
//提示登陆按钮
@property(nonatomic,strong)UIButton*loginButton;
//提示注册按钮
@property(nonatomic,strong)UIButton*registerButton;
//好友或者群组的底视图
@property(nonatomic,strong)UIView*headerView;
//好友
@property(nonatomic,strong)UIButton*friendButton;
//群组
@property(nonatomic,strong)UIButton*qunButton;
//显示好友的tableView(和群组共用)
@property(nonatomic,strong)UITableView*friendTableView;
//用来记录要添加好友的id
@property(nonatomic,strong)NSString*addFriendId;
//用来记录要添加好友的分组
@property(nonatomic,strong)NSString*addFriendGroup;
//聊天 相关属性
@property (nonatomic, strong) AVIMClient *client;
//用来存储好友列表的数组
@property(nonatomic,strong)NSMutableArray*friendsArray;
//用来存储好友分组的数组
@property(nonatomic,strong)NSMutableArray*groupArray;
//用来存储群列表的数组
@property(nonatomic,strong)NSMutableArray*qunArray;
//用字典来存储某个分组的状态是展开还是关闭
@property(nonatomic,strong)NSMutableDictionary*foldDict;
//用一个BOOL值来标记显示好友还是是群组   好友为yes
@property(nonatomic,assign)BOOL page;
@end

static NSString*const cellID=@"cell";
@implementation FriendViewController
//初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title=@"好友";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"好友" image:[UIImage imageNamed:@"3"] selectedImage:[UIImage imageNamed:@"3"]];
        self.friendRight=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(friendRightClick:)];
        self.setQunRight=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(setQun:)];
        self.joinQunRight=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(joinQun:)];
  
        //默认显示好友界面
        self.page=YES;
        //如果用户已经登录,就开始接受信息
        if ([AVUser currentUser]!=nil) {
             [self ReceiveMessage];
        }
       
    }
    return self;
}
-(void)friendRightClick:(UIBarButtonItem*)item
{
    if (self.page) {//好友界面
        //点击弹窗
        UIAlertController*friendName=[UIAlertController alertControllerWithTitle:@"" message:@"请输入要添加的好友id" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"确认添加" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //获取要添加的用户id
            UITextField*text=(UITextField*)[friendName.view viewWithTag:105];
            self.addFriendId=text.text;
            //在user表中查询用户是否存在
            AVQuery *query = [AVUser query];
            [query whereKey:@"username" equalTo:text.text];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error == nil) {
                    //如果返回的用户数组不为空
                    if ([objects count]) {
                        //接下来要判断要添加的用户是否已经是好友了
                        BOOL friend=NO;
                        for (NSArray*array in self.friendsArray) {
                            for (NSString*string in array) {
                                if ([text.text isEqualToString:string]) {
                                    friend=YES;
                                }
                            }
                        }
                        if (friend) {
                            //已经是好友了
                            UIAlertController*yijingshihaoyou=[UIAlertController alertControllerWithTitle:@"提示" message:@"你们已经是好友了" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction*zhidaole=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            }];
                            [yijingshihaoyou addAction:zhidaole];
                            [self presentViewController:yijingshihaoyou animated:YES completion:nil];
                        }else{
                            //向对方发送添加好友的请求(这里实际上是给对方发送一条消息)
                            [self SendMessage:[NSString stringWithFormat:@"%@想添加你为好友>_<",[AVUser currentUser].username]toUserName:text.text];
                        }
                    }else{
                        NSLog(@"用户不存在");
                    }
                } else {
                    NSLog(@"%@",error);
                }
            }];
        }];
        UIAlertAction*no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [friendName addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请输入好友id";
            textField.tag=105;
        }];
        [friendName addAction:no];
        [friendName addAction:ok];
        [self presentViewController:friendName animated:YES completion:nil];
    }else{
        //群组界面
    }
}
-(void)setQun:(UIBarButtonItem*)item
{
//    //向本地数据库中添加数据
//    NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
//    DataBaseTool*db=[DataBaseTool shareDataBase];
//    //连接数据库
//    [db connectDB:dataBasePath];
//    //建表
//
//    [db disconnectDB];
//    NSLog(@"%@",dataBasePath);
    

//    //刷新数据
//    [self loadDataOfFriends];
    UIAlertController*setQun=[UIAlertController alertControllerWithTitle:@"" message:@"请输入群id" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //获取要要创建的群的id
        UITextField*text=(UITextField*)[setQun.view viewWithTag:107];
        //在群表中查询群id是否已经存在
        AVQuery *query = [AVQuery queryWithClassName:@"Qun"];
        [query whereKey:@"qunname" equalTo:text.text];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error == nil) {
                //如果返回的用户数组不为空,说明该群名称已经存在了
                if ([objects count]) {
                        UIAlertController*qunmingbeizhanyong=[UIAlertController alertControllerWithTitle:@"提示" message:@"群名称已经被占用了" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction*zhidaole=[UIAlertAction actionWithTitle:@"哥乌恩滚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        [qunmingbeizhanyong addAction:zhidaole];
                        [self presentViewController:qunmingbeizhanyong animated:YES completion:nil];
                }else{//如果返回的用户数组为空,才可以创建
                    //向云端服务器表中添加数据(更新群表)
                    AVObject *post = [AVObject objectWithClassName:@"Qun"];
//                    [post setObject:[AVUser currentUser].username forKey:@"username"];
                    [post setObject:[AVUser currentUser].username forKey:@"admin"];
                    [post setObject:text.text forKey:@"qunname"];
                    [post setObject:[NSNumber numberWithInt:1] forKey:@"numberofqun"]; //初始值为 1,用计数器来存储当前群组的成员人数
                    [post addObjectsFromArray:[NSArray arrayWithObjects:[AVUser currentUser].username, nil] forKey:@"member"];//用数组来存储群成员
                    [post save];        //刷新数据
                    
                    //在本地数据库中建立群聊天记录表
                    NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                    NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
                    DataBaseTool*db=[DataBaseTool shareDataBase];
                    //连接数据库
                    [db connectDB:dataBasePath];
                    //建表
                    [db execDDLSql:[NSString stringWithFormat:@"create table if not exists %@_qun_%@(\
                                    name text not null,\
                                    content text not null,\
                                    time text not null\
                                    )",[AVUser currentUser].username,text.text]];
                    [db disconnectDB];
                    NSLog(@"%@",dataBasePath);

                    
                    
                    
                    
                    
                    
                    [self loadDataOfGroup];
                }
            } else {
                NSLog(@"%@",error);
            }
        }];

    }];
    UIAlertAction*no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [setQun addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输群id";
        textField.tag=107;
    }];
    
    [setQun addAction:no];
    [setQun addAction:ok];
    [self presentViewController:setQun animated:YES completion:nil];

}
-(void)joinQun:(UIBarButtonItem*)item
{
    UIAlertController*joinQun=[UIAlertController alertControllerWithTitle:@"" message:@"请输入群id" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //获取要要创建的群的id
        UITextField*text=(UITextField*)[joinQun.view viewWithTag:108];
        //在群表中查询群id是否存在
        AVQuery *query = [AVQuery queryWithClassName:@"Qun"];
        [query whereKey:@"qunname" equalTo:text.text];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error == nil) {
                //如果返回的用户数组不为空,说明该群名称已经存在了
                if ([objects count]) {
                    //首先要知道群主是谁
                    NSString*admin=[objects[0] valueForKey:@"admin"];
                   //向群主申请加入该群,给群主发送申请信息
                    [self SendMessage:[NSString stringWithFormat:@"%@/%@/>_<想要入伙>_<",[AVUser currentUser].username,text.text] toUserName:admin];
                }else{//要加的群不存在
                    UIAlertController*qunmingbeizhanyong=[UIAlertController alertControllerWithTitle:@"提示" message:@"您输入的群不存在" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*zhidaole=[UIAlertAction actionWithTitle:@"哥乌恩滚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [qunmingbeizhanyong addAction:zhidaole];
                    [self presentViewController:qunmingbeizhanyong animated:YES completion:nil];
                }
            } else {
                NSLog(@"%@",error);
            }
        }];
        
    }];
    UIAlertAction*no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [joinQun addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输群id";
        textField.tag=108;
    }];
    
    [joinQun addAction:no];
    [joinQun addAction:ok];
    [self presentViewController:joinQun animated:YES completion:nil];
}
// 添加好友的方法(实际上是用了发送消息的方法)
-(void)SendMessage:(NSString*)message toUserName:(NSString*)username{
    // 首先 创建了一个 client 来发送消息
    self.client = [[AVIMClient alloc] init];
    //用户登陆状态
    AVUser *currentUser = [AVUser currentUser];
    // 用自己的名字作为 ClientId 打开 client
    [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
        // "我" 建立了与 "对方" 的会话
        [self.client createConversationWithName:@"请求" clientIds:@[username] callback:^(AVIMConversation *conversation, NSError *error) {
            // 我 发了一条消息给 对方
            [conversation sendMessage:[AVIMTextMessage messageWithText:message attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"发送成功！");
                }
            }];
        }];
    }];
}
//- (void)SendMessage{
//    // 首先 创建了一个 client 来发送消息
//    self.client = [[AVIMClient alloc] init];
//    //用户登陆状态
//    AVUser *currentUser = [AVUser currentUser];
//
//    // 用自己的名字作为 ClientId 打开 client
//    [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
//        // "我" 建立了与 "对方" 的会话
//        [self.client createConversationWithName:@"好友请求" clientIds:@[self.addFriendId] callback:^(AVIMConversation *conversation, NSError *error) {
//            // 我 发了一条消息给 对方
//            [conversation sendMessage:[AVIMTextMessage messageWithText:currentUser.username attributes:nil] callback:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    NSLog(@"发送成功！");
//                }
//            }];
//        }];
//    }];
//}
//接收消息
- (void)ReceiveMessage{
    // 用户 创建了一个 client 来接收消息
    self.client = [[AVIMClient alloc] init];
    //用户登陆状态
    AVUser *currentUser = [AVUser currentUser];
    // 设置 client 的 delegate，并实现 delegate 方法
    self.client.delegate = self;
    
    // 用户 用自己的名字作为 ClientId 打开了 client
    [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
        // ...
    }];
    NSLog(@"好友页面正在接收消息");
}

#pragma mark - AVIMClientDelegate

// 接收消息的回调函数

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    //判断接收到的消息是否是好友请求
    if ([message.text hasSuffix:@"想添加你为好友>_<"]) {//好友请求的处理
        //截取对方的id
        NSString*idString=[[message.text componentsSeparatedByString:@"想"] firstObject];
        UIAlertController*getFriend=[UIAlertController alertControllerWithTitle:@"" message:message.text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //东八区时间
            //            NSDate*bjdate=[NSDate dateWithTimeIntervalSinceNow:8*60*60];//+8*6*60
            //            NSString*time=(NSString*)bjdate;
            //获取要添加的用户分组
            UITextField*text=(UITextField*)[getFriend.view viewWithTag:106];
            self.addFriendGroup=text.text;
            //向本地数据库中添加数据
            NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
            DataBaseTool*db=[DataBaseTool shareDataBase];
            //连接数据库
            [db connectDB:dataBasePath];
            //建表
            [db execDDLSql:[NSString stringWithFormat:@"create table if not exists %@_%@(\
                            name text not null,\
                            content text not null,\
                            time text not null\
                            )",[AVUser currentUser].username,idString]];
            [db disconnectDB];
            NSLog(@"%@",dataBasePath);
            //向云端服务器表中添加数据(更新好友表)
            AVObject *post = [AVObject objectWithClassName:@"Friends"];
            [post setObject:[AVUser currentUser].username forKey:@"username"];
            [post setObject:idString forKey:@"friendname"];
            [post setObject:self.addFriendGroup forKey:@"groupname"];
            [post save];
            //刷新数据
            [self loadDataOfFriends];
            
            //给请求添加我为好友的用户返回同意添加的结果(让对方同时成功也添加我为好友)
            [self SendMessage:[NSString stringWithFormat:@"%@已经通过了你的好友请求>_<",[AVUser currentUser].username]toUserName:idString];
        }];
        UIAlertAction*no=[UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [getFriend addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请输入分组名";
            textField.tag=106;
        }];
        
        [getFriend addAction:no];
        [getFriend addAction:ok];
        [self presentViewController:getFriend animated:YES completion:nil];
    }else if([message.text hasSuffix:@"已经通过了你的好友请求>_<"]){//对方通过你的好友请求的消息处理
        //截取对方的id
        NSString*idString=[[message.text componentsSeparatedByString:@"已经"] firstObject];
        UIAlertController*getFriend=[UIAlertController alertControllerWithTitle:@"" message:message.text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"搜嘎" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //获取要添加的用户分组
            UITextField*text=(UITextField*)[getFriend.view viewWithTag:107];
            self.addFriendGroup=text.text;
            //向本地数据库中添加数据
            NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
            DataBaseTool*db=[DataBaseTool shareDataBase];
            //连接数据库
            [db connectDB:dataBasePath];
            //建表
            [db execDDLSql:[NSString stringWithFormat:@"create table if not exists %@_%@(\
                            name text not null,\
                            content text not null,\
                            time text not null\
                            )",[AVUser currentUser].username,idString]];
            [db disconnectDB];
            NSLog(@"%@",dataBasePath);
            //向云端服务器表中添加数据(更新好友表)
            AVObject *post = [AVObject objectWithClassName:@"Friends"];
            [post setObject:[AVUser currentUser].username forKey:@"username"];
            [post setObject:idString forKey:@"friendname"];
            [post setObject:self.addFriendGroup forKey:@"groupname"];
            [post save];
            //刷新数据
            [self loadDataOfFriends];
        }];
        [getFriend addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请输入分组名";
            textField.tag=107;
        }];
        [getFriend addAction:ok];
        [self presentViewController:getFriend animated:YES completion:nil];
    }else if ([message.text hasSuffix:@">_<想要入伙>_<"]){
        //截取对方的id和想要加入的群
        NSString*idString=[[message.text componentsSeparatedByString:@"/"] firstObject];
        NSString*qunname=[message.text componentsSeparatedByString:@"/"][1];
        UIAlertController*receiveMember=[UIAlertController alertControllerWithTitle:qunname message:[NSString stringWithFormat:@"报告公明哥哥:山下有个自称%@的黑脸汉子前来入伙",idString] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //更新之前需要先查询本条记录的objectId(每个表中每条记录的objectId都是唯一的)
            AVQuery *query = [AVQuery queryWithClassName:@"Qun"];
            [query whereKey:@"qunname" equalTo:qunname];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // 检索成功
                    NSString*objectId=[objects[0] valueForKey:@"objectId"];
                    //向云端服务器表中更新数据(更新群表)
                    // 知道 objectId，创建 AVObject
                    AVObject *post = [AVObject objectWithoutDataWithClassName:@"Qun" objectId:objectId];
                    //更新群成员数组字段的记录
                    [post addObjectsFromArray:[NSArray arrayWithObjects:idString, nil] forKey:@"member"];
//                    [post setObject:@"http://tp1.sinaimg.cn/3652761852/50/5730347813/0" forKey:@"pubUserAvatar"];
                    [post incrementKey:@"numberofqun"];//计数器计数一次
                    //保存
                    [post saveInBackground];
                    //刷新数据
                    [self loadDataOfGroup];
                    //给请求入伙的用户返回同意添加的结果
                    [self SendMessage:[NSString stringWithFormat:@">_<同意你加入大保健团伙>_</%@/%@",[AVUser currentUser].username,qunname]toUserName:idString];
                } else {
                    // 输出错误信息
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }];
        UIAlertAction*no=[UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [receiveMember addAction:no];
        [receiveMember addAction:ok];
        [self presentViewController:receiveMember animated:YES completion:nil];
        } else if([message.text hasPrefix:@">_<同意你加入大保健团伙>_<"]){
            //获取群主id
            NSString*idString=[message.text componentsSeparatedByString:@"/"][1];
            //获取已经加入的群名称
            NSString*qunname=[[message.text componentsSeparatedByString:@"/"] lastObject];
            UIAlertController*intoQun=[UIAlertController alertControllerWithTitle:qunname message:@"你已经成功加入了大保健团伙" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*ok=[UIAlertAction actionWithTitle:@"搜嘎" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //在本地数据库中建立群聊天记录表
                NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
                DataBaseTool*db=[DataBaseTool shareDataBase];
                //连接数据库
                [db connectDB:dataBasePath];
                //建表
                [db execDDLSql:[NSString stringWithFormat:@"create table if not exists %@_qun_%@(\
                                name text not null,\
                                content text not null,\
                                time text not null\
                                )",[AVUser currentUser].username,qunname]];
                [db disconnectDB];
                NSLog(@"%@",dataBasePath);
                //刷新数据
                [self loadDataOfGroup];
            }];
            [intoQun addAction:ok];
            [self presentViewController:intoQun animated:YES completion:nil];
        }else if([conversation.name hasPrefix:@"群聊"]){
            //获取是哪个群发的消息
            NSString*qunname=[[conversation.name componentsSeparatedByString:@"群聊"] lastObject];
            //东八区时间
            NSDate*bjdate=[NSDate dateWithTimeIntervalSinceNow:8*60*60];//+8*6*60
            NSString*time=(NSString*)bjdate;
            //NSString*time1=[[time componentsSeparatedByString:@"+"] firstObject];
            //向本地数据库中添加数据
            NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
            DataBaseTool*db=[DataBaseTool shareDataBase];
            //连接数据库
            [db connectDB:dataBasePath];
            //更新本地数据库的聊天记录
            //        Chat*chat=[Chat new];
            //        chat.name=conversation.creator;
            //        chat.content=message.text;
            //        chat.time=@"time";
            //        NSLog(@"%@",[NSString stringWithFormat:@"%@_%@",[AVUser currentUser].username,conversation.creator]);
            //        [db insertToTable:[NSString stringWithFormat:@"%@_%@",[AVUser currentUser].username,conversation.creator] WithChat:chat];
            [db execDMLSql:[NSString stringWithFormat:@"INSERT INTO %@_qun_%@ VALUES ('%@','%@','%@')",[AVUser currentUser].username,qunname,conversation.creator,message.text,time]];
            [db disconnectDB];
            NSLog(@"%@",dataBasePath);
            //广播通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Message" object:nil userInfo:@{@"群":qunname}];

        
        
        
        
        }else{
        /*
         //正常聊天
         NSLog(@"接收到消息了");
         NSLog(@"%@",message.text);
         //正常聊天
         //我 用自己的名字作为 ClientId 打开 client
         [self.client openWithClientId:[AVUser currentUser].username callback:^(BOOL succeeded, NSError *error) {
         // 我 创建查询会话的 query
         AVIMConversationQuery *query = [self.client conversationQuery];
         // Tom 获取 id 为 2f08e882f2a11ef07902eeb510d4223b 的会话
         [query getConversationById:conversation.conversationId callback:^(AVIMConversation *conversation, NSError *error) {
         // 查询对话中最后 10 条消息
         [conversation queryMessagesWithLimit:10 callback:^(NSArray *objects, NSError *error) {
         
         for (AVIMTextMessage * msg in objects) {
         NSString * str = [msg text];
         }
         
         
         NSLog(@"%@", [[objects[0] class] description]);
         NSLog(@"%@",[objects[0] text]);
         //AVIMTextMessage
         NSLog(@"查询成功！");
         }];
         }];
         }];
         */
        //东八区时间
        NSDate*bjdate=[NSDate dateWithTimeIntervalSinceNow:8*60*60];//+8*6*60
        NSString*time=(NSString*)bjdate;
        //NSString*time1=[[time componentsSeparatedByString:@"+"] firstObject];
        //向本地数据库中添加数据
        NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
        DataBaseTool*db=[DataBaseTool shareDataBase];
        //连接数据库
        [db connectDB:dataBasePath];
        //更新本地数据库的聊天记录
        //        Chat*chat=[Chat new];
        //        chat.name=conversation.creator;
        //        chat.content=message.text;
        //        chat.time=@"time";
        //        NSLog(@"%@",[NSString stringWithFormat:@"%@_%@",[AVUser currentUser].username,conversation.creator]);
        //        [db insertToTable:[NSString stringWithFormat:@"%@_%@",[AVUser currentUser].username,conversation.creator] WithChat:chat];
        [db execDMLSql:[NSString stringWithFormat:@"INSERT INTO %@_%@ VALUES ('%@','%@','%@')",[AVUser currentUser].username,conversation.creator,conversation.creator,message.text,time]];
        [db disconnectDB];
        NSLog(@"%@",dataBasePath);
        //广播通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Message" object:nil userInfo:@{@"1":@"1"}];
    }
    
}

//- (void)conversation:(AVIMConversation *)conversation onDidReceiveTypedMessage:(AVIMTypedMessage *)message
//{
//
//}


-(void)viewWillAppear:(BOOL)animated
{
    //    if ([AVUser currentUser] == nil) {
    //
    //        [self.view bringSubviewToFront:self.loginBackView];
    //    }else{
    //        [self.view sendSubviewToBack:self.loginBackView];
    //        //刷新ui
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self.friendTableView reloadData];
    //        });
    //    }
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([AVUser currentUser] == nil) {
        [self.view addSubview:self.loginBackView];
    }else{
        [self.view addSubview:self.headerView];
        
#pragma mark------------TableView
        [self.view addSubview:self.friendTableView];
        if (self.page) {
            self.navigationItem.rightBarButtonItems = @[self.friendRight];
            [self loadDataOfFriends];
        }else{
            self.navigationItem.rightBarButtonItems=@[self.joinQunRight,self.setQunRight];
            [self loadDataOfGroup];
        }
        //        [[ReceiveMessageTool shareIFlyManager] addDelegateReceiveMessageTool:self delegateQueue:dispatch_get_main_queue()];
        [self ReceiveMessage];
    }
    // Do any additional setup after loading the view.
}
-(HintLoginView*)loginBackView
{
    if (!_loginBackView) {
        _loginBackView=[[HintLoginView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_loginBackView addSubview:self.loginButton];
        [_loginBackView addSubview:self.registerButton];
    }
    return _loginBackView;
}
-(UIButton*)loginButton
{
    if (!_loginButton) {
        _loginButton=[UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.frame=CGRectMake(10*kGap, 2*kHeight/3, 10*kGap, 5*kGap);
        _loginButton.layer.cornerRadius=5;
        _loginButton.layer.masksToBounds=YES;
        _loginButton.backgroundColor=[UIColor colorWithRed:164/255.0 green:203/255.0 blue:70/255.0 alpha:1];
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginButton;
}
-(UIButton*)registerButton
{
    if (!_registerButton) {
        _registerButton=[UIButton buttonWithType:UIButtonTypeSystem];
        _registerButton.frame=CGRectMake(30*kGap,2*kHeight/3, 10*kGap, 5*kGap);
        _registerButton.layer.cornerRadius=5;
        _registerButton.layer.masksToBounds=YES;
        _registerButton.backgroundColor=[UIColor colorWithRed:164/255.0 green:203/255.0 blue:70/255.0 alpha:1];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _registerButton;
}
-(UIView*)headerView
{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kWidth, 10*kGap)];
        _headerView.backgroundColor  = [UIColor whiteColor];
        [_headerView addSubview:self.friendButton];
        [_headerView addSubview:self.qunButton];
    }
    return _headerView;
}
-(UIButton*)friendButton
{
    if (!_friendButton) {
        
        _friendButton=[[UIButton alloc]initWithFrame:CGRectMake(10*kGap, 0, 10*kGap, 10*kGap)];
        [_friendButton setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
        [_friendButton addTarget:self action:@selector(friendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _friendButton;
}
-(UIButton*)qunButton
{
    if (!_qunButton) {
        _qunButton=[[UIButton alloc]initWithFrame:CGRectMake(30*kGap, 0, 10*kGap, 10*kGap)];
        [_qunButton setImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];
        [_qunButton addTarget:self action:@selector(groupButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qunButton;
}
-(UITableView*)friendTableView
{
    if (!_friendTableView) {
        _friendTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+10*kGap, kWidth, kHeight-64-10*kGap) style:UITableViewStyleGrouped];
        _friendTableView.delegate=self;
        _friendTableView.dataSource=self;
        [_friendTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _friendTableView;
}
-(void)friendButtonAction:(UIButton*)button
{
    self.page=YES;
    self.navigationItem.rightBarButtonItems = @[self.friendRight];
    [self loadDataOfFriends];
}
-(void)groupButtonAction:(UIButton*)button
{
    self.page=NO;
    self.navigationItem.rightBarButtonItems=@[self.joinQunRight,self.setQunRight];
    [self loadDataOfGroup];
}
-(void)loadDataOfFriends
{
    //TableView的数据
    self.friendsArray=[NSMutableArray new];
    self.groupArray=[NSMutableArray new];
    self.foldDict=[NSMutableDictionary dictionary];
    AVQuery *query = [AVQuery queryWithClassName:@"Friends"];
    [query whereKey:@"username" equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // 检索成功
        if (!error) {
            /*
             //给分组名数组赋值
             for (NSMutableDictionary * dict in objects) {
             NSString*groupName=dict[@"localData"][@"groupname"];
             BOOL add=YES;
             for (NSString*string in self.groupArray) {
             if ([groupName isEqualToString:string]) {
             add=NO;
             }
             }
             if (add) {
             [self.groupArray addObject:groupName];
             }
             }
             //给好友列表数组赋值
             for (int i=0; i<[self.groupArray count]; i++) {
             NSMutableArray*array=[NSMutableArray new];
             
             for (int j=0; j<[objects count]; j++) {
             NSMutableDictionary*dict=objects[j];
             if ([dict[@"localData"][@"groupname"]isEqualToString:self.groupArray[i]]) {
             [array addObject:objects[j][@"localData"][@"friendname"]];
             }
             }
             [self.friendsArray addObject:array];
             }
             */
            for (AVObject * obj in objects) {
                // 分组名数组
                if (![self.groupArray containsObject:[obj valueForKey:@"groupname"]]) {
                    [self.groupArray addObject:[obj valueForKey:@"groupname"]];
                    // 拿到分组之后, 立刻将所有该分组下的好友添加到一个小数组
                    NSMutableArray * array = [ NSMutableArray array];
                    for (AVObject * obj1 in objects) {
                        if ([obj1 valueForKey:@"groupname"] == [obj valueForKey:@"groupname"] ) {
                            [array addObject:[obj1 valueForKey:@"friendname"]];
                        }
                    }
                    [self.friendsArray addObject:array];
                    // 将该小数组添加到大数组.
                }
            }
            //            NSLog(@"%@",self.groupArray);
            //            NSLog(@"%@",self.friendsArray);
            //刷新u
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.friendTableView reloadData];
            });
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
}
-(void)loadDataOfGroup
{
    self.qunArray=[NSMutableArray new];
    AVQuery *query = [AVQuery queryWithClassName:@"Qun"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            for (AVObject * obj in objects) {
                NSMutableArray*array=[obj valueForKey:@"member"];
                for (NSString * username in array) {
                    if ([username isEqualToString:[AVUser currentUser].username]) {
                        [self.qunArray addObject:[obj valueForKey:@"qunname"]];
                    }
                }
            }
            //刷新ui
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.friendTableView reloadData];
            });
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
-(void)loginButtonAction:(UIButton*)button
{
    LoginViewController *login=[LoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
}
-(void)registerButtonAction:(UIButton*)button
{
    RegisterViewController*regist=[RegisterViewController new];
    [self.navigationController pushViewController:regist animated:YES];
}
#pragma mark-------------TableTableView的代理方法-----------------
//设置分区个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.page) {
        return [self.groupArray count];
    }
    return 1;
}
//设置某一个分区的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.page) {
        if ([[self.foldDict valueForKey:self.groupArray[section]] boolValue]) {
            return [self.friendsArray[section] count];
        }else{
            return 0;
        }
    }
    return [self.qunArray count];
}
//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (self.page) {
        cell.textLabel.text=self.friendsArray[indexPath.section][indexPath.row];
    }else{
        
        cell.textLabel.text=self.qunArray[indexPath.row];
    }
    
    return cell;
}
//设置区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.page) {
        MyButton*button=[MyButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.textAlignment=NSTextAlignmentLeft;
        button.backgroundColor=[UIColor grayColor];
        [button setTitle:[NSString stringWithFormat:@"<   %@   >",self.groupArray[section]] forState:(UIControlStateNormal)];
        button.section=section;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        return button;
    }
    return nil;
}
//返回区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.page) {
        return 50;
    }
    return 0.000000000001;
}

//设置区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}
-(void)buttonAction:(MyButton*)sender
{
    NSUInteger section=sender.section;
    if ([[self.foldDict valueForKey:self.groupArray[section]] boolValue]==NO) {
        [self.foldDict setValue:@(YES) forKey:self.groupArray[section]];
    }else{
        [self.foldDict setValue:@(NO) forKey:self.groupArray[section]];
    }
    [self.friendTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationTop];
    
}

//选中cell触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.page) {
        ChatViewController*chatVC=[ChatViewController new];
        NSArray * arraySection = self.friendsArray[indexPath.section];
        //隐藏tabbar
        chatVC.hidesBottomBarWhenPushed = YES;
        chatVC.friendName = arraySection[indexPath.row];
        chatVC.page=self.page;
        [self.navigationController pushViewController:chatVC animated:YES];
    }else{
        ChatViewController*chatVC=[ChatViewController new];
        //隐藏tabbar
        chatVC.hidesBottomBarWhenPushed = YES;
        chatVC.groupName=self.qunArray[indexPath.row];
        chatVC.page=self.page;
        [self.navigationController pushViewController:chatVC animated:YES];
        
    }
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
