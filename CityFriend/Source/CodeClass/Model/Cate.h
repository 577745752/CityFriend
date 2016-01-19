//
//  Cate.h
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cate : NSObject
@property(nonatomic,strong)NSString*discount;//折扣
@property(nonatomic,strong)NSString*shopID;//店铺id
@property(nonatomic,strong)NSString*lat;//纬度
@property(nonatomic,strong)NSString*lng;//经度
@property(nonatomic,strong)NSString*logo;//店铺图片
@property(nonatomic,strong)NSString*meter;//距离
@property(nonatomic,strong)NSString*shopname;//店名
@property(nonatomic,strong)NSString*shoptid;//商家87//普通用户88
@property(nonatomic,strong)NSString*typeID;//分类ID
@property(nonatomic,strong)NSString*typeName;//分类名称
@end
