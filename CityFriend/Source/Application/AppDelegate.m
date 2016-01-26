//
//  AppDelegate.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // applicationId 即 App Id，clientKey 是 App Key。
    [AVOSCloud setApplicationId:@"0QSAP49r6CUTyaXyuWaxqFqu-gzGzoHsz"
                      clientKey:@"kykFAkFURKUf91MYWvi5waaw"];
    //如果想跟踪统计应用的打开情况，后面还可以添加下列代码：
    //[AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController*homeNC=[[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
     UINavigationController*activityNC=[[UINavigationController alloc]initWithRootViewController:[ActivityTableViewController new]];
     UINavigationController*friendNC=[[UINavigationController alloc]initWithRootViewController:[[FriendViewController alloc] init]];
     UINavigationController*userNC=[[UINavigationController alloc]initWithRootViewController:[UserTableViewController new]];
    friendNC.navigationController.hidesBottomBarWhenPushed = YES;
    friendNC.tabBarController.hidesBottomBarWhenPushed = YES;
    
    UITabBarController*tab=[[UITabBarController alloc]init];
    tab.viewControllers=@[homeNC,activityNC,friendNC,userNC];
    self.window.rootViewController=tab;
    tab.selectedIndex=0;

    //背景色设置
    [UINavigationBar appearance].barTintColor=[UIColor colorWithRed:150/255.0  green:237/255.0  blue:226/255.0 alpha:1];
    tab.tabBar.barTintColor = [UIColor colorWithRed:150/255.0  green:237/255.0  blue:226/255.0 alpha:1];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
