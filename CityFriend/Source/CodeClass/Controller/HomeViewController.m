//
//  HomeViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>//导入框架
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate>
//定位管理类
@property(nonatomic,strong)CLLocationManager*manager;
//编码和反编码
@property(nonatomic,strong)CLGeocoder*geo;
//当前城市
@property(nonatomic,strong)NSString*cityName;
//城市label
@property(nonatomic,strong)UILabel*cityNameLabel;
//collectionView
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)UICollectionViewFlowLayout *flowLayout;
@end

//cell重用标识符
static NSString *const cellReuseID= @"cellReuseID";

@implementation HomeViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.navigationItem.title=@"首页";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"1"] selectedImage:[UIImage imageNamed:@"1"]];
        //左按钮
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"6"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
        left.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem = left;
    }
    return self;
}
-(void)leftClick:(UIBarButtonItem *)sender{
    LocationViewController*locationVC=[LocationViewController new];
    [self.navigationController pushViewController:locationVC animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark---------城市名称Label
    self.cityNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, kWidth, 10*kGap)];
    self.cityNameLabel.backgroundColor=[UIColor purpleColor];
    self.cityNameLabel.textAlignment=NSTextAlignmentCenter;
    self.cityNameLabel.text=@"正在玩命定位中......";
    [self.view addSubview:self.cityNameLabel];
#pragma mark-------------城市定位-------------
    //判断当前设备是否支持定位
    if ([CLLocationManager locationServicesEnabled]==YES) {
        NSLog(@"支持定位");
    }else{
        NSLog(@"不支持定位");
    }
    //实例化定位管理对象
    self.manager=[[CLLocationManager alloc]init];
    self.manager.delegate=self;
    //初始化编码类Geo
    self.geo=[[CLGeocoder alloc]init];
    //向系统和用户申请使用权限
    if ([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse) {//如果当前权限状态是拒绝才申请
        //开始申请
        [self.manager requestWhenInUseAuthorization];
    }
    //多少米定位一次
    self.manager.distanceFilter=10;
    //定位的经度
    self.manager.desiredAccuracy=kCLLocationAccuracyBest;
    //开启定位
    [self.manager startUpdatingLocation];
    
#pragma mark----------collectionView---------------
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(kWidth / 3, kWidth / 3);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+10*kGap, kWidth, kHeight-10*kGap-64) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout.sectionInset = UIEdgeInsetsMake(kWidth/18, kWidth/9, kWidth/18, kWidth/9);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor=[UIColor yellowColor];
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellReuseID];
    
    [self.view addSubview:self.collectionView];
}
-(void)viewWillAppear:(BOOL)animated
{

    
    self.cityName=[ud objectForKey:cityKey];
    NSString*cityName=[NSString stringWithFormat:@"%@市",self.cityName];
    self.cityNameLabel.text=cityName;

}
//设置分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
    
}
//每一个分区有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.layer.cornerRadius=kWidth/6;
    cell.layer.masksToBounds=YES;
    
    
    
    
    if (indexPath.section==0) {
        if(indexPath.item  == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 70, 50)];
            label.text = @"美食";
            [cell.contentView addSubview:label];
        }else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 70, 50)];
            label.text = @"娱乐";
            [cell.contentView addSubview:label];
        }
    }
    if (indexPath.section==1){
        if(indexPath.item  == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 70, 50)];
            label.text = @"妹子专区";
            [cell.contentView addSubview:label];
        }
        else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 70, 50)];
            label.text = @"休闲健身";
            [cell.contentView addSubview:label];
        }
    }
    if (indexPath.section==2){
        if(indexPath.item  == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 70, 50)];
            label.text = @"酒店";
            [cell.contentView addSubview:label];
        }
        else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 70, 50)];
            label.text = @"游玩";
            [cell.contentView addSubview:label];
        }
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ClassifyTableViewController*classifyTVC=[ClassifyTableViewController new];
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            classifyTVC.cityName=self.cityName;
                     
            
            
            
//            CateTableViewController*classifyTC=[CateTableViewController new];
//            classifyTC.classifyURL=kURL_cateClassify;
//            classifyTC.shopURL=kURL_cate;
//            [self.navigationController pushViewController:classifyTC animated:YES];
            
        }else{
            CoffeeTableViewController*coffeeTC=[CoffeeTableViewController new];
            
            [self.navigationController pushViewController:coffeeTC animated:YES];
            
        }
        
        
        
    }

}
#pragma mark-----------定位.代理方法
//定位成功之后返回
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation*location=[locations lastObject];
    //NSLog(@"定位成功");
    [self getCityNameWithCoor:CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)];
    //关闭定位
    [self.manager stopUpdatingLocation];
}
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
}
//反编码,根据经纬度返回城市名称
-(void)getCityNameWithCoor:(CLLocationCoordinate2D)coor
{
    CLLocation*locat=[[CLLocation alloc]initWithLatitude:coor.latitude longitude:coor.longitude];
    [self.geo reverseGeocodeLocation:locat completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"反编码失败:%@",error);
        }
        CLPlacemark*placeMark=[placemarks lastObject];
        NSString*cityName=placeMark.addressDictionary[@"City"];
        self.cityNameLabel.text=cityName;
        self.cityName=[[cityName componentsSeparatedByString:@"市"]firstObject];
        [ud setValue:self.cityName forKey:cityKey];
        NSLog(@"%@",[ud objectForKey:cityKey]);
    }];
}
// Do any additional setup after loading the view.


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
