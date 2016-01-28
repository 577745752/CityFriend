//
//  ChatTableViewCell.m
//  CityFriend
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawView];
    }
    return self;
}
-(void)drawView
{
    
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.bodyImgView];
    [self.bodyImgView addSubview:self.label];
}
-(UILabel*)label
{
    if (!_label) {
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 30, 30)];
        self.label.numberOfLines=0;
        
    }
    return _label;
}
-(UIImageView*)headImgView
{
    if (!_headImgView) {
        self.headImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 50, 50)];
    }
    return _headImgView;
}
-(UIImageView*)bodyImgView
{
    if (!_bodyImgView) {
        self.bodyImgView=[[UIImageView alloc]initWithFrame:CGRectMake(60, 10, [UIScreen mainScreen].bounds.size.width-60, 30)];
        
    }
    return _bodyImgView;
}
-(void)setChat:(Chat *)chat
{
    CGRect rect=[chat.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-130, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    CGRect labelFrame=self.label.frame;
    labelFrame.size.height=rect.size.height;
    labelFrame.size.width=rect.size.width;
    self.label.frame=labelFrame;
    if ([chat.name isEqualToString:[AVUser currentUser].username]) {
        // cell.textLabel.text=message.body;
        self.label.text=[NSString stringWithFormat:@"%@:%@",chat.name,chat.content];
        self.headImgView.image=[UIImage imageNamed:@"13"];
        CGRect headImgViewFrame=CGRectMake([UIScreen mainScreen].bounds.size.width-50, 10, 50, 50);
        self.headImgView.frame=headImgViewFrame;
        
        CGRect bodyImgViewFrame=self.bodyImgView.frame;
        bodyImgViewFrame.size.height=rect.size.height+30;
        bodyImgViewFrame.size.width=rect.size.width+60;
        bodyImgViewFrame.origin.x=[UIScreen mainScreen].bounds.size.width-120-rect.size.width;
        
        
        self.bodyImgView.frame=bodyImgViewFrame;
        [self.bodyImgView setImage:[[UIImage imageNamed:@"chat_to"] stretchableImageWithLeftCapWidth:30 topCapHeight:0]];

    }else{
        self.label.text=[NSString stringWithFormat:@"%@:%@",chat.name,chat.content];
        self.headImgView.image=[UIImage imageNamed:@"12"];
        CGRect headImgViewFrame=CGRectMake(0, 10, 50, 50);
        self.headImgView.frame=headImgViewFrame;
        
        
        CGRect bodyImgViewFrame=self.bodyImgView.frame;
        bodyImgViewFrame.size.height=rect.size.height+30;
        bodyImgViewFrame.size.width=rect.size.width+60;
        bodyImgViewFrame.origin.x=60;
        self.bodyImgView.frame=bodyImgViewFrame;
        [self.bodyImgView setImage:[[UIImage imageNamed:@"chat_from"] stretchableImageWithLeftCapWidth:30 topCapHeight:0]];
  }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
