//
//  ClassificationCollectionReusableView.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ClassificationCollectionReusableView.h"

@implementation ClassificationCollectionReusableView
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
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, self.frame.size.height)];
    _label.font = [UIFont boldSystemFontOfSize:20];
    [_imgView addSubview:_label];
}

@end
