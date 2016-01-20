//
//  ClassificationCollectionViewCell.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ClassificationCollectionViewCell.h"

@implementation ClassificationCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
<<<<<<< HEAD
        //        self.backgroundColor=[UIColor redColor];
=======
//        self.backgroundColor=[UIColor redColor];
>>>>>>> 2e370d3cd2600a1fcf406e06096483b793ebacc1
    }
    return self;
}

-(void)setSubViews{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kGap, 0, 10*kGap, 10*kGap)];
    _imgView.backgroundColor = [UIColor whiteColor];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 5*kGap;
    _imgView.image = [UIImage imageNamed:@"8.jpeg"];
    [self addSubview:_imgView];
    self.LabName = [[UILabel alloc] initWithFrame:CGRectMake(0, 11*kGap,12*kGap, 2*kGap)];
    _LabName.textAlignment = 1;
    _LabName.font = [UIFont systemFontOfSize:12];
    [self addSubview:_LabName];
}
<<<<<<< HEAD
=======

>>>>>>> 2e370d3cd2600a1fcf406e06096483b793ebacc1
@end
