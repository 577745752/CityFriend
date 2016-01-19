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

@implementation HomeViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.navigationItem.title=@"首页";
        self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"1"] selectedImage:[UIImage imageNamed:@"1"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(kWidth / 3, kWidth / 3);
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout.sectionInset = UIEdgeInsetsMake(kWidth/18, kWidth/9, kWidth/18, kWidth/9);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellReuseID];
    
    [self.view addSubview:self.collectionView];
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
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
            label.text = @"吃";
            [cell.contentView addSubview:label];
        }else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
            label.text = @"咖啡";
            [cell.contentView addSubview:label];
        }
    }
    if (indexPath.section==1){
        if(indexPath.item  == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
            label.text = @"酒吧";
            [cell.contentView addSubview:label];
        }
        else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
            label.text = @"KTV";
            [cell.contentView addSubview:label];
        }
    }
    if (indexPath.section==2){
        if(indexPath.item  == 0){
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
            label.text = @"出游";
            [cell.contentView addSubview:label];
        }
        else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
            label.text = @"电影";
            [cell.contentView addSubview:label];
        }
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            CateTableViewController*classifyTC=[CateTableViewController new];
            classifyTC.classifyURL=kURL_foodClassify;
            classifyTC.shopURL=kURL_foodShop;
            [self.navigationController pushViewController:classifyTC animated:YES];
            
        }else{
            CoffeeTableViewController*coffeeTC=[CoffeeTableViewController new];
            
            [self.navigationController pushViewController:coffeeTC animated:YES];
            
        }
        
        
        
    }

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
