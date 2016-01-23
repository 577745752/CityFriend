//
//  ChatViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView*textview;
@property(nonatomic ,strong)UIView*myView;

@end

@implementation ChatViewController

//重写视图控制器
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //标题
        self.navigationItem.title=@"好友id";
//        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Cancle:)];
        
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
    self.view.backgroundColor=[UIColor cyanColor];
    
    
    //创建一个View    tabbar下面的高度是49
    _myView=[[UIView alloc]initWithFrame:CGRectMake(0, kHeight-10*kGap-49, kWidth, 10*kGap)];
    _myView.backgroundColor=[UIColor grayColor];
    //初始化textView
    _textview=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, kWidth-5*kGap,10*kGap)];
    _textview.delegate=self;
    //设置拖动
    _textview.scrollEnabled=YES;
    //设置编辑使用属性 (默认是Yes,当设置为NO 时,依然可以进行拷贝)
    self.textview.editable=YES;
    
    self.textview.layer.cornerRadius=kGap;
    self.textview.layer.masksToBounds=YES;
    self.textview.layer.borderWidth=2;
    self.textview.layer.borderColor=[[UIColor yellowColor] CGColor];
    
    [_myView  addSubview:_textview];
    
    
    //创建一个Butoon
    UIButton *rightButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    rightButton.center=CGPointMake(Width-30,70/2);
    rightButton.layer.cornerRadius=60/2;
    rightButton.layer.masksToBounds=YES;
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(action1:) forControlEvents:UIControlEventTouchUpInside];
    [ _myView addSubview: rightButton];
    
    
    //创建一个左边的相机
    UIButton*leftButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    [leftButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    leftButton.center=CGPointMake(30, 70/2);
    [leftButton addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
    [_myView addSubview:leftButton];
    
    
    [self.view addSubview:_myView];
}

//在将要开始编辑的时候,触发方法
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    self.myView.center = CGPointMake(Width/2, Height-300+40);
    //使用动画才会使用
    [UIView commitAnimations];
    
    
    return YES;
}

//导航视图控制器按钮
-(void)Cancle:(UIBarButtonItem *)Item{
    [self.view endEditing:YES];
    
    [self keybordBack];
    
}


//右button事件
-(void)action1:(UIButton *)button{
    
    [self.view endEditing:YES];
    
    [self keybordBack];
    
}

//相机
-(void)action2:(UIButton *)button{
    CGFloat red=arc4random()%256/255.0;
    CGFloat green=arc4random()%256/255.0;
    CGFloat blue=arc4random()%256/255.0;
    self.view.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1];
}

//点击空白键盘回收
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    [self keybordBack];
    
}


//封装方法

-(void)keybordBack{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    self.myView.center = CGPointMake(Width/2, Height-35);
    [UIView commitAnimations];
    
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
