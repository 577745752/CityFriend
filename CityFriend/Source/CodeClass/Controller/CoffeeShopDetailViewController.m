//
//  CoffeeShopDetailViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CoffeeShopDetailViewController.h"

@interface CoffeeShopDetailViewController ()

@end

@implementation CoffeeShopDetailViewController
-(instancetype)init
{
    if (self=[super init]) {
        [self.view addSubview:self.shopNameLabel];
        [self.view addSubview:self.scrollView];
    }
    return self;
}
-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, kWidth, 10*kGap)];
        _shopNameLabel.backgroundColor=[UIColor orangeColor];
        _shopNameLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _shopNameLabel;
}
-(UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+10*kGap, kWidth, 25*kGap)];
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=NO;
        _scrollView.contentSize=CGSizeMake(kWidth*3, 25*kGap);
        //_scrollView.delegate=self;
    }
    return _scrollView;
}
-(void)setCoffee:(Coffee *)coffee
{
    if (_coffee!=coffee) {
        _coffee=nil;
        _coffee=coffee;
    }
    //1.创建URL
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?shopid=%@",kURL_coffeeShopContent,self.coffee.shopID]];
    //2.创建Session
    NSURLSession*session=[NSURLSession sharedSession];
    //3.创建Task(内部处理了请求,默认使用GET请求,直接传递url即可)
    NSURLSessionDataTask*dataTask=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析数据
        NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:nil];
        NSMutableDictionary*dataDict1=[NSMutableDictionary new];
        dataDict1=dataDict[@"data"];
        self.coffeeShop=[Coffeeshop new];
        [self.coffeeShop setValuesForKeysWithDictionary:dataDict1];
        dispatch_async(dispatch_get_main_queue(), ^{
            _shopNameLabel.text=self.coffeeShop.shopname;
        });
    }];
    //启动任务
    [dataTask resume];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
