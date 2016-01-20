//
//  ClassificationCollectionViewController.m
//  CityFriend
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 朱延刚. All rights reserved.
//

#import "ClassificationCollectionViewController.h"

@interface ClassificationCollectionViewController ()
@property (nonatomic, retain) NSMutableArray *nameArray;//分类名
@property (nonatomic, retain) NSMutableArray *subArray;//详细分类名
@end

@implementation ClassificationCollectionViewController
//重用标识符
static NSString * const reuseIdentifier = @"Cell";
//增补视图
static NSString *headerReuse = @"headerReuse";
static NSString *footerReuse = @"footerReuse";
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.collectionView.backgroundColor = [UIColor colorWithRed:0.878 green:1.000 blue:0.749 alpha:1.000];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.collectionView registerClass:[ClassificationCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //注册增补视图
    [self.collectionView registerClass:[ClassificationCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuse];
    [self.collectionView registerClass:[ClassificationCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuse];
    //[self xmlAnalysis];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes

    
    // Do any additional setup after loading the view.
}
#pragma mark ----解析XML文件----
//解析XML文件
//-(void)xmlAnalysis{
//    NSLog(@"XML文件DOM解析");
//    //获取文件路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Categories.xml" ofType:nil];
//    //2,将文件读入data中
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    //3,创建GDataXMLNode对象,此时xml文件内所有的节点以树的形式存在GDataXMLDocument
//    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
//    //    GDataXMLElement *rootElement = [xmlDocument rootElement];
//    NSArray *array = [xmlDocument.rootElement elementsForName:@"categories"];
//    self.nameArray = [NSMutableArray array];
//    self.subArray = [NSMutableArray array];
//    for (int i = 0; i < array.count; i++) {
//        GDataXMLElement *element = [[[array objectAtIndex:i] elementsForName:@"category_name"] firstObject];
//        [_nameArray addObject:[element stringValue]];
//        
//        NSMutableArray *arr = [NSMutableArray array];
//        NSArray *subArr = [[array objectAtIndex:i] elementsForName:@"subcategories"];
//        for (GDataXMLElement *xml in subArr) {
//            [arr addObject:[xml stringValue]];
//        }
//        [_subArray addObject:arr];
//    }
//}

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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
return _nameArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = _subArray[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassificationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.LabName.text = _subArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        cell.imgView.image = [UIImage imageNamed:@"Shopping_Cart_512px_1187238_easyicon.net"];
    }else if (indexPath.section == 1){
        cell.imgView.image = [UIImage imageNamed:@"food_rice_256px_564009_easyicon.net"];
    }else if (indexPath.section == 2){
        cell.imgView.image = [UIImage imageNamed:@"Play_Station_3_Joystick_sony_256px_509938_easyicon.net"];
    }else if (indexPath.section == 4){
        cell.imgView.image = [UIImage imageNamed:@"user_woman_512px_1175885_easyicon.net"];
    }else if (indexPath.section == 5){
        cell.imgView.image = [UIImage imageNamed:@"children_128px_1176086_easyicon.net"];
    }else if (indexPath.section == 6){
        cell.imgView.image = [UIImage imageNamed:@"hotel_finder_128px_1113993_easyicon.net"];
    }else if (indexPath.section == 7){
        cell.imgView.image = [UIImage imageNamed:@"preferences_management_service_256px_1174880_easyicon.net"];
    }else{
        cell.imgView.image = [UIImage imageNamed:@"2"];
    }

    
    return cell;
}
//增补视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        ClassificationCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerReuse forIndexPath:indexPath];
        view.label.text = _nameArray[indexPath.section];
        view.backgroundColor = [UIColor greenColor];
        return view;
    }else{
        ClassificationCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerReuse forIndexPath:indexPath];
        return view;
    }
}
//设置每个collectionView的margin(上左下右)
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 10, 20, 10);
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
