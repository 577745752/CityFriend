//
//  ReceiveMessageTool.m
//  CityFriend
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ReceiveMessageTool.h"
@interface ReceiveMessageTool ()<AVIMClientDelegate>
//聊天 相关属性
@property (nonatomic, strong) AVIMClient *client;
@end
@implementation ReceiveMessageTool
// 单例方法
+(instancetype)shareIFlyManager
{
    static ReceiveMessageTool * sb = nil;
    if (sb == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sb = [[ReceiveMessageTool alloc] init];
        });
    }
    return sb;
}
-(instancetype)init
{
    if (self) {
        // 多播代理的初始化
        self.multiDelegate = (id<ReceiveMessageToolDelegate>)[[GCDMulticastDelegate alloc] init];
        // 用户 创建了一个 client 来接收消息
        self.client = [[AVIMClient alloc] init];
        // 设置 client 的 delegate，并实现 delegate 方法
        self.client.delegate = self;
        
        [self ReceiveMessage];
    }
    return self;
}
// 添加代理方法
- (void)addDelegateReceiveMessageTool:(id<ReceiveMessageToolDelegate>)delegate delegateQueue:(dispatch_queue_t)queue
{
    [_multiDelegate addDelegate:delegate delegateQueue:queue];
}
//接收消息的方法
- (void)ReceiveMessage
{
    //用户登陆状态
    AVUser *currentUser = [AVUser currentUser];
    // 用户 用自己的名字作为 ClientId 打开了 client
    [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
        // ...
    }];
    NSLog(@"正在接收消息");
}
#pragma mark - AVIMClientDelegate

// 接收消息的回调函数
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {

    [self.multiDelegate conversation:conversation onDidReceiveTypedMessage:message];
    
}

@end
