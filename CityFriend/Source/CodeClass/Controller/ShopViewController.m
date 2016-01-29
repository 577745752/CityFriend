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
//-(void)viewWillAppear:(BOOL)animated{
//    AVQuery *query = [AVQuery queryWithClassName:@"Shop"];
//    [query whereKey:@"userName"equalTo:[AVUser currentUser].username];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if(!error){
//            for (AVObject *ob in objects) {
//                if([ob[@"shopTitle"]isEqualToString:self.shop.title ]){
//                    [self.button setTitle:@"已收藏" forState:UIControlStateNormal];
//                    self.button.backgroundColor=[UIColor greenColor];
//                }
//                else{
//                    NSLog(@"%@",error);
//                }
//            }
//        }
//    }];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.button=[UIButton buttonWithType:UIButtonTypeSystem];
    self.button.backgroundColor=[UIColor redColor];
    [self.button setTitle:@"收藏店铺" forState:UIControlStateNormal];
    //[self.button setTitle:@"你好丑" forState:UIControlStateHighlighted];
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
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.deal_url]]];
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
    AVQuery *query = [AVQuery queryWithClassName:@"Shop"];
    [query whereKey:@"userName"equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            //if(objects.count != 0){
            BOOL a = YES;
            for (AVObject *ob in objects) {
                if([ob[@"shopUrl"]isEqualToString:self.deal_url])
                {
                    UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"您已经收藏过该店铺了!" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*action=[UIAlertAction actionWithTitle:@"哦了~" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:action];
                    [self presentViewController:alertController animated:YES completion:nil];
                    a = NO;
                }
                else
                {
                    a = YES;
                    //dispatch_async(dispatch_get_main_queue(), ^{
                    //                            [self.button setTitle:@"已收藏" forState:UIControlStateNormal];
                    //                            self.button.backgroundColor=[UIColor greenColor];
                    //                        });
                    //break;
                }
            }
            if (a == YES) {
                //写入
                AVObject *objc = [AVObject objectWithClassName:@"Shop"];
                [objc setObject:[AVUser currentUser].username forKey:@"userName"];
                [objc setObject:self.shopTitle forKey:@"shopTitle"];
                [objc setObject:self.deal_url forKey:@"shopUrl"];
                [objc save];
                UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功!!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*action=[UIAlertAction actionWithTitle:@"干得漂亮~~" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            
        }
        //            else{
        //                //写入
        //                AVObject *objc = [AVObject objectWithClassName:@"Shop"];
        //                [objc setObject:[AVUser currentUser].username forKey:@"userName"];
        //                [objc setObject:self.shop.title forKey:@"shopTitle"];
        //                [objc setObject:self.shop.deal_url forKey:@"shopUrl"];
        //                [objc save];
        //                UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功!!" preferredStyle:UIAlertControllerStyleAlert];
        //                UIAlertAction*action=[UIAlertAction actionWithTitle:@"干得漂亮~~" style:UIAlertActionStyleDefault handler:nil];
        //                [alertController addAction:action];
        //                [self presentViewController:alertController animated:YES completion:nil];
        ////                dispatch_async(dispatch_get_main_queue(), ^{
        ////                    [self.button setTitle:@"已收藏" forState:UIControlStateNormal];
        ////                    self.button.backgroundColor=[UIColor greenColor];
        ////                });
        //
        //            }
        //        }
        else{
            UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"收藏失败了!!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*action=[UIAlertAction actionWithTitle:@"干得漂亮~~" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            NSLog(@"%@",error);
        }
    }];
    
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
