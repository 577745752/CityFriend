//
//  HintLoginView.m
//  CityFriend
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "HintLoginView.h"

@implementation HintLoginView
//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [self drawView];
    }
    return self;
}
-(void)drawView
{
    [self addSubview:self.imgView];
}
-(UIImageView *)imgView
{
    if (!_imgView) {
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _imgView.image =[UIImage imageNamed:@"11"];

        [_imgView addSubview:self.label];
    }
    return _imgView;
}
-(UILabel*)label
{
    if (!_label) {
        _label=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, kHeight/2, 3*kWidth/4, 6*kGap)];
        _label.text=@"遇 见 你, 真 美 好 !";
        _label.font=[UIFont fontWithName:@"Zapfino" size:23];
        _label.textColor=[UIColor redColor];
    }
    return _label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
