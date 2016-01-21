//
//  ShopTableViewCell.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ShopTableViewCell.h"

@implementation ShopTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawView];
        self.contentView.backgroundColor=[UIColor orangeColor];
    }
    return self;
}
-(void)drawView
{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.shopNameLabel];
}
-(UIImageView *)imgView{
    if(!_imgView){
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap, kGap, kWidth / 4, kWidth / 4)];
    }
    return  _imgView;
}
-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth / 4 + kGap, 5*kGap,3*kWidth/4-3*kGap,5*kGap)];
        _shopNameLabel.font = [UIFont systemFontOfSize:21];
        _shopNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _shopNameLabel;
}
-(void)setShop:(Shop *)shop
{
    if (_shop!=shop) {
        _shop=nil;
        _shop=shop;
    }
    self.shopNameLabel.text=self.shop.title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.shop.s_image_url]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
