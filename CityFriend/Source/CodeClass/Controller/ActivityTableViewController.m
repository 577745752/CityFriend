//
//  ActivityTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivivtyDetailViewController.h"
@interface ActivityTableViewController ()
@property(nonatomic,strong)NSMutableArray*activityArray;
@property(nonatomic,strong)UIScrollView *scroView;
@end
static NSString*const cellID=@"cell";
@implementation ActivityTableViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.navigationItem.title=@"活动";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"活动" image:[UIImage imageNamed:@"2"] selectedImage:[UIImage imageNamed:@"2"]];
        self.view.backgroundColor=[UIColor colorWithRed:220 / 255.0 green:165 / 255.0 blue:45 / 255.0 alpha:1];
        
        UIBarButtonItem* right=[[UIBarButtonItem alloc]initWithTitle:@"发起活动" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
        self.navigationItem.rightBarButtonItem = right;
    }
    return self;
}
-(void)rightClick:(UIBarButtonItem*)item
{

    if ([AVUser currentUser] == nil)
    {
        
        LoginViewController *login=[LoginViewController new];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        
        AddActivityViewController*addActivityVC=[AddActivityViewController new];
        [self.navigationController pushViewController:addActivityVC animated:YES];
    }
    
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//-(void)viewWillAppear:(BOOL)animated{
//    [self loadData];
//}
-(void)loadData
{
    //TableView的数据
    self.activityArray=[NSMutableArray new];
    AVQuery *query = [AVQuery queryWithClassName:@"Activity"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // 检索成功
        if (!error) {
            for (AVObject * obj in objects) {
                [self.activityArray addObject:obj];
            }
                            //刷新ui
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
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

    return [self.activityArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text=self.activityArray[indexPath.row][@"localData"][@"title"];
    cell.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:165 / 255.0 blue:45 / 255.0 alpha:1];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lu",indexPath.row);
    ActivivtyDetailViewController *new = [ActivivtyDetailViewController new];
    new.objc = self.activityArray[indexPath.row];
    new.yesOrNo = YES;
    [self.navigationController pushViewController:new animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeight / 3;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight / 3)];
    _scroView.contentSize = CGSizeMake(kWidth * 2, kHeight / 3);
    _scroView.pagingEnabled = YES;
    _scroView.contentOffset = CGPointMake(0, 0);
    _scroView.backgroundColor = [UIColor grayColor];
    
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight / 3)];
    imgView1.image = [UIImage imageNamed:@"HappyTogether.jpeg"];
    [_scroView addSubview:imgView1];
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight / 3)];
    imgView2.image = [UIImage imageNamed:@"HappyTogether1.jpg"];
    [_scroView addSubview:imgView2];
    
    return _scroView;
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
