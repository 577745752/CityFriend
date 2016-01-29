//
//  ShopTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ShopTableViewController.h"

@interface ShopTableViewController ()
@property (nonatomic, retain) NSMutableDictionary *dataDic;

@property (nonatomic, retain) NSMutableArray *dataArray;
//要请求数据的URL
@property (nonatomic, retain) NSString *urlStr;
@end
static NSString*shopID=@"shop";
@implementation ShopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@,%@",self.cityName,self.category);
    [self.tableView registerClass:[ShopTableViewCell class] forCellReuseIdentifier:shopID];
    [self setUrlCategory:_category andCityName:_cityName];
    [self loadData];
}
//解析网址(将中文类型和城市用NSUTF8StringEncoding转码,生成网址)
-(void)setUrlCategory:(NSString *)category andCityName:(NSString *)cityName{
    self.navigationItem.title = [NSString stringWithFormat:@"%@",category];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:cityName, @"city", category, @"category", @"30", @"limit", @"1", @"page", nil];
    self.dataDic = [SignatrueEncryption encryptedParamsWithBaseParams:dictionary];
    self.urlStr = [NSString stringWithFormat:@"%@/v1/deal/find_deals?appkey=%@&sign=%@&city=%@&category=%@&limit=30&page=1", kBASE_SERVER_URL, kAPP_KEY, _dataDic[@"sign"], dictionary[@"city"], dictionary[@"category"]];
    _urlStr = [_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@", _urlStr);
}
//JSON解析
-(void)loadData{
    //创建URL
    NSURL*url=[NSURL URLWithString:_urlStr];
    //创建Session
    NSURLSession*session=[NSURLSession sharedSession];
    //创建Task(内部处理了请求,默认使用get请求,直接传递url即可)
    NSURLSessionDataTask*dataTask=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            //解析数据
            NSDictionary*dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSMutableArray*array=[NSMutableArray new];
            array = dictionary[@"deals"];
            //封装model
            //初始化笑话数组
            self.dataArray=[NSMutableArray arrayWithCapacity:30];
            for (NSDictionary *dic in array) {
                Shop *shop = [Shop new];
                [shop setValuesForKeysWithDictionary:dic];
                [_dataArray addObject:shop];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
//            //  验证model
//            for (Shop*shop in self.dataArray) {
//                NSLog(@"%@",shop.title);
//            }
        }else{
            UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"没有网络啊,亲" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*action=[UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
        }
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
    
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopID forIndexPath:indexPath];
    Shop*shop=self.dataArray[indexPath.row];
    cell.shop=shop;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWidth/4+2*kGap;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopViewController*shopVC=[ShopViewController new];
    Shop*shop=self.dataArray[indexPath.row];
    shopVC.shopTitle = shop.title;
    shopVC.deal_url=shop.deal_url;
    [self.navigationController pushViewController:shopVC animated:YES];
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
