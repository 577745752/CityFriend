//
//  CategoriesViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.navigationItem.title=@"分类";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"分类" image:[UIImage imageNamed:@"2"] selectedImage:[UIImage imageNamed:@"2"]];
        self.view.backgroundColor=[UIColor yellowColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"分类";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"分类" image:[UIImage imageNamed:@"2"] selectedImage:[UIImage imageNamed:@"2"]];
    self.view.backgroundColor=[UIColor yellowColor];
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
