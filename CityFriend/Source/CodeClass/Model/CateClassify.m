//
//  CateClassify.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CateClassify.h"

@implementation CateClassify
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _foodID=value;
    }
}
@end
