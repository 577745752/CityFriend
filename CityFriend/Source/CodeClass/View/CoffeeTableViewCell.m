//
//  CoffeeTableViewCell.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CoffeeTableViewCell.h"

@implementation CoffeeTableViewCell
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
-(void)setCoffee:(Coffee *)coffee
{
    if (_coffee!=coffee) {
        _coffee=nil;
        _coffee=coffee;
    }
    self.shopNameLabel.text=self.coffee.shopname;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
