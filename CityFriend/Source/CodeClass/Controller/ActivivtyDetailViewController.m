//
//  ActivivtyDetailViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ActivivtyDetailViewController.h"

@interface ActivivtyDetailViewController ()
//聊天 相关属性
@property (nonatomic, strong) AVIMClient *client;

@end

@implementation ActivivtyDetailViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        [self drawView];
        
    }
    return self;
}
//点击加入活动
-(void)shareActivity:(UIBarButtonItem *)item{
    if([AVUser currentUser] == nil){
        [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    }
    else{
    AVQuery *query = [AVQuery queryWithClassName:@"Activity"];
    [query whereKey:@"title" equalTo:self.titleLabel.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *array = [NSMutableArray new];
        array = objects[0][@"counts"];
        if([array containsObject:[AVUser currentUser].username]){
            UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"您已经在活动成员内,不需再次加入!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            NSLog(@"加入失败");
        }
        else{
            [array addObject:[AVUser currentUser].username];
            [_objc setObject:array forKey:@"counts"];
            [_objc save];
            NSLog(@"加入成功");
            UIAlertController*alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"加入成功,赶紧加入群聊进行活动吧!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*action=[UIAlertAction actionWithTitle:@"开心~" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    }
}



-(void)drawView
{
    self.view.backgroundColor=[UIColor colorWithRed:220 / 255.0 green:165 / 255.0 blue:45 / 255.0 alpha:1];
    
    [self.view addSubview:self.titleLabel];
    
    [self.view addSubview:self.initiatorImgView];
    [self.view addSubview:self.initiator_Label];
    [self.view addSubview:self.initiatorLabel];
    
    [self.view addSubview:self.timeImgView];
    [self.view addSubview:self.time_Label];
    [self.view addSubview:self.timeLabel];
    
    [self.view addSubview:self.addressImgView];
    [self.view addSubview:self.address_Label];
    [self.view addSubview:self.addressLabel];
    
    [self.view addSubview:self.chatGroupImgView];
    [self.view addSubview:self.chatGroup_Label];
    [self.view addSubview:self.chatGroupLabel];
    [self.view addSubview:self.GetInToGroupButton];
    
    [self.view addSubview:self.activityContentImgView];
    [self.view addSubview:self.activityContent_Label];
    [self.view addSubview:self.activityContentLabel];
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth / 3 * 2, kGap * 5)];
        _titleLabel.center = CGPointMake(kWidth / 2, 64 + kGap * 3);
        _titleLabel.font = [UIFont systemFontOfSize:20];
        //_titleLabel.backgroundColor = [UIColor grayColor];
    }
    return  _titleLabel;
}
-(UIImageView *)initiatorImgView{
    if(!_initiatorImgView){
        _initiatorImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap * 2, CGRectGetMaxY(self.titleLabel.frame) + kGap * 2, kGap * 5, kGap * 5)];
        _initiatorImgView.image = [UIImage imageNamed:@"initicator"];
        //_initiatorImgView.backgroundColor = [UIColor grayColor];
    }
    return _initiatorImgView;
}
-(UILabel *)initiator_Label{
    if (!_initiator_Label) {
        _initiator_Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.initiatorImgView.frame) + kGap * 2, CGRectGetMaxY(self.titleLabel.frame) + kGap * 2.5, kWidth / 5, kGap * 4)];
        _initiator_Label.text = @"发起人:";
        _initiator_Label.font = [UIFont systemFontOfSize:15];
        //_initiator_Label.backgroundColor = [UIColor grayColor];
    }
    return  _initiator_Label;
}
-(UILabel *)initiatorLabel{
    if (!_initiatorLabel) {
        _initiatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.initiator_Label.frame) + kGap * 2, CGRectGetMaxY(self.titleLabel.frame) + kGap * 2.5, kWidth / 5 , kGap * 4)];
        //_initiatorLabel.backgroundColor = [UIColor grayColor];
    }
    return _initiatorLabel;
}

-(UIImageView *)timeImgView{
    if(!_timeImgView){
        _timeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap * 2, CGRectGetMaxY(self.initiatorImgView.frame) + kGap * 2, kGap * 5, kGap * 5)];
        _timeImgView.image = [UIImage imageNamed:@"time"];
        //_timeImgView.backgroundColor = [UIColor grayColor];
    }
    return _timeImgView;
}
-(UILabel *)time_Label{
    if (!_time_Label) {
        _time_Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeImgView.frame) + kGap * 2, CGRectGetMaxY(self.initiator_Label.frame) + kGap * 3, kWidth / 5, kGap * 4)];
        _time_Label.text = @"时间:";
        _time_Label.font = [UIFont systemFontOfSize:15];
        //_time_Label.backgroundColor = [UIColor grayColor];
    }
    return  _time_Label;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.time_Label.frame) + kGap * 2, CGRectGetMaxY(self.initiatorLabel.frame) + kGap * 3, kWidth / 3 , kGap * 4)];
        //_timeLabel.backgroundColor = [UIColor grayColor];
    }
    return _timeLabel;
}

-(UIImageView *)addressImgView{
    if(!_addressImgView){
        _addressImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap * 2, CGRectGetMaxY(self.timeImgView.frame) + kGap * 2, kGap * 5, kGap * 5)];
        _addressImgView.image = [UIImage imageNamed:@"address"];
        //_addressImgView.backgroundColor = [UIColor grayColor];
    }
    return _addressImgView;
}
-(UILabel *)address_Label{
    if (!_address_Label) {
        _address_Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressImgView.frame) + kGap * 2, CGRectGetMaxY(self.time_Label.frame) + kGap * 3, kWidth / 5, kGap * 4)];
        _address_Label.text = @"地点:";
        _address_Label.font = [UIFont systemFontOfSize:15];
        //_address_Label.backgroundColor = [UIColor grayColor];
    }
    return  _address_Label;
}
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.address_Label.frame) + kGap * 2, CGRectGetMaxY(self.timeLabel.frame) + kGap * 3, kWidth / 3 , kGap * 4)];
        //自适应高度
        _addressLabel.numberOfLines = 0;
        //_addressLabel.backgroundColor = [UIColor grayColor];
    }
    return _addressLabel;
}

-(UIImageView *)chatGroupImgView{
    if(!_chatGroupImgView){
        _chatGroupImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap * 2, CGRectGetMaxY(self.addressImgView.frame) + kGap * 2, kGap * 5, kGap * 5)];
        _chatGroupImgView.image = [UIImage imageNamed:@"chat"];
        //_chatGroupImgView.backgroundColor = [UIColor grayColor];
    }
    return _chatGroupImgView;
}
-(UILabel *)chatGroup_Label{
    if (!_chatGroup_Label) {
        _chatGroup_Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.chatGroupImgView.frame) + kGap * 2, CGRectGetMaxY(self.address_Label.frame) + kGap * 3, kWidth / 4, kGap * 4)];
        _chatGroup_Label.text = @"讨论群:";
        _chatGroup_Label.font = [UIFont systemFontOfSize:15];
        //_chatGroup_Label.backgroundColor = [UIColor grayColor];
    }
    return  _chatGroup_Label;
}
-(UILabel *)chatGroupLabel{
    if (!_chatGroupLabel) {
        _chatGroupLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.chatGroup_Label.frame) + kGap * 2, CGRectGetMaxY(self.addressLabel.frame) + kGap * 3, kWidth / 5 , kGap * 4)];
        _chatGroup_Label.text = @"已参加数:";
        _chatGroup_Label.font = [UIFont systemFontOfSize:15];
        //_chatGroupLabel.backgroundColor = [UIColor grayColor];
    }
    return _chatGroupLabel;
}
-(UIButton *)GetInToGroupButton{
    if (!_GetInToGroupButton) {
        _GetInToGroupButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _GetInToGroupButton.frame = CGRectMake(CGRectGetMaxX(self.chatGroupLabel.frame) + kGap * 2, CGRectGetMaxY(self.addressLabel.frame) + kGap * 2, kGap * 8, kGap * 6);
        //_GetInToGroupButton.backgroundColor = [UIColor grayColor];
        [_GetInToGroupButton setTitle:@"进群" forState:UIControlStateNormal];
        [_GetInToGroupButton addTarget:self action:@selector(GetInToGroupAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GetInToGroupButton;
}

// 添加好友的方法(实际上是用了发送消息的方法)
-(void)SendMessage:(NSString*)message toUserName:(NSString*)username{
    // 首先 创建了一个 client 来发送消息
    self.client = [[AVIMClient alloc] init];
    //用户登陆状态
    AVUser *currentUser = [AVUser currentUser];
    // 用自己的名字作为 ClientId 打开 client
    [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
        // "我" 建立了与 "对方" 的会话
        [self.client createConversationWithName:@"请求" clientIds:@[username] callback:^(AVIMConversation *conversation, NSError *error) {
            // 我 发了一条消息给 对方
            [conversation sendMessage:[AVIMTextMessage messageWithText:message attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"发送成功！");
                }
            }];
        }];
    }];
}

//加入活动聊天群
-(void)GetInToGroupAction:(UIButton *)button{
    if([AVUser currentUser] == nil){
        [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    }
    else{
    //在群表中查询群id是否存在
#warning 需要更改
    AVQuery *query = [AVQuery queryWithClassName:@"Qun"];
    [query whereKey:@"qunname" equalTo:self.objc[@"qunName"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            //首先要知道群主是谁
            NSString*admin=[objects[0] valueForKey:@"admin"];
            //向群主申请加入该群,给群主发送申请信息
            
            // 首先 创建了一个 client 来发送消息
            self.client = [[AVIMClient alloc] init];
            //用户登陆状态
            AVUser *currentUser = [AVUser currentUser];
            // 用自己的名字作为 ClientId 打开 client
            [self.client openWithClientId:currentUser.username callback:^(BOOL succeeded, NSError *error) {
                // "我" 建立了与 "对方" 的会话
                [self.client createConversationWithName:@"请求" clientIds:@[admin] callback:^(AVIMConversation *conversation, NSError *error) {
                    // 我 发了一条消息给 对方
                    [conversation sendMessage:[AVIMTextMessage messageWithText:[NSString stringWithFormat:@"%@/%@/>_<想要入伙>_<",[AVUser currentUser].username,self.objc[@"qunName"]] attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSLog(@"发送成功！");
                        }
                    }];
                }];
            }];
        } else {
            NSLog(@"%@",error);
        }
    }];
    }
}
-(UIImageView *)activityContentImgView{
    if(!_activityContentImgView){
        _activityContentImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kGap * 2, CGRectGetMaxY(self.chatGroupImgView.frame) + kGap * 2, kGap * 5, kGap * 5)];
        _activityContentImgView.image = [UIImage imageNamed:@"activityContent"];
        //_activityContentImgView.backgroundColor = [UIColor grayColor];
    }
    return _activityContentImgView;
}
-(UILabel *)activityContent_Label{
    if (!_activityContent_Label) {
        _activityContent_Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.activityContentImgView.frame) + kGap * 2, CGRectGetMaxY(self.chatGroup_Label.frame) + kGap * 3, kWidth / 4, kGap * 4)];
        _activityContent_Label.text = @"活动内容:";
        _activityContent_Label.font = [UIFont systemFontOfSize:15];
        //_activityContent_Label.backgroundColor = [UIColor grayColor];
    }
    return  _activityContent_Label;
}
-(UILabel *)activityContentLabel{
    if (!_activityContentLabel) {
        _activityContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.activityContentImgView.frame) + kGap * 2 , CGRectGetMaxY(self.activityContent_Label.frame) + kGap , kWidth  - 15 * kGap, kHeight / 3)];
        //自适应高度
        _activityContentLabel.numberOfLines = 0;
        //_activityContentLabel.backgroundColor = [UIColor grayColor];
    }
    return _activityContentLabel;
}

-(void)setObjc:(AVObject *)objc{
    if(_objc != objc){
        _objc = nil;
        _objc = objc;
    }
    self.titleLabel.text = _objc[@"title"];
    self.initiatorLabel.text = _objc[@"initiator"];
    self.timeLabel.text = _objc[@"time"];
    self.addressLabel.text = _objc[@"address"];
    NSMutableArray * arr = [NSMutableArray new];
    arr = _objc[@"counts"];
    self.chatGroupLabel.text = [NSString stringWithFormat:@"%lu 人",(unsigned long)arr.count];
    CGRect a = self.activityContentLabel.frame;
    a.size.height =  [self caculateHeightWith:_objc[@"concent"]];
    self.activityContentLabel.frame = a;
    self.activityContentLabel.text = _objc[@"concent"];
}
-(CGFloat)caculateHeightWith:(NSString *)str{
    return [str boundingRectWithSize:CGSizeMake(kWidth - 17*kGap, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    if (_yesOrNo == NO) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    }
    else{
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"加入活动" style:UIBarButtonItemStylePlain target:self action:@selector(shareActivity:)];
        self.navigationItem.title=@"活动详情";
        _yesOrNo = YES;
    }
    
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
