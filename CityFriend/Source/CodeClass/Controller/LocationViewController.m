//
//  LocationViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//collectionView
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *provincesArray;//省份名数组
@property (nonatomic, strong) NSMutableArray *cityArray;//城市名数组
@end

//cell重用标识符
static NSString *const cellReuseID= @"cellReuseID";
//增补视图
static NSString *headerReuse = @"headerReuse";
static NSString *footerReuse = @"footerReuse";
@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //解析
    //路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
    //解析plist文件内容存入数组中
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //取出所有省份名
    self.provincesArray = [NSMutableArray array];
    //取出所有城市名
    self.cityArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSString *str = dic[@"name"];
        [_provincesArray addObject:str];
        //将所有城市名存入数组中
        [_cityArray addObject:dic[@"cities"]];
    }

    
    
    
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(kWidth / 11, 3*kGap);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout.sectionInset = UIEdgeInsetsMake(kWidth/18, kWidth/9, kWidth/18, kWidth/9);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.flowLayout.headerReferenceSize=CGSizeMake(kWidth, 5*kGap);
    
    
    //注册cell
    [self.collectionView registerClass:[LocationCollectionViewCell class] forCellWithReuseIdentifier:cellReuseID];
    //注册增补视图
    [self.collectionView registerClass:[LocationCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuse];
    [self.collectionView registerClass:[LocationCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuse];
    
    [self.view addSubview:self.collectionView];

}
//设置分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _provincesArray.count;
    
}
//每一个分区有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = _cityArray[section];
    return array.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LocationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    cell.labCityName.text = _cityArray[indexPath.section][indexPath.row];
    return cell;
}
//增补视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        LocationCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerReuse forIndexPath:indexPath];
        view.LabProvinces.text = _provincesArray[indexPath.section];
        view.backgroundColor = [UIColor greenColor];
        return view;
    }else{
        LocationCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerReuse forIndexPath:indexPath];
        return view;
    }
}
//cell点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", _cityArray[indexPath.section][indexPath.row]);
    NSString*city=_cityArray[indexPath.section][indexPath.row];
    //NSLog(@"%@",city);
    // NSUserDefaults*userCity=[NSUserDefaults standardUserDefaults];
    [ud setValue:city forKey:cityKey];
    
    [self.navigationController popViewControllerAnimated:YES];
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
