//
//  ActivivtyDetailViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivivtyDetailViewController : UIViewController

@property(nonatomic,strong)AVObject *objc;

//标题
@property(nonatomic,strong)UILabel *titleLabel;
//发起者
@property(nonatomic,strong)UIImageView *initiatorImgView;
@property(nonatomic,strong)UILabel *initiator_Label;
@property(nonatomic,strong)UILabel *initiatorLabel;
//活动时间
@property(nonatomic,strong)UIImageView *timeImgView;
@property(nonatomic,strong)UILabel *time_Label;
@property(nonatomic,strong)UILabel *timeLabel;
//活动地点
@property(nonatomic,strong)UIImageView *addressImgView;
@property(nonatomic,strong)UILabel *address_Label;
@property(nonatomic,strong)UILabel *addressLabel;
//聊天群组
@property(nonatomic,strong)UIImageView *chatGroupImgView;
@property(nonatomic,strong)UILabel *chatGroup_Label;
@property(nonatomic,strong)UILabel *chatGroupLabel;
//活动内容
@property(nonatomic,strong)UIImageView *activityContentImgView;
@property(nonatomic,strong)UILabel *activityContent_Label;
@property(nonatomic,strong)UILabel *activityContentLabel;

//进群按钮
@property(nonatomic,strong)UIButton *GetInToGroupButton;
//判断是从哪个页面跳转的
@property(nonatomic,assign)BOOL yesOrNo;

-(CGFloat)caculateHeightWith:(NSString *)str;
@end
