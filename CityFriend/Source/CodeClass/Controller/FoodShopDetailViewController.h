//
//  FoodShopDetailViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodShopDetailViewController : UIViewController
@property(nonatomic,strong)FoodShop*foodShop;
@property(nonatomic,strong)FoodShopContent*foodShopContent;
@property(nonatomic,strong)UILabel*shopNameLabel;
@end
