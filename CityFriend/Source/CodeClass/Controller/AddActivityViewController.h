//
//  AddActivityViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddActivityViewController : UIViewController
@property(nonatomic,strong)UILabel*activityTitleLabel;
@property(nonatomic,strong)UILabel*activityTimeLabel;
@property(nonatomic,strong)UILabel*addressLabel;
@property(nonatomic,strong)UILabel*concentLabel;
@property(nonatomic,strong)UITextField*activityTitleTextField;
@property(nonatomic,strong)UITextField*activityTimeTextField;
@property(nonatomic,strong)UITextField*addressTextField;
@property(nonatomic,strong)UITextView*concentView;
@end
