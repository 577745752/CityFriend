//
//  ClassifyTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/18.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ClassifyTableViewController.h"

@interface ClassifyTableViewController ()

@end
static NSString*classifyID=@"classify";
@implementation ClassifyTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self=[super initWithStyle:style]) {
    }
    return self;
}
-(void)reloadData
{
    self.classifyArray=[[NSMutableArray alloc]init];
    self.shopArray=[[NSMutableArray alloc]init];
    [[GetDataTools shareGetData] getData:self.classifyURL Block:^(NSMutableArray *dataArray) {
        for (NSDictionary*dict in dataArray) {
            FoodClassify*foodClassify=[FoodClassify new];
            [foodClassify setValuesForKeysWithDictionary:dict];
            [self.classifyArray addObject:foodClassify];
            
        }
        
        
        [GetDataTools shareGetData].foodClassifyArray=self.classifyArray;
        
//        for (int i=0; i<[self.classifyArray count]; i++) {
//            FoodClassify* foodClassify=[FoodClassify new];
//            foodClassify=self.classifyArray[i];
//       }

        for (FoodClassify* foodClassify in self.classifyArray) {
            
            //1.创建url
            NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?cateid=%@",self.shopURL,foodClassify.foodID]];
            //2.创建请求对象
            NSMutableURLRequest*request=[[NSMutableURLRequest alloc]initWithURL:url];
            //设置请求方式(默认为GET,可以不写)
            [request setHTTPMethod:@"GET"];
            //3.创建响应者
            NSURLResponse*response=nil;
            //4.创建错误对象
            NSError*error=nil;
            //5.请求,链接
            NSData*data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSMutableArray*dataArray=[NSMutableArray new];
                                    dataArray=dataDict[@"data"];
                                     NSLog(@"%@",dataArray);
                                    NSMutableArray*dataArray1=[NSMutableArray new];
                                    for (NSDictionary*dict in dataArray) {
                                        FoodShop*foodShop=[FoodShop new];
                                        [foodShop setValuesForKeysWithDictionary:dict];
                                        [dataArray1 addObject:foodShop];
                                    }
                                    [self.shopArray addObject:dataArray1];
                                   // NSLog(@"%ld",[self.shopArray count]);
//                                    dispatch_sync(dispatch_get_main_queue(), ^{
//                                        [self.tableView reloadData];
//                                    });
                                  [self.tableView reloadData];

   

            
            
            
            
            
            
            
            
            
            
            
//                    //1.创建URL
//                    NSURL*Url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?cateid=%@",self.shopURL,foodClassify.foodID]];
//           
//                    //2.创建Session
//                    NSURLSession*session=[NSURLSession sharedSession];
//                    //3.创建Task(内部处理了请求,默认使用GET请求,直接传递url即可)
//                    NSURLSessionDataTask*dataTask=[session dataTaskWithURL:Url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                        //解析数据
//                        NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:nil];
//                        NSMutableArray*dataArray=[NSMutableArray new];
//                        dataArray=dataDict[@"data"];
//                         NSLog(@"%@",dataArray);
//                        NSMutableArray*dataArray1=[NSMutableArray new];
//                        for (NSDictionary*dict in dataArray) {
//                            FoodShop*foodShop=[FoodShop new];
//                            [foodShop setValuesForKeysWithDictionary:dict];
//                            [dataArray1 addObject:foodShop];
//                        }
//                        [self.shopArray addObject:dataArray1];
//                       // NSLog(@"%ld",[self.shopArray count]);
//                        dispatch_sync(dispatch_get_main_queue(), ^{
//                            [self.tableView reloadData];
//                        });
//                    }];
//                    
//                    //启动任务
//                    [dataTask resume];

                }
        }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ClassifyTableViewCell class] forCellReuseIdentifier:classifyID];
    [self reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return self.shopArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.shopArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classifyID forIndexPath:indexPath];
    FoodShop*foodShop=[FoodShop new];
    foodShop=self.shopArray[indexPath.section][indexPath.row];
    cell.foodShop=foodShop;
    
    // Configure the cell...
    
    return cell;
}
//设置区头
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView*header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    header.backgroundColor=[UIColor yellowColor];
//        FoodClassify*foodClassify=[FoodClassify new];
//        foodClassify=self.classifyArray[section];
//    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
//    label.text=foodClassify.name;
//    [header addSubview:label];
//    return header;
//}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    FoodClassify*foodClassify=[FoodClassify new];
    foodClassify=self.classifyArray[section];
    return foodClassify.name;
//    if (section!=4) {
//        FoodShop*foodShop=[FoodShop new];
//        foodShop=self.shopArray[section][0];
//        return foodShop.typeName;
//    }
//    return @"自助餐";
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8*kGap;
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
