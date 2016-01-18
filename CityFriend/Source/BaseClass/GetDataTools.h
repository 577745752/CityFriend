//
//  GetDataTools.h
//  CityFriend
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <Foundation/Foundation.h>

// 1.定义一个block类型

typedef void(^PassValue) (NSMutableArray*dataArray);
@interface GetDataTools : NSObject
// 作为单例的属性,这个数组可以在任何位置,任何时间被访问.
@property(nonatomic,strong)NSMutableArray*foodClassifyArray;

////2.声明一个bolck属性
//@property(nonatomic,copy)PassValue passValue;
//-(void)getData:(PassValue) passValue;
-(void)getData:(NSString*)url Block:(PassValue)passValue;
+(instancetype)shareGetData;
@end
