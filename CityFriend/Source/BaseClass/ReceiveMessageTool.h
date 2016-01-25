//
//  ReceiveMessageTool.h
//  CityFriend
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <Foundation/Foundation.h>
// 定义协议
@protocol ReceiveMessageToolDelegate <NSObject>
- (void)conversation:(AVIMConversation *)conversation onDidReceiveTypedMessage:(AVIMTypedMessage *)message;
@end
@interface ReceiveMessageTool : NSObject
// 多播代理
@property(nonatomic)GCDMulticastDelegate<ReceiveMessageToolDelegate> *multiDelegate;
// !!!:方法
// 单例方法
+(instancetype)shareIFlyManager;
// 多播代理添加方法
- (void)addDelegateReceiveMessageTool:(id<ReceiveMessageToolDelegate>)delegate delegateQueue:(dispatch_queue_t)queue;
//接收消息的方法
- (void)ReceiveMessage;
@end
