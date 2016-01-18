//
//  UserTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "UserTableViewController.h"

@interface UserTableViewController ()

@end

@implementation UserTableViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.navigationItem.title=@"我的";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"4"] selectedImage:[UIImage imageNamed:@"4"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.contentView.backgroundColor=[UIColor grayColor];
        UIImageView *portrait =[[UIImageView alloc]initWithFrame:CGRectMake(5*kWidth/14, 3*kGap, kWidth/3.5,kWidth/3.5)];
        portrait.layer.cornerRadius=kWidth/7;
        portrait.layer.masksToBounds=YES;
        portrait.image=[UIImage imageNamed:@"5"];
        [cell.contentView addSubview:portrait];
        
        UIButton *loginButton =[UIButton buttonWithType:UIButtonTypeSystem];
        loginButton.frame = CGRectMake(kWidth/4, kHeight/5, 10*kGap, 5*kGap);
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        
        [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:loginButton];

        UIButton *registeredButton =[UIButton buttonWithType:UIButtonTypeSystem];
        registeredButton.frame=CGRectMake(3*kWidth/4-10*kGap, kHeight/5, 10*kGap, 5*kGap);
        [registeredButton setTitle:@"注册" forState:UIControlStateNormal];
        [registeredButton addTarget:self action:@selector(registered:) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:registeredButton];
        return cell;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0&&indexPath.section==1) {
        cell.textLabel.text=@"我的活动";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }
    else if (indexPath.row == 1){
    cell.textLabel.text=@"我的约会";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }else if (indexPath.row == 2)
    {
   cell.textLabel.text =@"我的收藏";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }else if (indexPath.row == 3)
    {
        cell.textLabel.text =@"推荐应用给好友";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }else if (indexPath.row == 4)
    {
        cell.textLabel.text =@"帮助与反馈";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }else if (indexPath.row == 5)
    {
        cell.textLabel.text =@"设置";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return kHeight/5+8*kGap;
    }
    return 8*kGap;
}
-(void)login:(UIButton *)button
{  LoginViewController *login=[LoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
    
}
-(void)registered:(UIButton *)button
{
    RegisterViewController *registered =[RegisterViewController new];
    
    [self.navigationController pushViewController:registered animated:YES];
    
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
