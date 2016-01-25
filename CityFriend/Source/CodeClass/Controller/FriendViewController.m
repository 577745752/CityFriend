//
//  FriendViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()<UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>
//右按钮
@property(nonatomic,strong)UIBarButtonItem*right;
//提示登陆的背景视图
@property(nonatomic,strong)UIView*loginBackView;
//提示登陆按钮
@property(nonatomic,strong)UIButton*loginButton;
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
        self.right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightClick:)];
        //默认显示好友界面
        self.page=YES;
    }
    return self;
}
-(void)rightClick:(UIBarButtonItem*)item
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
    }else{//群组界面
    }
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
        [self.client createConversationWithName:@"好友请求" clientIds:@[username] callback:^(AVIMConversation *conversation, NSError *error) {
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
    NSLog(@"接收消息");
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
            //获取要添加的用户分组
            UITextField*text=(UITextField*)[getFriend.view viewWithTag:106];
            self.addFriendGroup=text.text;
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
    }else if([message.text hasSuffix:@"已经通过了你的好友请求>_<"]){
        //截取对方的id
        NSString*idString=[[message.text componentsSeparatedByString:@"已经"] firstObject];
        UIAlertController*getFriend=[UIAlertController alertControllerWithTitle:@"" message:message.text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"搜嘎" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //获取要添加的用户分组
            UITextField*text=(UITextField*)[getFriend.view viewWithTag:107];
            self.addFriendGroup=text.text;
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
    }else{
        
        //正常聊天
    }
    
}




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
            self.navigationItem.rightBarButtonItem = self.right;
            [self loadDataOfFriends];
        }else{
            [self loadDataOfGroup];
        }
        [self ReceiveMessage];
    }
    // Do any additional setup after loading the view.
}
-(UIView*)loginBackView
{
    if (!_loginBackView) {
        _loginBackView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _loginBackView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"8.jpeg"]];
        [_loginBackView addSubview:self.loginButton];
    }
    return _loginBackView;
}
-(UIButton*)loginButton
{
    if (!_loginButton) {
        _loginButton=[UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.frame=CGRectMake(0, 0, 20*kGap, 10*kGap);
        [_loginButton setTitle:@"马上去登陆" forState:UIControlStateNormal];
        _loginButton.center=self.view.center;
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.backgroundColor=[UIColor redColor];
    }
    return _loginButton;
}
-(UIView*)headerView
{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kWidth, 10*kGap)];
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
        _friendTableView.backgroundColor=[UIColor redColor];
    }
    return _friendTableView;
}
-(void)friendButtonAction:(UIButton*)button
{
    self.page=YES;
    [self loadDataOfFriends];
}
-(void)groupButtonAction:(UIButton*)button
{
    self.page=NO;
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
    
    //刷新u
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.friendTableView reloadData];
    });
}
-(void)loginButtonAction:(UIButton*)button
{
    LoginViewController *login=[LoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
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
        cell.textLabel.text=@"群名字";
    }
    
    return cell;
}
//设置区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.page) {
        MyButton*button=[MyButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor=[UIColor purpleColor];
        [button setTitle:self.groupArray[section] forState:(UIControlStateNormal)];
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
        [self
         .foldDict setValue:@(NO) forKey:self.groupArray[section]];
    }
    [self.friendTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationTop];
    
}

//选中cell触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.page) {
        ChatViewController*chatVC=[ChatViewController new];
        NSArray * arraySection = self.friendsArray[indexPath.section];
        chatVC.friendName = arraySection[indexPath.row];
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
