//
//  FamousPersonViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "FamousPersonViewController.h"
#import "FamousCollectionViewCell.h"
#import "SubOfFPViewController.h"
#import "SizePch.pch"

@interface FamousPersonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSArray *celebrity;
@end

@implementation FamousPersonViewController

- (NSArray *)celebrity
{
    if (!_celebrity) {
        // 利用mainBundle就可以访问软件资源包中的任何资源
        NSBundle *bundle = [NSBundle mainBundle];
        //  获得imageData.plist的全路径
        NSString *path = [bundle pathForResource:@"Famous" ofType:@"plist"];
        //加载plist文件
        _celebrity = [NSArray arrayWithContentsOfFile:path];

    }
    return _celebrity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"名人";
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 设置导航颜色  可用
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    //创建一个高20的假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    //设置成深黑
    statusBarView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    // 添加到 navigationBar 上
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    // Attributes 属性
    NSDictionary  *textAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    // 设置导航栏的字体大小  颜色
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * _layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    // _layout.itemSize = CGSizeMake( 100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 15, WIDTH, HEIGHT) collectionViewLayout:_layout];
    collect.backgroundColor = [UIColor whiteColor];
    //代理设置
    collect.delegate = self;
    collect.dataSource = self;
    //隐藏垂直导航线
    //collect.showsHorizontalScrollIndicator(隐藏水平)
    collect.showsVerticalScrollIndicator = NO;
    //注册item类型 这里使用系统的类型
    [collect registerNib:[UINib nibWithNibName:@"FamousCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"View"];
    [self.view addSubview:collect];
    // Do any additional setup after loading the view from its nib.
}
//设置每行的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return WIDTH/30;
}
//设置每列的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个cell／item 的大小,等同于layout的itemSize属性（可以用indexPath判断哪个item／cell）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH-WIDTH/10,(WIDTH-WIDTH/10)* 0.7);
}
//设置整个组的缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    return UIEdgeInsetsMake(10, WIDTH/20, 10, WIDTH/20);
}
//设置section头视图的参考大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(WIDTH, 20);
}

//设置头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"View" forIndexPath:indexPath];
        for (UIView *subView in reusableView.subviews) {
            if ([subView isMemberOfClass:[UILabel class]]) {
                [subView removeFromSuperview];
            }
        }
    if (kind == UICollectionElementKindSectionHeader) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
        label.font = [UIFont systemFontOfSize:22];
        label.text = self.celebrity[indexPath.section][0];
        label.textColor = [UIColor grayColor];
        label.textAlignment = 1;
        [reusableView addSubview:label];
    }
    return reusableView;
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.celebrity.count;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return 9;
    }
    return 10;
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FamousCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
   cell.nameLabel.text = self.celebrity[indexPath.section][indexPath.row+1][0];
   cell.imageView.image = [UIImage imageNamed:self.celebrity[indexPath.section][indexPath.row + 1][0]];
   cell.instroduceLabel.text = self.celebrity[indexPath.section][indexPath.row + 1][1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubOfFPViewController *svc = [[SubOfFPViewController alloc]init];
    svc.famousArray = self.celebrity[indexPath.section][indexPath.row+1];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
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
