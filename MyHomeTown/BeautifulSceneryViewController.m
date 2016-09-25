//
//  BeautifulSceneryViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "BeautifulSceneryViewController.h"
#import "BeautifulCollectionViewCell.h"
#import "SubOfBsVsViewController.h"

@interface BeautifulSceneryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation BeautifulSceneryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = _subViewOfseenArray[0];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建一个layout布局类
    UICollectionViewFlowLayout * _layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    // _layout.itemSize = CGSizeMake( 100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:_layout];
    collect.backgroundColor = [UIColor whiteColor];
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    //隐藏垂直导航线
    //collect.showsHorizontalScrollIndicator(隐藏水平)
    collect.showsVerticalScrollIndicator = NO;
    //注册item类型 这里使用系统的类型
    [collect registerNib:[UINib nibWithNibName:@"BeautifulCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
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
    return CGSizeMake(WIDTH-WIDTH/10,(WIDTH-WIDTH/10)/2);
}
//设置整个组的缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    return UIEdgeInsetsMake(10, WIDTH/20, WIDTH/30, 10);
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _subViewOfseenArray.count - 1;
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   BeautifulCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    for (UIView *subView in cell.subviews) {
        if ([subView isMemberOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    cell.theNameLabel.text = _subViewOfseenArray[indexPath.row + 1][0];
    cell.whereImageView.image = [UIImage imageNamed:_subViewOfseenArray[indexPath.row + 1][0]];
    cell.whereLabel.text = _subViewOfseenArray[indexPath.row + 1][1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubOfBsVsViewController *svc = [[SubOfBsVsViewController alloc]init];
    svc.seenArray = _subViewOfseenArray[indexPath.row + 1];
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
