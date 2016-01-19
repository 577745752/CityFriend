//
//  CoffeeTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "CoffeeTableViewController.h"

@interface CoffeeTableViewController ()

@end
static NSString*coffeeID=@"coffee";
@implementation CoffeeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CoffeeTableViewCell class] forCellReuseIdentifier:coffeeID];
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)loadData
{
    self.coffeeArray=[NSMutableArray new];
    //1.创建URL
    NSURL*Url=[NSURL URLWithString:kURL_coffee];
    //2.创建Session
    NSURLSession*session=[NSURLSession sharedSession];
    //3.创建Task(内部处理了请求,默认使用GET请求,直接传递url即可)
    NSURLSessionDataTask*dataTask=[session dataTaskWithURL:Url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析数据
        NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:nil];
        NSMutableArray*dataArray=[NSMutableArray new];
        dataArray=dataDict[@"data"];
        for (NSDictionary*dict in dataArray) {
            Coffee*coffee=[Coffee new];
            [coffee setValuesForKeysWithDictionary:dict];
            [self.coffeeArray addObject:coffee];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
    //启动任务
    [dataTask resume];

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

    return [self.coffeeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoffeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coffeeID forIndexPath:indexPath];
    Coffee*coffee=[Coffee new];
    coffee=self.coffeeArray[indexPath.row];
    cell.coffee=coffee;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoffeeShopDetailViewController*coffeeShopDetailVC=[CoffeeShopDetailViewController new];
    Coffee*coffee=[Coffee new];
    coffee=self.coffeeArray[indexPath.row];
    coffeeShopDetailVC.coffee=coffee;
    [self.navigationController pushViewController:coffeeShopDetailVC  animated:YES];
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth / 4;
}
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
