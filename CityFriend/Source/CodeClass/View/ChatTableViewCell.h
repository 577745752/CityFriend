//
//  ChatTableViewCell.h
//  CityFriend
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat.h"
@interface ChatTableViewCell : UITableViewCell
@property(nonatomic,strong)Chat*chat;
@property(nonatomic,strong)UILabel*concentLabel;//聊天内容
@property(nonatomic,strong)UIImageView*headImgView;
@property(nonatomic,strong)UIImageView*bodyImgView;
@property(nonatomic,strong)UILabel*timeLabel;
@end
