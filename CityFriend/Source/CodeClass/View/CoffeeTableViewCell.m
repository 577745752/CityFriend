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
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.shopNameLabel];
    
    
}
-(UIImageView *)imgView{
    if(!_imgView){
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap, kGap, kWidth / 4, kWidth / 5)];
    }
    return  _imgView;
}
-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth / 4 + 2 * kGap, kGap, kWidth / 3 * 2, kWidth / 5)];
        _shopNameLabel.font = [UIFont systemFontOfSize:21];
        _shopNameLabel.textAlignment = NSTextAlignmentCenter;
        //_shopNameLabel.backgroundColor=[UIColor grayColor];
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
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.coffee.logo]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
