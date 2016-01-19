//
//  ClassifyTableViewCell.m
//  CityFriend
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ClassifyTableViewCell.h"

@implementation ClassifyTableViewCell
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
    [self.contentView addSubview:self.shopNameLabel];
    
}
-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 20)];
        _shopNameLabel.backgroundColor=[UIColor grayColor];
    }
    return _shopNameLabel;
}
-(void)setFoodShop:(FoodShop *)foodShop
{
    if (_foodShop!=foodShop) {
        _foodShop=nil;
        _foodShop=foodShop;
    }
    self.shopNameLabel.text=foodShop.shopname;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
