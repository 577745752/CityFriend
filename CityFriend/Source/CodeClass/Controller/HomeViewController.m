//
//  HomeViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.navigationItem.title=@"首页";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"1"] selectedImage:[UIImage imageNamed:@"1"]];
        self.view.backgroundColor=[UIColor redColor];
    }
    
    
    
    
    
    
    
    
    
    return self;
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
