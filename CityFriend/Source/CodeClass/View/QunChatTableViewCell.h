//
//  QunChatTableViewCell.h
//  CityFriend
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat.h"
@interface QunChatTableViewCell : UITableViewCell
@property(nonatomic,strong)Chat*chat;
@property(nonatomic,strong)UILabel*concentLabel;//聊天内容
@property(nonatomic,strong)UIImageView*headImgView;
@property(nonatomic,strong)UILabel*nameLabel;
@property(nonatomic,strong)UIImageView*bodyImgView;
@property(nonatomic,strong)UILabel*timeLabel;
@end
