//
//  FriendViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "FriendViewController.h"

@interface FriendViewController ()<UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>
@property(nonatomic,strong)UIBarButtonItem*right;
@property(nonatomic,strong)UIButton*loginButton;
@property(nonatomic,strong)UIView*headerView;
@property(nonatomic,strong)UIButton*friendButton;
@property(nonatomic,strong)UIButton*groupButton;
@property(nonatomic,strong)UITableView*friendTableView;
@property(nonatomic,strong)UITableView*groupTableView;
@property(nonatomic,strong)NSString*addFriendId;
//聊天 相关属性
@property (nonatomic, strong) AVIMClient *client;
@end

static NSString*const cellID=@"cell";
@implementation FriendViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title=@"好友";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"好友" image:[UIImage imageNamed:@"3"] selectedImage:[UIImage imageNamed:@"3"]];
        self.view.backgroundColor=[UIColor greenColor];
        self.right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightClick:)];
        self.navigationItem.rightBarButtonItem = self.right;

    }
    return self;
}
-(void)rightClick:(UIBarButtonItem*)item
{

    UIAlertController*friendName=[UIAlertController alertControllerWithTitle:@"" message:@"请输入要添加的好友id" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*ok=[UIAlertAction actionWithTitle:@"确认添加" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UITextField*text=(UITextField*)[friendName.view viewWithTag:105];
        self.addFriendId=text.text;
        AVQuery *query = [AVUser query];
        [query whereKey:@"username" equalTo:text.text];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error == nil) {
                if ([objects count]) {
                    [self tomSendMessageToJerry];
//                        AVObject *post = [AVObject objectWithClassName:@"Friends"];
//                        [post saveInBackground];
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

}
//发送消息
- (void)tomSendMessageToJerry {
    // Tom 创建了一个 client
    self.client = [[AVIMClient alloc] init];
    //用户登陆状态
    AVUser *currentUser = [AVUser currentUser];
    
    // Tom 用自己的名字作为 ClientId 打开 client
    [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
        // Tom 建立了与 Jerry 的会话
        [self.client createConversationWithName:@"好友请求" clientIds:@[self.addFriendId] callback:^(AVIMConversation *conversation, NSError *error) {
            // Tom 发了一条消息给 Jerry
            [conversation sendMessage:[AVIMTextMessage messageWithText:currentUser.username attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"发送成功！");
                }
            }];
        }];
    }];
}
//接收消息
- (void)jerryReceiveMessageFromTom {
    // Jerry 创建了一个 client
    self.client = [[AVIMClient alloc] init];
    //用户登陆状态
    AVUser *currentUser = [AVUser currentUser];
    // 设置 client 的 delegate，并实现 delegate 方法
    self.client.delegate = self;
    
    // Jerry 用自己的名字作为 ClientId 打开了 client
    [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
        // ...
    }];
    NSLog(@"接收消息");
}

#pragma mark - AVIMClientDelegate

// 接收消息的回调函数
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    
    UIAlertController*get=[UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@想添加你为好友",message] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*ok=[UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             //添加好友代码
        NSLog(@"可以约了");
    }];
    UIAlertAction*no=[UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [get addAction:no];
    [get addAction:ok];
    [self presentViewController:get animated:YES completion:nil];
}




-(void)viewWillAppear:(BOOL)animated
{
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser == nil) {
        self.loginButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20*kGap, 10*kGap)];
        [self.loginButton setTitle:@"马上去登陆" forState:UIControlStateNormal];
        self.loginButton.center=self.view.center;
        [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView removeFromSuperview];
        [self.friendTableView removeFromSuperview];
        [self.view addSubview:self.loginButton];
    }else{
        
        
    self.headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kWidth, 10*kGap)];
    [self.view addSubview:self.headerView];
    self.friendButton=[[UIButton alloc]initWithFrame:CGRectMake(10*kGap, 0, 10*kGap, 10*kGap)];
    [self.friendButton setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    [self.headerView addSubview:self.friendButton];
    self.groupButton=[[UIButton alloc]initWithFrame:CGRectMake(30*kGap, 0, 10*kGap, 10*kGap)];
    [self.groupButton setImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];
    [self.headerView addSubview:self.groupButton];

#pragma mark------------TableView
        self.friendTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+10*kGap, kWidth, kHeight-64-10*kGap) style:UITableViewStyleGrouped];
    self.friendTableView.delegate=self;
    self.friendTableView.dataSource=self;
    [self.friendTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.friendTableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.friendTableView];
    }
    
    [self jerryReceiveMessageFromTom];

    // Do any additional setup after loading the view.
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
    return 3;
}
//设置某一个分区的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text=@"王国维";
//        CGFloat red=arc4random()%256/255.0;
//        CGFloat green=arc4random()%256/255.0;
//        CGFloat blue=arc4random()%256/255.0;
//        cell.contentView.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000000001;
}

//设置区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}
////设置区头标题
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return @"A";
//    }else if(section==1)
//    {
//        return @"B";
//    }
//    return @"D";
//}
////设置区尾标题
//-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @"吃粑粑";
//}
////设置右侧索引   (点击对应的索引,跳到对应的分区,数组元素下标和分区编号对应)
//-(NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView{
//    NSArray*array=@[@"1",@"2",@"3"];
//    return array;
//}
////选中cell触发的事件
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==0) {
//        if (indexPath.row==0) {
//            YyViewController*a=[YyViewController new];
//            [self.navigationController pushViewController:a animated:YES];
//        }else if(indexPath.row==1)
//        {
//            YechaViewController*b=[YechaViewController new];
//            [self.navigationController pushViewController:b animated:YES];
//        }
//    }
//}














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
