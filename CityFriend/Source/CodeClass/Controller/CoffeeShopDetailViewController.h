//
//  CoffeeShopDetailViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeShopDetailViewController : UIViewController
@property(nonatomic,strong)Coffee*coffee;
@property(nonatomic,strong)Coffeeshop*coffeeShop;
@property(nonatomic,strong)UILabel*shopNameLabel;
@end
