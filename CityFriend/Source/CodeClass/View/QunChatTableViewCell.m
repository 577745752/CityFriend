//
//  QunChatTableViewCell.m
//  CityFriend
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "QunChatTableViewCell.h"

@implementation QunChatTableViewCell
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
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.bodyImgView];
    [self.contentView addSubview:self.timeLabel];
    [self.bodyImgView addSubview:self.concentLabel];
}
-(UILabel*)concentLabel
{
    if (!_concentLabel) {
        _concentLabel=[[UILabel alloc]initWithFrame:CGRectMake(5*kGap, 2*kGap, 30, 30)];
        _concentLabel.numberOfLines=0;
        
    }
    return _concentLabel;
}
-(UIImageView*)headImgView
{
    if (!_headImgView) {
        self.headImgView=[[UIImageView alloc]initWithFrame:CGRectMake(kGap, kGap, 10*kGap, 10*kGap)];
    }
    _headImgView.layer.cornerRadius=5*kGap;
    _headImgView.layer.masksToBounds=YES;
    return _headImgView;
}
-(UIImageView*)bodyImgView
{
    if (!_bodyImgView) {
        self.bodyImgView=[[UIImageView alloc]initWithFrame:CGRectMake(12*kGap, 2.5*kGap, 38*kGap, 8*kGap)];
        
    }
    return _bodyImgView;
}
-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(kGap, 11*kGap, kWidth-2*kGap, 2*kGap)];
        _timeLabel.font=[UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}
-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(3*kGap, 0, kWidth-6*kGap, 2*kGap)];
        _nameLabel.font=[UIFont systemFontOfSize:2*kGap];
    }
    return _nameLabel;
}
-(void)setChat:(Chat *)chat
{
    CGRect rect=[chat.content boundingRectWithSize:CGSizeMake(28*kGap, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    CGRect labelFrame=self.concentLabel.frame;
    labelFrame.size.height=rect.size.height;
    labelFrame.size.width=rect.size.width;
    CGRect timeLabelFrame=self.timeLabel.frame;
    timeLabelFrame.origin.y=rect.size.height+7*kGap;
    self.timeLabel.frame=timeLabelFrame;
    self.concentLabel.frame=labelFrame;
    if ([chat.name isEqualToString:[AVUser currentUser].username]) {
        self.concentLabel.text=chat.content;
        self.headImgView.image=[UIImage imageNamed:@"13"];
        CGRect headImgViewFrame=CGRectMake([UIScreen mainScreen].bounds.size.width-11*kGap, kGap, 10*kGap, 10*kGap);
        self.headImgView.frame=headImgViewFrame;
        
        CGRect bodyImgViewFrame=self.bodyImgView.frame;
        bodyImgViewFrame.size.height=rect.size.height+4*kGap;
        bodyImgViewFrame.size.width=rect.size.width+10*kGap;
        bodyImgViewFrame.origin.x=[UIScreen mainScreen].bounds.size.width-12*kGap-rect.size.width-10*kGap;
        _bodyImgView.frame=bodyImgViewFrame;
        [_bodyImgView setImage:[[UIImage imageNamed:@"chat_to"] stretchableImageWithLeftCapWidth:5*kGap topCapHeight:0]];
        self.timeLabel.text=[chat.time substringToIndex:19];
        self.timeLabel.textAlignment=NSTextAlignmentLeft;
    }else{
        self.concentLabel.text=chat.content;
        self.headImgView.image=[UIImage imageNamed:@"12"];
        CGRect headImgViewFrame=CGRectMake(kGap, 2*kGap, 10*kGap, 10*kGap);
        self.headImgView.frame=headImgViewFrame;
        self.nameLabel.text=chat.name;
        
        CGRect bodyImgViewFrame=self.bodyImgView.frame;
        bodyImgViewFrame.size.height=rect.size.height+4*kGap;
        bodyImgViewFrame.size.width=rect.size.width+10*kGap;
        bodyImgViewFrame.origin.x=12*kGap;
        _bodyImgView.frame=bodyImgViewFrame;
        [_bodyImgView setImage:[[UIImage imageNamed:@"chat_from"] stretchableImageWithLeftCapWidth:5*kGap topCapHeight:0]];
        self.timeLabel.text=[chat.time substringToIndex:19];
        self.timeLabel.textAlignment=NSTextAlignmentRight;
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
