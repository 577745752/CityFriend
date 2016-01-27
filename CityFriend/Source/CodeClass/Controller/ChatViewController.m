//
//  ChatViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITextView*textView;
@property(nonatomic ,strong)UIView*myView;
//聊天记录的tableView
@property(nonatomic,strong)UITableView*chattingTableView;
//存储聊天记录的数组
@property(nonatomic,strong)NSMutableArray*chattingArray;
//聊天 相关属性
@property (nonatomic, strong) AVIMClient *client;
//对话id
@property(nonatomic,strong)NSString*conversationID;
@end
static NSString*const cellID=@"cell";
@implementation ChatViewController

// 重写父类视图控制器
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    //注册一个通知
    //通过单例的方式获取通知中心对象
    //第一个参数:收到通知后谁负责执行方法
    //第二个参数:执行的方法
    //第三个参数:通知中心的名字
    //第四个参数:参数对象,可以为nil
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMessageAction:) name:@"Message" object:nil];
    // 首先 创建了一个 client 来发送消息
    self.client = [[AVIMClient alloc] init];
    return self;
}
-(void)getMessageAction:(NSNotification*)notification
{
    [self loadData];
}
-(void)setFriendName:(NSString *)friendName
{
    if (_friendName!=friendName) {
        _friendName=nil;
        _friendName=friendName;
    }
    self.navigationItem.title = self.friendName;
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self ReceiveMessage];
#pragma mark------------聊天记录tableView------------------  

    self.chattingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64-10*kGap) style:UITableViewStyleGrouped];
    self.chattingTableView.delegate=self;
    self.chattingTableView.dataSource=self;
    [self.chattingTableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:cellID];
    [self loadData];
    [self.view addSubview:self.chattingTableView];
    //如果和这个朋友有过聊天,那么聊天结果需要跳到最后一行
    NSIndexPath*indexPath=[NSIndexPath indexPathForRow:self.chattingArray.count-1 inSection:0];
    //跳转到最后一行
    if (self.chattingArray.count>0) {
        [self.chattingTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
    
#pragma mark------------textView------------------
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = 0;
    }
    // 初始化myView
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth,10*kGap)];
    self.myView.center = CGPointMake(kWidth/2, kHeight-64-5*kGap);
    self.myView.backgroundColor=[UIColor grayColor];
    
    // 初始化textView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kWidth-10*kGap, 10*kGap)];
    // 设置代理
    self.textView.delegate = self;
    //
    self.textView.font = [UIFont systemFontOfSize:23];
    // 设置是否拖动
    self.textView.scrollEnabled = YES;
    // 设置编辑使用的属性(默认是yes,当设置为NO的时候,依然可以拷贝)
    self.textView.editable = YES;
    // 设置textView的边框的属性
    self.textView.layer.cornerRadius = 5*kGap;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 3;
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    // 添加到自定义的self.myView上
    [self.myView addSubview:self.textView];
    // 创建Button
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(0, 0, 10*kGap, 10*kGap);
    sendButton.center = CGPointMake(kWidth-5*kGap, 5*kGap);
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    // 添加事件
    [sendButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView addSubview:sendButton];
    [self.view addSubview:self.myView];
    // Do any additional setup after loading the view.
}
-(void)sendButtonAction:(UIButton*)button
{
    if ([self.textView.text isEqualToString:@""]) {
        
    }else{
        
    [self SendMessage:self.textView.text];
    }
}
-(void)loadData
{
    NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
    DataBaseTool*db=[DataBaseTool shareDataBase];
    //连接数据库
    [db connectDB:dataBasePath];
    //查询
    self.chattingArray=[NSMutableArray new];
    self.chattingArray=[db selectTable:[NSString stringWithFormat:@"%@_%@",[AVUser currentUser].username,self.friendName] WithCondition:@"1=1"];
//   self.chattingArray =[db selectString:[NSString stringWithFormat:@"SELECT * FROM %@_%@",[AVUser currentUser].username,self.friendName]];
//        [db disconnectDB];
//    Chat*chat=[Chat new];
//    chat=self.chattingArray[0];
//    NSLog(@"%@",chat.content);
//    NSLog(@"%@",dataBasePath);
    //刷新u
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.chattingTableView reloadData];
    });

}
//设置分区个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
//设置某一个分区的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.chattingArray count];
}
//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    Chat*chat=[Chat new];
    chat=self.chattingArray[indexPath.row];
    cell.chat=chat;
    return cell;
}
//返回区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.000000000001;
}

//设置区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 回收键盘的同时textView返回底部
    [self.view endEditing:YES];
    [self keyBoardBack];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Chat*chat=self.chattingArray[indexPath.row];
    CGRect rect=[chat.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-130, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height+50;
}
// 在开始编辑的时候 textView 和键盘一起弹出
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    // 设置动画持续时间(返回时间)
    [UIView setAnimationDuration:0.3];
    // 设置代理
    [UIView setAnimationDelegate:self];
    self.myView.center = CGPointMake(kWidth/2, kHeight/2-6*kGap);
    return YES;
}

// 点击空白的区域回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 回收键盘的同时textView返回底部
    [self.view endEditing:YES];
    [self keyBoardBack];
}
// 封装一个textView的位置方法
- (void)keyBoardBack
{
    
    [UIView beginAnimations:nil context:NULL];
    // 设置动画持续时间(返回时间)
    [UIView setAnimationDuration:0.3];
    // 设置代理
    [UIView setAnimationDelegate:self];
    self.myView.center = CGPointMake(kWidth/2, kHeight-64-5*kGap);
}
// 发送消息的方法
-(void)SendMessage:(NSString*)message{

    // 用自己的名字作为 ClientId 打开 client
    [self.client openWithClientId:[AVUser currentUser].username callback:^(BOOL succeeded, NSError *error) {
        // "我" 建立了与 "对方" 的会话
        [self.client createConversationWithName:@"聊天" clientIds:@[self.friendName] callback:^(AVIMConversation *conversation, NSError *error) {
            // 我 发了一条消息给 对方
            self.conversationID=conversation.conversationId;
            [conversation sendMessage:[AVIMTextMessage messageWithText:message attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
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
                    [db execDMLSql:[NSString stringWithFormat:@"INSERT INTO %@_%@ VALUES ('%@','%@','%@')",[AVUser currentUser].username,self.friendName,[AVUser currentUser].username,message,time]];
                    [db disconnectDB];
                    //重新加载聊天记录
                    [self loadData];
                    NSLog(@"发送成功！");
                    //刷新u
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //如果和这个朋友有过聊天,那么聊天结果需要跳到最后一行
                        NSIndexPath*indexPath=[NSIndexPath indexPathForRow:self.chattingArray.count-1 inSection:0];
                        //跳转到最后一行
                        if (self.chattingArray.count>0) {
                            [self.chattingTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
                        }
                    });

                }
            }];
        }];
    }];
}
//// 接收消息的回调函数
//- (void)conversation:(AVIMConversation *)conversation onDidReceiveTypedMessage:(AVIMTypedMessage *)message
//{
//    //判断接收到的消息是否是好友请求
//    if ([message.text hasSuffix:@"想添加你为好友>_<"]) {//好友请求的处理
//        
//    }else if([message.text hasSuffix:@"已经通过了你的好友请求>_<"]){
//
//    }else{
//        NSArray * array = [conversation valueForKey:@"m"] ;
//        if ([array[0] isEqualToString:self.conversationID]) {
//            // 添加
//        }
//        if ([array[1] isEqualToString:self.conversationID]) {
//            // 添加
//        }
//        else{
//            // 不是发给这个好友的
//        }
////        if ([conversation.conversationId isEqualToString:self.conversationID]) {
//            //正常聊天
//            NSLog(@"接收到消息了");
//            NSLog(@"%@",message.text);
//            //正常聊天
//            //我 用自己的名字作为 ClientId 打开 client
//            [self.client openWithClientId:[AVUser currentUser].username callback:^(BOOL succeeded, NSError *error) {
//                // 我 创建查询会话的 query
//                AVIMConversationQuery *query = [self.client conversationQuery];
//                // Tom 获取 id 为 2f08e882f2a11ef07902eeb510d4223b 的会话
//                [query getConversationById:conversation.conversationId callback:^(AVIMConversation *conversation, NSError *error) {
//                    // 查询对话中最后 10 条消息
//                    [conversation queryMessagesWithLimit:10 callback:^(NSArray *objects, NSError *error) {
//                        for (AVIMTextMessage * msg in objects) {
//                            NSString * str = [msg text];
//                            NSLog(@"%@",str);
//                        }
////                        NSLog(@"%@", [[objects[0] class] description]);
////                        NSLog(@"%@",[objects[0] text]);
//                        //AVIMTextMessage
//                        NSLog(@"查询成功！");
//                    }];
//                }];
//            }];
//
//        }
////    }
//    
//}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
