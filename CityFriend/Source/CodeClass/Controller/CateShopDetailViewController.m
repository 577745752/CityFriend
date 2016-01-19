//
//  CateShopDetailViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CateShopDetailViewController.h"

@interface CateShopDetailViewController ()

@end

@implementation CateShopDetailViewController

-(instancetype)init
{
    if (self=[super init]) {
        [self.view addSubview:self.shopNameLabel];
    }
    return self;
}
-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, kWidth, 10*kGap)];
        _shopNameLabel.backgroundColor=[UIColor orangeColor];
    }
    return _shopNameLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor grayColor];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    //[self loadData];
    
}
-(void)setFoodShop:(FoodShop *)foodShop
{
    if (_foodShop!=foodShop) {
        _foodShop=nil;
        _foodShop=foodShop;
    }
    //1.创建URL
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?shopid=%@",kURL_foodShopContent,self.foodShop.shopID]];
    
    //2.创建Session
    NSURLSession*session=[NSURLSession sharedSession];
    //3.创建Task(内部处理了请求,默认使用GET请求,直接传递url即可)
    NSURLSessionDataTask*dataTask=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析数据
        NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:nil];
        NSMutableDictionary*dataDict1=[NSMutableDictionary new];
        dataDict1=dataDict[@"data"];
        self.foodShopContent=[FoodShopContent new];
        [self.foodShopContent setValuesForKeysWithDictionary:dataDict1];
        dispatch_async(dispatch_get_main_queue(), ^{
            _shopNameLabel.text=self.foodShopContent.shopname;
        });
        
    }];
    
    //启动任务
    [dataTask resume];
    
}
-(void)loadData
{
    //1.创建url
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?shopid=%@",kURL_foodShopContent,self.foodShop.shopID]];
    //2.创建请求对象
    NSMutableURLRequest*request=[[NSMutableURLRequest alloc]initWithURL:url];
    //设置请求方式(默认为GET,可以不写)
    [request setHTTPMethod:@"GET"];
    //3.创建响应者
    NSURLResponse*response=nil;
    //4.创建错误对象
    NSError*error=nil;
    //5.请求,链接
    NSData*data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableDictionary*dataDict1=[NSMutableDictionary new];
    dataDict1=dataDict[@"data"];
    self.foodShopContent=[FoodShopContent new];
    [self.foodShopContent setValuesForKeysWithDictionary:dataDict1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
