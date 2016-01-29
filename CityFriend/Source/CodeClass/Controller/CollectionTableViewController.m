//
//  CollectionTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CollectionTableViewController.h"

@interface CollectionTableViewController ()
@property(nonatomic,strong)NSMutableArray *shopArray;
@end
static NSString *const mycollecVCID=@"mycollecVC";
@implementation CollectionTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self=[super initWithStyle:style]) {
        self.navigationItem.title=@"我的活动";
        
        [self loadData];
    }
    
    return self;
}
-(void)loadData{
    self.shopArray = [NSMutableArray new];
    AVQuery *query = [AVQuery queryWithClassName:@"Shop"];
    [query whereKey:@"userName"equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for (AVObject *ob in objects) {
                NSMutableDictionary *dict = [NSMutableDictionary new];
                [dict setObject:ob[@"shopTitle"]forKey:@"shopTitle"];
                [dict setObject:ob[@"shopUrl"] forKey:@"shopUrl"];
                [self.shopArray addObject:dict];
                //NSLog(@"====%@",ob[@"shopTitle"]);
            }
        }
        else{
            NSLog(@"%@",error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mycollecVCID];
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
    //NSLog(@"%lu",self.shopArray.count);
    return self.shopArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycollecVCID forIndexPath:indexPath];
    cell.textLabel.text = self.shopArray[indexPath.row][@"shopTitle"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopViewController*shopVC=[ShopViewController new];
    shopVC.shopTitle = self.shopArray[indexPath.row][@"shopTitle"];
    shopVC.deal_url=self.shopArray[indexPath.row][@"shopUrl"];
    [self.navigationController pushViewController:shopVC animated:YES];
    
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
