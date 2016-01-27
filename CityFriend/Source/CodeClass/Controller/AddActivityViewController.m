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
        NSMutableArray *array = [NSMutableArray new];
        [array addObject:[AVUser currentUser].username];
        AVObject *post = [AVObject objectWithClassName:@"Activity"];
        [post setObject:[AVUser currentUser].username forKey:@"initiator"];
        [post setObject:array forKey:@"counts"];
        [post setObject:self.activityTitleTextField.text forKey:@"title"];
        [post setObject:self.activityTimeTextField.text forKey:@"time"];
        [post setObject:self.addressTextField.text forKey:@"address"];
        [post setObject:self.concentView.text forKey:@"concent"];
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
