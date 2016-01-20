//
//  ShopTableViewCell.h
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
@interface ShopTableViewCell : UITableViewCell
@property(nonatomic,strong)Shop*shop;
@property(nonatomic,strong)UILabel*shopNameLabel;
@property(nonatomic,strong)UIImageView *imgView;
@end
