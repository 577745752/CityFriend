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
-(void)getData:(NSString*)url Block:(PassValue)passValue;
{

//    dispatch_queue_t global=dispatch_get_global_queue(0, 0);// 创建全局队列, 全局队列的特点是所有任务都是在子线程中执行, 并且是并发执行.
//    dispatch_async(global, ^{
        //1.创建URL
        NSURL*Url=[NSURL URLWithString:url];
        //2.创建Session
        NSURLSession*session=[NSURLSession sharedSession];
        //3.创建Task(内部处理了请求,默认使用GET请求,直接传递url即可)
        NSURLSessionDataTask*dataTask=[session dataTaskWithURL:Url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //解析数据
            NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:nil];
            NSDictionary*dataDict1=[NSDictionary new];
            dataDict1=dataDict[@"data"];
            NSMutableArray*dataArray=[NSMutableArray new];
            dataArray=dataDict1[@"cate"];
            passValue(dataArray);
                    }];
    
        //启动任务
        [dataTask resume];

//    });
}
// 懒加载, 懒加载能节省载入内存.
// 程序开始运行时, 对于没有立即使用的内存, 不进行加载, 等到什么时候用到, 再去开辟空间.
// 注意, 懒加载是重写变量的get方法实现的.
// 懒加载是一种典型的以"时间换空间"的优化方式.
-(NSMutableArray*)foodClassifyArray
{
    //这里不能用self.dataArray  不然或造成循环调用
    if (_foodClassifyArray==nil) {
        _foodClassifyArray=[[NSMutableArray alloc]init];//这里可以用self.dataArray  因为这里是setter方法
    }
    return _foodClassifyArray;
}

@end
