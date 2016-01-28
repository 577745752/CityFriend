//
//  ActivedicTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ActivedicTableViewController.h"
#import "ActivivtyDetailViewController.h"
@interface ActivedicTableViewController ()
@property(nonatomic,strong)NSMutableArray *myActivitiesArray;
@end

static NSString *const myactiveVCID=@"myactiveVC";

@implementation ActivedicTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self=[super initWithStyle:style]) {
        self.navigationItem.title=@"我的活动";
        [self darwAtcion];
    }
    
    return self;
}

-(void)darwAtcion {
    _myActivitiesArray = [NSMutableArray new];
    AVQuery *query = [AVQuery queryWithClassName:@"Activity"];
    //[query whereKey:@"title" equalTo:self.titleLabel.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (int i  = 0; i<[objects count]; i++) {
            if ([objects[i][@"counts"] containsObject:[AVUser currentUser].username]) {
                [_myActivitiesArray addObject:objects[i][@"title"]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:myactiveVCID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _myActivitiesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myactiveVCID forIndexPath:indexPath];
    cell.textLabel.text = _myActivitiesArray[indexPath.row];
    NSLog(@"%@",_myActivitiesArray[indexPath.row]);
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivivtyDetailViewController *new = [ActivivtyDetailViewController new];
    NSString *str = [NSString new];
    str = _myActivitiesArray[indexPath.row];
    AVQuery *query = [AVQuery queryWithClassName:@"Activity"];
    [query whereKey:@"title" equalTo:str];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        AVObject *obj = [AVObject objectWithClassName:@"Activity"];
        obj = objects[0];
        NSLog(@"%@",obj[@"counts"]);
        new.objc = obj;
        new.yesOrNo = NO;
        [self.navigationController pushViewController:new animated:YES];
    }];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
