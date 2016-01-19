//
//  CateShopDetailViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateShopDetailViewController : UIViewController
@property(nonatomic,strong)Cate*cate;
@property(nonatomic,strong)CateShop*cateShop;
@property(nonatomic,strong)UILabel*shopNameLabel;

@property(nonatomic,strong)UIScrollView*scrollView;
@property(nonatomic,strong)UIPageControl*pageControl;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *telLabel;
@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,assign)NSUInteger currentIndex;
-(void)changePage;

@end
