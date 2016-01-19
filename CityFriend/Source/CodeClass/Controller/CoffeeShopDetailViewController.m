//
//  CoffeeShopDetailViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CoffeeShopDetailViewController.h"

@interface CoffeeShopDetailViewController ()<UIScrollViewDelegate>

@end

@implementation CoffeeShopDetailViewController
-(instancetype)init
{
    if (self=[super init]) {
        [self.view addSubview:self.shopNameLabel];
        [self.view addSubview:self.scrollView];
        [self.view addSubview:self.pageControl];
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
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+10*kGap, kWidth, 30*kGap)];
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=NO;
        _scrollView.contentSize=CGSizeMake(kWidth*3, 30*kGap);
        _scrollView.delegate=self;
    }
    return _scrollView;
}
-(UIPageControl*)pageControl
{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        _pageControl.center=CGPointMake(self.view.bounds.size.width/2,44+35*kGap);
        //设置圆点个数
        _pageControl.numberOfPages=3;
        //设置(选中)圆点颜色
        _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        //设置默认选中的圆点
        _pageControl.currentPage=0;
        
        //事件
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
-(void)changePage:(UIPageControl*)pageControl
{
    //根据pageControl的当前页来设定scrollView的偏移量
    CGPoint point=CGPointMake(pageControl.currentPage*kWidth, 0);
    //让scrollView根据pageControl的当前页计算出来的偏移量进行偏移
    _scrollView.contentOffset=point;
    
}
//代理方法  结束减速时执行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取偏移量
    CGFloat x = self.scrollView.contentOffset.x;
    //根据偏移量控制pageControl的当前页
    self.pageControl.currentPage = x/kWidth;
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
            UIImageView*imgView0=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30*kGap)];
            [imgView0 sd_setImageWithURL:[NSURL URLWithString:self.coffee.logo]];
            UIImageView*imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, 30*kGap)];
            [imgView1 sd_setImageWithURL:[NSURL URLWithString:self.coffeeShop.picture]];
            UIImageView*imgView2=[[UIImageView alloc]initWithFrame:CGRectMake(2*kWidth, 0, kWidth, 30*kGap)];
            [imgView2 sd_setImageWithURL:[NSURL URLWithString:self.coffeeShop.specialpic]];
            [_scrollView addSubview:imgView0];
            [_scrollView addSubview:imgView1];
            [_scrollView addSubview:imgView2];
            
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
