//
//  ChatViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITextViewDelegate,ReceiveMessageToolDelegate>
@property(nonatomic,strong)UITextView*textView;
@property(nonatomic ,strong)UIView*myView;
//聊天 相关属性
@property (nonatomic, strong) AVIMClient *client;
//对话id
@property(nonatomic,strong)NSString*conversationID;
@end
@implementation ChatViewController

// 重写父类视图控制器
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    // 首先 创建了一个 client 来发送消息
    self.client = [[AVIMClient alloc] init];
    return self;
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

    // 初始化myView
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 70)];
    self.myView.backgroundColor = [UIColor grayColor];
    self.myView.center = CGPointMake(kWidth/2, kHeight-84);
    
    // 初始化textView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
    self.textView.center = CGPointMake(kWidth/2, 70/2);
    // 设置代理
    self.textView.delegate = self;
    //
    self.textView.backgroundColor = [UIColor magentaColor];
    //
    self.textView.font = [UIFont systemFontOfSize:23];
    // 设置是否拖动
    self.textView.scrollEnabled = YES;
    // 设置编辑使用的属性(默认是yes,当设置为NO的时候,依然可以拷贝)
    self.textView.editable = YES;
    // 设置textView的边框的属性
    self.textView.layer.cornerRadius = 35;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 5;
    self.textView.layer.borderColor = [UIColor yellowColor].CGColor;
    // 添加到自定义的self.myView上
    [self.myView addSubview:self.textView];
    // 创建Button
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 60);
    rightButton.center = CGPointMake(kWidth-30, 35);
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    // 添加事件
    [rightButton addTarget:self action:@selector(Action1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView addSubview:rightButton];
    
    
    
    [self.view addSubview:self.myView];
    
    self.view.backgroundColor = [UIColor cyanColor];
    [[ReceiveMessageTool shareIFlyManager] addDelegateReceiveMessageTool:self delegateQueue:dispatch_get_main_queue()];
    // Do any additional setup after loading the view.
}
-(void)Action1:(UIButton*)button
{
    
    [self SendMessage:self.textView.text];
}

// 在开始编辑的时候 textView 和键盘一起弹出
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [UIView beginAnimations:nil context:NULL];
    // 设置动画持续时间(返回时间)
    [UIView setAnimationDuration:0.3];
    // 设置代理
    [UIView setAnimationDelegate:self];
    self.myView.center = CGPointMake(kWidth/2, kHeight-300);
    return YES;
}

// 点击空白的区域回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // 回收键盘的同时textView返回底部
    [self.view endEditing:YES];
    [self keyBoardBack];
}
// 点击右按钮回收键盘
- (void) Cancel:(UIButton *)button
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
    self.myView.center = CGPointMake(kWidth/2, kHeight-84);
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
                    NSLog(@"发送成功！");
                }
            }];
        }];
    }];
}
// 接收消息的回调函数
- (void)conversation:(AVIMConversation *)conversation onDidReceiveTypedMessage:(AVIMTypedMessage *)message
{
    //判断接收到的消息是否是好友请求
    if ([message.text hasSuffix:@"想添加你为好友>_<"]) {//好友请求的处理
        
    }else if([message.text hasSuffix:@"已经通过了你的好友请求>_<"]){

    }else{
        if ([conversation.conversationId isEqualToString:self.conversationID]) {
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
                            NSLog(@"%@",str);
                        }
//                        NSLog(@"%@", [[objects[0] class] description]);
//                        NSLog(@"%@",[objects[0] text]);
                        //AVIMTextMessage
                        NSLog(@"查询成功！");
                    }];
                }];
            }];

        }
    }
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
