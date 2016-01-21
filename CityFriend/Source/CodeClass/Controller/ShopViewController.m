//
//  ShopViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/21.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView*webView;
//过渡轮
@property(nonatomic,strong)UIActivityIndicatorView*activityIC;
@property(nonatomic,strong)UIButton*button;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button=[UIButton buttonWithType:UIButtonTypeSystem];
    self.button.backgroundColor=[UIColor redColor];
    [self.button setTitle:@"下面,是见证奇迹的时刻" forState:UIControlStateNormal];
    [self.button setTitle:@"你好丑" forState:UIControlStateHighlighted];
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button.frame=CGRectMake(0, 64, kWidth, 45);
    self.view.backgroundColor=[UIColor yellowColor];
    self.webView=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //自适应屏幕大小
    self.webView.scalesPageToFit=YES;
    //开启用户交互
    self.webView.userInteractionEnabled=YES;
    //设置代理
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.button];
    //网络加载
    //NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.shop.deal_h5_url]]];
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.shop.deal_url]]];
    //加载
    [self.webView loadRequest:request];
}
//代理方法
//开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //创建一个view 用来放activtyIC
    UIView*aView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aView.tag=101;
    aView.alpha=0.5;
    aView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:aView];
    //创建一个citivityIC
    self.activityIC=[[UIActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.activityIC.center=aView.center;
    [aView addSubview:self.activityIC];
    //开始动画
    [self.activityIC startAnimating];
    NSLog(@"开始加载");
}
//加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIView*view=[self.view viewWithTag:101];
    //停止动画
    [self.activityIC stopAnimating];
    //移除View
    [view removeFromSuperview];
    NSLog(@"加载完成");
}
//加载出错
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIView*view=[self.view viewWithTag:101];
    //停止动画
    [self.activityIC stopAnimating];
    //移除View
    [view removeFromSuperview];
    NSLog(@"加载出错");
}
-(void)buttonAction:(UIButton*)button
{
    
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
