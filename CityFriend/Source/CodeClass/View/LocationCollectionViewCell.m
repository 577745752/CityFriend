//
//  LocationCollectionViewCell.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "LocationCollectionViewCell.h"

@implementation LocationCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews{
    self.labCityName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    _labCityName.font = [UIFont systemFontOfSize:15];
    _labCityName.textAlignment = 1;
    [self addSubview:_labCityName];
}
@end
