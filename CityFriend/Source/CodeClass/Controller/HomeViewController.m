//
//  HomeViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)UICollectionViewFlowLayout *flowLayout;
@end
//cell重用标识符
static NSString *const cellReuseID= @"cellReuseID";

//static NSString *const customCellReuseID= @"customCellReuseID";

//增补视图重用标识符
static NSString *const headerReuseID = @"headerReuseID";
static NSString *const footerReuseID = @"footerReuseID";
@implementation HomeViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.navigationItem.title=@"首页";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"1"] selectedImage:[UIImage imageNamed:@"1"]];
       // self.view.backgroundColor=[UIColor redColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //士霁保留
    /*
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, kWidth/2, kHeight/3)];
    imgView.backgroundColor=[UIColor redColor];
    [self.view addSubview:imgView];
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(0,kHeight/3, kWidth/2, kHeight/3)];
    imgView1.backgroundColor=[UIColor greenColor];
    [self.view addSubview:imgView1];
    UIImageView *imgView2=[[UIImageView alloc]initWithFrame:CGRectMake(0,kHeight-kHeight/3, kWidth/2, kHeight/3)];
    imgView2.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:imgView2];
    */
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(kWidth / 3, kHeight / 4);
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    
    
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    //设置区头区尾(增补视图)
    //设置视图的大小
//    self.flowLayout.headerReferenceSize = CGSizeMake(100, 30);
//    self.flowLayout.footerReferenceSize = CGSizeMake(100, 20);
//    //注册增补视图
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseID];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellReuseID];
    //[self.collectionView registerClass:[customCollectionViewCell class] forCellWithReuseIdentifier:customCellReuseID];
    
    [self.view addSubview:self.collectionView];
}
//设置分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
//每一个分区有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    //[cell.imgView sd_setImageWithURL:[self.dataArray objectAtIndex:indexPath.item] placeholderImage:[UIImage imageNamed:@"大头.jpg"]];
        if(indexPath.item  == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            label.text = @"吃";
            [cell.contentView addSubview:label];
        }
        else if(indexPath.item  == 1){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            label.text = @"出游";
            [cell.contentView addSubview:label];
        }
        else if(indexPath.item  == 2){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            label.text = @"喝";
            [cell.contentView addSubview:label];
        }
        else if(indexPath.item  == 3){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            label.text = @"KTV";
            [cell.contentView addSubview:label];
        }
        else if(indexPath.item  == 4){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            label.text = @"开黑";
            [cell.contentView addSubview:label];
        }
        else if(indexPath.item  == 5){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            label.text = @"电影";
            [cell.contentView addSubview:label];
        }
    
    return cell;
}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID forIndexPath:indexPath];
//    header.backgroundColor = [UIColor orangeColor];
//    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseID forIndexPath:indexPath];
//    footer.backgroundColor = [UIColor yellowColor];
//    
//    //根据kind来选择需要返回的视图
//    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
//        return header;
//    }
//    else
//        return footer;
//    
//}
//-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.item % 2 == 1){
//    return CGSizeMake(80, 80);
//    }
//    else
//        return CGSizeMake(40, 40);
//}

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
