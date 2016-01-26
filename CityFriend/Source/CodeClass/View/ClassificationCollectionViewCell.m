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
        
        //        self.backgroundColor=[UIColor redColor];
        
    }
    return self;
}

-(void)setSubViews{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kGap, 0, 10*kGap, 10*kGap)];
    _imgView.backgroundColor = [UIColor whiteColor];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 5*kGap;
    _imgView.image = [UIImage imageNamed:@"8.jpeg"];
    //[self addSubview:_imgView];
    self.LabName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    _LabName.textAlignment = 1;
    _LabName.font = [UIFont systemFontOfSize:15];
    _LabName.layer.cornerRadius = 10;
    _LabName.layer.masksToBounds = YES;
    
    [self addSubview:_LabName];
}
@end
