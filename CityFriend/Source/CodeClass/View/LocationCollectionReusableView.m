//
//  LocationCollectionReusableView.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "LocationCollectionReusableView.h"

@implementation LocationCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgView.image = [UIImage imageNamed:@"7"];
    [self addSubview:_imgView];
    self.LabProvinces = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, self.frame.size.height)];
    _LabProvinces.font = [UIFont boldSystemFontOfSize:15];
    [_imgView addSubview:_LabProvinces];
}

@end
