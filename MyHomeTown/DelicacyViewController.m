//
//  DelicacyViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "DelicacyViewController.h"

#import "LHdeFlowLayout.h"
#import "SubOfDelicacyViewController.h"
#import "PushTransition.h"


@interface DelicacyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LHdeFlowLayoutDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *foodsArray;
@property (nonatomic,strong) NSArray *dishArray;
@end

@implementation DelicacyViewController

- (NSArray *)foodsArray
{
    if (_foodsArray == nil) {
        // 从未初始化
        // 初始化数据
        // File : 全路径
        // NSBundle : 一个NSBundle代表一个文件夹
        // 利用mainBundle就可以访问软件资源包中的任何资源
        NSBundle *bundle = [NSBundle mainBundle];
        
        //  获得imageData.plist的全路径
        NSString *path = [bundle pathForResource:@"food" ofType:@"plist"];
        //加载plist文件
        _foodsArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _foodsArray;
}


- (NSArray *)titleArray
{
    return @[@"十大赣菜",@"特色小吃",@"特产水果",@"茶、酒",@"杂货"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"特产";
    [self CreateTableView];
    [self CreateCollectionView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)CreateTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/4, HEIGHT)];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _indetorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 6, 40)];
    _indetorLabel.backgroundColor = [UIColor colorWithRed:0/255.f green:197/255.f blue:202/255.f alpha:1.0];
    [tableView addSubview:_indetorLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = YES;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0/255.f green:197/255.f blue:202/255.f alpha:1.0];
        if (indexPath.row == 0) {
            [self selectLabel:cell.textLabel];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self selectLabel:cell.textLabel];
    _indetorLabel.frame = CGRectMake(0, 10 + 60 * indexPath.row, 6, 40);
    _dishArray = self.foodsArray[indexPath.row];
    [_collect reloadData];
}

- (void)selectLabel:(UILabel *)label {
    // 取消高亮
    _selectionLabel.highlighted = NO;
    // 颜色恢复
    _selectionLabel.textColor = [UIColor blackColor];
    _selectionLabel = label;
    // 高亮
    label.highlighted = YES;
    
    
    
}

#pragma ColletionView
- (void)CreateCollectionView
{
    _dishArray = self.foodsArray[0];
    //创建一个layout布局类
    LHdeFlowLayout * layout = [[LHdeFlowLayout alloc]init];
    layout.delegate = self;
    //设置每个item的大小为100*100
    // _layout.itemSize = CGSizeMake( 100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(WIDTH/4, 0, (WIDTH/4)*3, HEIGHT ) collectionViewLayout:layout];
    _collect.backgroundColor = [UIColor whiteColor];
    //代理设置
    _collect.delegate=self;
    _collect.dataSource=self;
    //隐藏垂直导航线
    //collect.showsHorizontalScrollIndicator(隐藏水平)
    _collect.showsVerticalScrollIndicator = NO;
    //注册item类型 这里使用系统的类型
    [_collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [_collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"View"];
    [self.view addSubview:_collect];
}


#pragma LHdeFlowLayoutDelegate
- (CGFloat)waterflowlayout:(LHdeFlowLayout *)waterlayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth
{
    UIImage *image = [UIImage imageNamed:_dishArray[index][0]];
    return  itemWidth * image.size.height / image.size.width + HEIGHT/24;
}
- (CGFloat)columnCountInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout
{
    return 2;
}
- (CGFloat)rowMarginInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout
{
    return WIDTH/15;
}
- (CGFloat)columnMarginInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout
{
    return WIDTH/15;
}
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dishArray.count;
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    for (UIView *subView in cell.subviews) {
        if ([subView isMemberOfClass:[UIImageView class]]||[subView isMemberOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    UIImage *image = [UIImage imageNamed:_dishArray[indexPath.row][0]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.width * (image.size.height/image.size.width))];
    imageView.image = image;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, cell.frame.size.width, HEIGHT/24)];
    nameLabel.textAlignment = 1;
    nameLabel.text = self.dishArray[indexPath.row][0];
    
    [cell addSubview:imageView];
    [cell addSubview:nameLabel];
    return cell;
}
//item点击事件(push到详情)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubOfDelicacyViewController *svc = [[SubOfDelicacyViewController alloc]init];
    svc.food_thingsArray = _dishArray[indexPath.row];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}
- (UIViewController *)childViewControllerForStatusBarHidden
{
    SubOfDelicacyViewController *svc = [[SubOfDelicacyViewController alloc]init];
    return svc;
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
