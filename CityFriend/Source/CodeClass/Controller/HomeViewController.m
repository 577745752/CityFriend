//
//  HomeViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>//导入框架
#import "GDataXMLNode.h"
//#import "GDataXMLNode.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate>
//定位地点定位管理类
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
//分类名数组
@property (nonatomic, retain) NSMutableArray *nameArray;
//详细分类名数组
@property (nonatomic, retain) NSMutableArray *subArray;
@end

//重用标识符
static NSString * const reuseIdentifier = @"Cell";
//增补视图
static NSString *headerReuse = @"headerReuse";
//static NSString *footerReuse = @"footerReuse";

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
    self.flowLayout.itemSize = CGSizeMake(12*kGap, 14*kGap);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+10*kGap, kWidth, kHeight-10*kGap-64) collectionViewLayout:self.flowLayout];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(3.5*kGap, 3.5*kGap, 3.5*kGap, 3.5*kGap);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor=[UIColor yellowColor];
    self.flowLayout.headerReferenceSize=CGSizeMake(kWidth, 5*kGap);
    //注册
    [self.collectionView registerClass:[ClassificationCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //注册增补视图
    [self.collectionView registerClass:[ClassificationCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuse];
    [self.view addSubview:self.collectionView];
    [self xmlAnalysis];
    
}
#pragma mark ----解析XML文件----
//解析XML文件
-(void)xmlAnalysis{
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Categories.xml" ofType:nil];
    //2,将文件读入data中
    NSData *data = [NSData dataWithContentsOfFile:path];
    //3,创建GDataXMLNode对象,此时xml文件内所有的节点以树的形式存在GDataXMLDocument
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    //    GDataXMLElement *rootElement = [xmlDocument rootElement];
    NSArray *array = [xmlDocument.rootElement elementsForName:@"categories"];
    self.nameArray = [NSMutableArray array];
    self.subArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        GDataXMLElement *element = [[[array objectAtIndex:i] elementsForName:@"category_name"] firstObject];
        [_nameArray addObject:[element stringValue]];
        
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *subArr = [[array objectAtIndex:i] elementsForName:@"subcategories"];
        for (GDataXMLElement *xml in subArr) {
            [arr addObject:[xml stringValue]];
        }
        [_subArray addObject:arr];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.cityName=[ud objectForKey:cityKey];
    NSString*cityName=[NSString stringWithFormat:@"%@市",self.cityName];
    self.cityNameLabel.text=cityName;
}
//返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _nameArray.count;
}
//返回各分区的行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = _subArray[section];
    return array.count;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassificationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.LabName.text = _subArray[indexPath.section][indexPath.row];
    return cell;
}
//增补视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ClassificationCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerReuse forIndexPath:indexPath];
    view.label.text = _nameArray[indexPath.section];
    view.backgroundColor = [UIColor greenColor];
    return view;
}
//cell点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopTableViewController*shopTC=[ShopTableViewController new];
    shopTC.cityName=self.cityName;
    shopTC.category=_subArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:shopTC animated:YES];
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
