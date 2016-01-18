//
//  GetDataTools.m
//  CityFriend
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "GetDataTools.h"

@implementation GetDataTools

+(instancetype)shareGetData
{
    static GetDataTools*gd=nil;
    if (gd == nil) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            gd=[[GetDataTools alloc]init];
        });
    }
    return gd;
}
-(void)getData:(PassValue) passValue
{

    dispatch_queue_t global=dispatch_get_global_queue(0, 0);// 创建全局队列, 全局队列的特点是所有任务都是在子线程中执行, 并且是并发执行.
    dispatch_async(global, ^{
        // 网络请求方式, 通过打开远程服务器的某个文件, 读取其中的内容.
//        NSArray*array=[NSArray arrayWithContentsOfURL:[NSURL URLWithString:kURL]];
//        // 遍历及解析
//        for (NSDictionary*dict in array) {
//            MusicInfoModel*model=[[MusicInfoModel alloc]init];
//            [model setValuesForKeysWithDictionary:dict];
//            [self.dataArray addObject:model];
//        }
        // 下面的动作非常重要.
        /*
         程序执行到下面一行时, 对self.dataArray进行值捕获, 拿到并且带着这个数组, 跑到"定义该block的文件"中去执行代码. 那么就将这个数组的值, 传递到了另外一个界面.
         这是block的特性, 也是其他语言中 "闭包"的特性.
         */
        // 3.调用block, 将数组作为参数传出去.
        
        passValue(self.dataArray);
    });
}
// 懒加载, 懒加载能节省载入内存.
// 程序开始运行时, 对于没有立即使用的内存, 不进行加载, 等到什么时候用到, 再去开辟空间.
// 注意, 懒加载是重写变量的get方法实现的.
// 懒加载是一种典型的以"时间换空间"的优化方式.
-(NSMutableArray*)dataArray
{
    //这里不能用self.dataArray  不然或造成循环调用
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];//这里可以用self.dataArray  因为这里是setter方法
    }
    return _dataArray;
}

@end
