//
//  CateShopDetailViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CateShopDetailViewController.h"

@interface CateShopDetailViewController ()<UIScrollViewDelegate>

@end

@implementation CateShopDetailViewController

-(instancetype)init
{
    if (self=[super init]) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:self.shopNameLabel];
        [self.view addSubview:self.scrollView];
        [self.view addSubview:self.pageControl];
        [self.view addSubview:self.addressLabel];
        [self.view addSubview:self.telLabel];
        [self.view addSubview:self.contentLabel];
    }
    return self;
}
-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, kWidth, 10*kGap)];
        _shopNameLabel.font = [UIFont systemFontOfSize:25];
        _shopNameLabel.textColor = [UIColor colorWithRed:5/255.0 green:160/255.0 blue:174/255.0 alpha:1];
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
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(5*kGap, kHeight / 2 + 5 * kGap, kWidth - 10 * kGap, 7 * kGap)];
        //_addressLabel.backgroundColor = [UIColor grayColor];
        _addressLabel.numberOfLines = 0;
        _addressLabel.font = [UIFont systemFontOfSize:20];
    }
    return _addressLabel;
}
-(UILabel *)telLabel{
    if (!_telLabel) {
        _telLabel = [[UILabel alloc]initWithFrame:CGRectMake(5*kGap, kHeight / 2 + 14 * kGap, kWidth - 10 * kGap, 5 * kGap)];
        //_telLabel.backgroundColor = [UIColor greenColor];
        _telLabel.font = [UIFont systemFontOfSize:20];
    }
    return _telLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * kGap, kHeight / 2 + 21 * kGap, kWidth - 10 * kGap, 20 * kGap)];
        //_contentLabel.backgroundColor = [UIColor orangeColor];
        _contentLabel.font = [UIFont systemFontOfSize:20];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
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


-(void)viewWillAppear:(BOOL)animated
{
    //[self loadData];
    
}
-(void)setCate:(Cate *)cate
{
    if (_cate!=cate) {
        _cate=nil;
        _cate=cate;
    }
    //1.创建URL
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?shopid=%@",kURL_cateShopContent,self.cate.shopID]];
    
    //2.创建Session
    NSURLSession*session=[NSURLSession sharedSession];
    //3.创建Task(内部处理了请求,默认使用GET请求,直接传递url即可)
    NSURLSessionDataTask*dataTask=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析数据
        NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:nil];
        NSMutableDictionary*dataDict1=[NSMutableDictionary new];
        dataDict1=dataDict[@"data"];
        self.cateShop=[CateShop new];
        [self.cateShop setValuesForKeysWithDictionary:dataDict1];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            UIImageView*imgView0=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30*kGap)];
            [imgView0 sd_setImageWithURL:[NSURL URLWithString:self.cate.logo]];
            UIImageView*imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, 30*kGap)];
            [imgView1 sd_setImageWithURL:[NSURL URLWithString:self.cateShop.picture]];
            UIImageView*imgView2=[[UIImageView alloc]initWithFrame:CGRectMake(2*kWidth, 0, kWidth, 30*kGap)];
            [imgView2 sd_setImageWithURL:[NSURL URLWithString:self.cateShop.specialpic]];
            [_scrollView addSubview:imgView0];
            [_scrollView addSubview:imgView1];
            [_scrollView addSubview:imgView2];
            
            _shopNameLabel.text=self.cateShop.shopname;
            _addressLabel.text = [NSString stringWithFormat:@"地址: %@",self.cateShop.address];
            _telLabel.text = [NSString stringWithFormat:@"电话: %@",self.cateShop.tel];
            
            NSArray *array = [NSArray new];
            array = [self.cateShop.content componentsSeparatedByString:@">"];
            NSArray *array1 = [NSArray new];
            array1 = [array[1] componentsSeparatedByString:@"<"];
            
            _contentLabel.text = [NSString stringWithFormat:@"简介: %@",array1[0]];

        });
        
    }];
    
    //启动任务
    [dataTask resume];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor grayColor];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePage) userInfo:self repeats:YES];

    // Do any additional setup after loading the view.
}
-(void)changePage{
    
    //每次方法执行的时候,"当前页加1"
    self.currentIndex ++;//默认显示页面为0时
    //越界判断
    if(self.currentIndex == 3){
        self.currentIndex = 0;
    }
    //根据"当前页"属性设置pagecontrol当前页
    self.pageControl.currentPage = self.currentIndex;
    //根据"当前页"来设置scrollview的偏移量
    self.scrollView.contentOffset = CGPointMake(kWidth * self.currentIndex, 0);
}

-(void)loadData
{
    //1.创建url
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?shopid=%@",kURL_cateShopContent,self.cate.shopID]];
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
    self.cateShop=[CateShop new];
    [self.cateShop setValuesForKeysWithDictionary:dataDict1];
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
