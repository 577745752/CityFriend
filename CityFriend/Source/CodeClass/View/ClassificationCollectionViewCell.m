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
    }
    return self;
}

-(void)setSubViews{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 60)];
    _imgView.backgroundColor = [UIColor whiteColor];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 30;
    _imgView.image = [UIImage imageNamed:@"8"];
    [self addSubview:_imgView];
    self.LabName = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
    _LabName.textAlignment = 1;
    _LabName.font = [UIFont systemFontOfSize:11];
    [self addSubview:_LabName];
}

@end
