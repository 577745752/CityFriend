//
//  CateShop.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CateShop.h"

@implementation CateShop
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _shopID=value;
    }
    
}
@end
