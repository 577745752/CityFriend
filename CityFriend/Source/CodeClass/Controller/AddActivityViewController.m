//
//  AddActivityViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "AddActivityViewController.h"

@interface AddActivityViewController ()<UITextViewDelegate>
@property(nonatomic,strong)NSString * str;
//用来暂时存储群名称
@property(nonatomic,strong)NSString *qunName;
@end

@implementation AddActivityViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(register1:)];
        self.navigationItem.title=@"发布活动";
        self.str=@"";
        [self drawView];
        
    }
    return self;
}
-(void)drawView
{
    //这里一定要用self.xxxx,代表getter方法,若是用_xxxx则是属性,不会执行getter方法
    [self.view addSubview:self.activityTitleLabel];
    [self.view addSubview:self.activityTimeLabel];
    [self.view addSubview:self.addressLabel];
    [self.view addSubview:self.concentLabel];
    [self.view addSubview:self.activityTitleTextField];
    [self.view addSubview:self.activityTimeTextField];
    [self.view addSubview:self.addressTextField];
    [self.view addSubview:self.concentView];
}
-(UILabel*)activityTitleLabel
{
    if (!_activityTitleLabel) {
        _activityTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 12*kGap,kWidth/4,5*kGap)];
        _activityTitleLabel.text=@"活动标题:";
        
    }
    return _activityTitleLabel;
}
-(UILabel*)activityTimeLabel
{
    if (!_activityTimeLabel) {
        _activityTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 20*kGap,kWidth/4,5*kGap)];
        _activityTimeLabel.text=@"活动时间:";
        
    }
    return _activityTimeLabel;
}
-(UILabel*)addressLabel
{
    if (!_addressLabel) {
        _addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 28*kGap,kWidth/4,5*kGap)];
        _addressLabel.text=@"活动地点:";
        
    }
    return _addressLabel;
}
-(UILabel*)concentLabel
{
    if (!_concentLabel) {
        _concentLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/8, 36*kGap,kWidth/4,5*kGap)];
        _concentLabel.text=@"活动内容:";
        
    }
    return _concentLabel;
}
-(UITextField*)activityTitleTextField
{
    if (!_activityTitleTextField) {
        _activityTitleTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 12*kGap, kWidth/2, 5*kGap)];
        _activityTitleTextField.placeholder=@"请输入活动标题";
        _activityTitleTextField.layer.borderWidth=1;
        _activityTitleTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _activityTitleTextField.layer.cornerRadius=5;
        _activityTitleTextField.layer.masksToBounds=YES;
        _activityTitleTextField.alpha=0.5;
    }
    return _activityTitleTextField;
}
-(UITextField*)activityTimeTextField
{
    if (!_activityTimeTextField) {
        _activityTimeTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 20*kGap, kWidth/2, 5*kGap)];
        _activityTimeTextField.placeholder=@"请输入活动时间";
        _activityTimeTextField.layer.borderWidth=1;
        _activityTimeTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _activityTimeTextField.layer.cornerRadius=5;
        _activityTimeTextField.layer.masksToBounds=YES;
        _activityTimeTextField.alpha=0.5;
    }
    return _activityTimeTextField;
}
-(UITextField*)addressTextField
{
    if (!_addressTextField) {
        _addressTextField=[[UITextField alloc]initWithFrame:CGRectMake(3*kWidth/8, 28*kGap, kWidth/2, 5*kGap)];
        _addressTextField.placeholder=@"请输入活动地点";
        _addressTextField.layer.borderWidth=1;
        _addressTextField.layer.borderColor=[UIColor grayColor].CGColor;
        _addressTextField.layer.cornerRadius=5;
        _addressTextField.layer.masksToBounds=YES;
        _addressTextField.alpha=0.5;
    }
    return _addressTextField;
}
-(UITextView*)concentView
{
    if (!_concentView) {
        _concentView=[[UITextView alloc]initWithFrame:CGRectMake(3*kWidth/8, 36*kGap, kWidth/2, 35*kGap)];
        _concentView.text=@"请输入活动内容";
        _concentView.textColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:226 / 255.0 alpha:1];
        //_concentView.alpha=0.2;
        //_concentView.clearsOnInsertion = YES;
        _concentView.delegate = self;
        _concentView.font = [UIFont systemFontOfSize:17];
        _concentView.layer.borderWidth=1;
        _concentView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _concentView.layer.cornerRadius=5;
        _concentView.layer.masksToBounds=YES;
        //文字对齐方式 左对齐
    }
    return _concentView;
}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if([_str isEqualToString:@""]){
        _concentView.text = @"";
        _concentView.textColor = [UIColor grayColor];
    }
    else{
    }
    return YES;
}
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    _str = _concentView.text;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)register1:(UIBarButtonItem*)item
{
    if ([_activityTitleTextField.text isEqualToString:@""]) {
        UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"活动标题不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action=[UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if([_activityTimeTextField.text isEqualToString:@""]){
        UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"活动时间不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action=[UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if([_addressTextField.text isEqualToString:@""]){
        UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"活动地点不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action=[UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if([_concentView.text isEqualToString:@""]){
        UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"活动内容不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action=[UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        //发布活动时,创建群
        UIAlertController*setQun=[UIAlertController alertControllerWithTitle:@"" message:@"请输入群id" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //获取要要创建的群的id
            UITextField*text=(UITextField*)[setQun.view viewWithTag:107];
            
            //在群表中查询群id是否已经存在
            AVQuery *query = [AVQuery queryWithClassName:@"Qun"];
            [query whereKey:@"qunname" equalTo:text.text];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error == nil) {
                    //如果返回的用户数组不为空,说明该群名称已经存在了
                    if ([objects count]) {
                        UIAlertController*qunmingbeizhanyong=[UIAlertController alertControllerWithTitle:@"提示" message:@"群名称已经被占用了" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction*zhidaole=[UIAlertAction actionWithTitle:@"哥乌恩滚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        [qunmingbeizhanyong addAction:zhidaole];
                        [self presentViewController:qunmingbeizhanyong animated:YES completion:nil];
                    }else{//如果返回的用户数组为空,才可以创建
                        //向云端服务器表中添加数据(更新群表)
                        AVObject *post1 = [AVObject objectWithClassName:@"Qun"];
                        //                    [post setObject:[AVUser currentUser].username forKey:@"username"];
                        [post1 setObject:[AVUser currentUser].username forKey:@"admin"];
                        [post1 setObject:text.text forKey:@"qunname"];
                        self.qunName = text.text;
                        [post1 setObject:[NSNumber numberWithInt:1] forKey:@"numberofqun"]; //初始值为 1,用计数器来存储当前群组的成员人数
                        [post1 addObjectsFromArray:[NSArray arrayWithObjects:[AVUser currentUser].username, nil] forKey:@"member"];//用数组来存储群成员
                        [post1 save];        //刷新数据
                        
                        
                        
                        
                        NSMutableArray *array = [NSMutableArray new];
                        [array addObject:[AVUser currentUser].username];
                        AVObject *post = [AVObject objectWithClassName:@"Activity"];
                        [post setObject:[AVUser currentUser].username forKey:@"initiator"];
                        [post setObject:array forKey:@"counts"];
                        [post setObject:self.activityTitleTextField.text forKey:@"title"];
                        [post setObject:self.activityTimeTextField.text forKey:@"time"];
                        [post setObject:self.addressTextField.text forKey:@"address"];
                        [post setObject:self.concentView.text forKey:@"concent"];
                        [post setObject:self.qunName forKey:@"qunName"];
                        
                        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (!error) {
                                // post 保存成功
                                UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction*action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }];
                                [alertController addAction:action];
                                [self presentViewController:alertController animated:YES completion:nil];
                            } else {
                                NSLog(@"%@",error);
                                // 保存 post 时出错
                                UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"发布失败" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction*action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                [alertController addAction:action];
                                [self presentViewController:alertController animated:YES completion:nil];
                            }
                        }];
                        
                        
                        
                        
                        
                        //在本地数据库中建立群聊天记录表
                        NSString*DocumentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                        NSString*dataBasePath=[DocumentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
                        DataBaseTool*db=[DataBaseTool shareDataBase];
                        //连接数据库
                        [db connectDB:dataBasePath];
                        //建表
                        [db execDDLSql:[NSString stringWithFormat:@"create table if not exists %@_qun_%@(\
                                        name text not null,\
                                        content text not null,\
                                        time text not null\
                                        )",[AVUser currentUser].username,text.text]];
                        [db disconnectDB];
                        NSLog(@"%@",dataBasePath);
                        //[self loadDataOfGroup];
                    }
                } else {
                    NSLog(@"%@",error);
                }
            }];
            
        }];
        UIAlertAction*no=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [setQun addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请输群id";
            textField.tag=107;
        }];
        [setQun addAction:no];
        [setQun addAction:ok];
        [self presentViewController:setQun animated:YES completion:nil];
        
        
        
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
