//
//  ChatViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView*textView;
@property(nonatomic ,strong)UIView*myView;
@end
@implementation ChatViewController

// 重写父类视图控制器
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    
    return self;
}
-(void)setFriendName:(NSString *)friendName
{
    if (_friendName!=friendName) {
        _friendName=nil;
        _friendName=friendName;
    }
    self.navigationItem.title = self.friendName;
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化myView
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 70)];
    self.myView.backgroundColor = [UIColor grayColor];
    self.myView.center = CGPointMake(kWidth/2, kHeight-84);
    
    // 初始化textView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
    self.textView.center = CGPointMake(kWidth/2, 70/2);
    // 设置代理
    self.textView.delegate = self;
    //
    self.textView.backgroundColor = [UIColor magentaColor];
    //
    self.textView.font = [UIFont systemFontOfSize:23];
    // 设置是否拖动
    self.textView.scrollEnabled = YES;
    // 设置编辑使用的属性(默认是yes,当设置为NO的时候,依然可以拷贝)
    self.textView.editable = YES;
    // 设置textView的边框的属性
    self.textView.layer.cornerRadius = 35;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 5;
    self.textView.layer.borderColor = [UIColor yellowColor].CGColor;
    // 添加到自定义的self.myView上
    [self.myView addSubview:self.textView];
    // 创建Button
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 60);
    rightButton.center = CGPointMake(kWidth-30, 35);
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    // 添加事件
//    [rightButton addTarget:self action:@selector(Action1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView addSubview:rightButton];
    
    
    
    [self.view addSubview:self.myView];
    
    self.view.backgroundColor = [UIColor cyanColor];
    // Do any additional setup after loading the view.
}


// 在开始编辑的时候 textView 和键盘一起弹出
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [UIView beginAnimations:nil context:NULL];
    // 设置动画持续时间(返回时间)
    [UIView setAnimationDuration:0.3];
    // 设置代理
    [UIView setAnimationDelegate:self];
    self.myView.center = CGPointMake(kWidth/2, kHeight-300);
    return YES;
}

// 点击空白的区域回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // 回收键盘的同时textView返回底部
    [self.view endEditing:YES];
    [self keyBoardBack];
}
// 点击右按钮回收键盘
- (void) Cancel:(UIButton *)button
{
    // 回收键盘的同时textView返回底部
    [self.view endEditing:YES];
    [self keyBoardBack];
    
}


// 封装一个textView的位置方法
- (void)keyBoardBack
{
    
    [UIView beginAnimations:nil context:NULL];
    // 设置动画持续时间(返回时间)
    [UIView setAnimationDuration:0.3];
    // 设置代理
    [UIView setAnimationDelegate:self];
    self.myView.center = CGPointMake(kWidth/2, kHeight-84);
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
