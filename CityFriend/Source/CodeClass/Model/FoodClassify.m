//
//  FoodClassify.m
//  CityFriend
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "FoodClassify.h"

@implementation FoodClassify
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _foodID=value;
    }
}
@end
