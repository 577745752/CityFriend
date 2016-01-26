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
@property(nonatomic,strong)UILabel*label;
@property(nonatomic,strong)UIImageView*headImgView;
@property(nonatomic,strong)UIImageView*bodyImgView;
@end
