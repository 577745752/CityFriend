//
//  Coffee.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "Coffee.h"

@implementation Coffee
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _shopID=value;
    }
    if ([key isEqualToString:@"typeid"]) {
        _typeID=value;
    }
    if ([key isEqualToString:@"typename"]) {
        _typeName=value;
    }
}
@end
