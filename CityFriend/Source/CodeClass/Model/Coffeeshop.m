//
//  Coffeeshop.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "Coffeeshop.h"

@implementation Coffeeshop
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _shopID=value;
    }
    
}
@end
