//
//  CateTableViewController.h
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateTableViewController : UITableViewController
@property(nonatomic,strong)NSString*classifyURL;
@property(nonatomic,strong)NSString*shopURL;
@property(nonatomic,strong)NSMutableArray*classifyArray;
@property(nonatomic,strong)NSMutableArray*shopArray;
@end