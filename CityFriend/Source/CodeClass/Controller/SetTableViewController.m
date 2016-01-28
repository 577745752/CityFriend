//
//  SetTableViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "SetTableViewController.h"

@interface SetTableViewController ()

@end
static NSString *const mysetVCID=@"myset";
@implementation SetTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self=[super initWithStyle:style]) {
        self.navigationItem.title=@"设置";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mysetVCID];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mysetVCID forIndexPath:indexPath];
    if (indexPath.row == 0&&indexPath.section==0) {
        cell.textLabel.text=@"更改头像";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }
    else if (indexPath.row == 1){
        cell.textLabel.text=@"修改密码";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }else if (indexPath.row == 2)
    {
        cell.textLabel.text =@"更改邮箱";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }else if (indexPath.row == 3)
    {
        cell.textLabel.text =@"更改手机号";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }else if (indexPath.row == 4)
    {
        cell.textLabel.text =@"联系人.隐私";
        UILabel*fuzhu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        fuzhu.text=@">";
        cell.accessoryView=fuzhu;
    }
    
    return cell;
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
