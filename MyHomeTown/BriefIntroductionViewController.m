//
//  BriefIntroductionViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "BriefIntroductionViewController.h"
#import "LHTopScrollMenu.h"
#import "TestOneVC.h"
#import "TestTwoVC.h"
#import "TestThreeVC.h"
#import "TestFourVC.h"
#import "TestFiveVC.h"
#import "TestSixVC.h"

@interface BriefIntroductionViewController ()<UIScrollViewDelegate,LHTopScrollMenuDelegate>
@property (nonatomic, strong) LHTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,strong) NSArray *briefIntroductionPlist;
@end

@implementation BriefIntroductionViewController

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}


- (NSArray *)briefIntroductionPlist
{
    if (_briefIntroductionPlist == nil) {
        // 从未初始化
        // 初始化数据
        // File : 全路径
        // NSBundle : 一个NSBundle代表一个文件夹
        // 利用mainBundle就可以访问软件资源包中的任何资源
        NSBundle *bundle = [NSBundle mainBundle];
        
        //  获得imageData.plist的全路径
        NSString *path = [bundle pathForResource:@"briefIntroductionPlist" ofType:@"plist"];
        //加载plist文件
        _briefIntroductionPlist = [NSArray arrayWithContentsOfFile:path];
    }
    return _briefIntroductionPlist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    self.title = @"简介";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isAttach = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1.添加所有子控制器
    [self setupChildViewController];

    self.titles = @[@"简介", @"历史区划", @"地理环境", @"自然资源", @"人口经济", @"社会交通"];
    
    self.topScrollMenu = [LHTopScrollMenu LHTopScrollMenuWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/20)];
    _topScrollMenu.titileArray = [NSArray arrayWithArray:_titles];
    _topScrollMenu.LHTopScrollMenuDelegate = self;
    [self.view addSubview:_topScrollMenu];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, HEIGHT/20, WIDTH, HEIGHT - HEIGHT/20);
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    [self showVc:0];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];

    //接收Push通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:kNotificationAction object:nil];
    // Do any additional setup after loading the view.
}

- (void)notificationAction:(NSNotification *)notification
{
    if (_showView == nil) {
        
    [self showImageOfView];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight/4, WIDTH, ScreenHeight/2)];
    imageView.image = notification.userInfo[@"image"];
    [_showView addSubview:imageView];
    }
}

- (void)showImageOfView
{
    _showView = [[UIView alloc]init];
    _showView.backgroundColor = [UIColor blackColor];
    _showView.userInteractionEnabled = YES;
    // 添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
    [_showView addGestureRecognizer:tap];
    
    [self.view addSubview:_showView];
    [self.view bringSubviewToFront:_showView];
    [UIView animateWithDuration:0.00000001 animations:^{
        _showView.frame = CGRectMake(0, 0, WIDTH, ScreenHeight);
        self.navigationController.navigationBarHidden = YES;
        self.tabBarController.tabBar.hidden = YES;
    }];
}
- (void)viewClick:(UITapGestureRecognizer *)tap
{
    [self hideImageOfView];
}
- (void)hideImageOfView
{
    [UIView animateWithDuration:0.00000001 animations:^{
        _showView.frame = CGRectMake(0, -ScreenHeight, WIDTH, ScreenHeight);
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        
    } completion:^(BOOL finished) {
       [_showView removeFromSuperview];
        _showView = nil;
    }];
    
}


#pragma LHTopScrollMenuDelegate
- (void)LHTopScrollMenu:(LHTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

- (CGFloat)LHTopScrollMenuOfChangeRadio:(LHTopScrollMenu *)topScrollMenu
{
    return 1.0;
}
- (CGFloat)LHTopScrollMenuOfIndicatorHeight:(LHTopScrollMenu *)topScrollMenu
{
    return 3;
}
- (CGFloat)LHTopScrollMenuOfLabelMargin:(LHTopScrollMenu *)topScrollMenu
{
    return 15;
}


// 添加所有子控制器
- (void)setupChildViewController {
    // @"简介"
    TestOneVC *oneVC = [[TestOneVC alloc] initWithDataStringArray:self.briefIntroductionPlist[0]];
    [self addChildViewController:oneVC];
    
    // @"历史"
    TestTwoVC *twoVC = [[TestTwoVC alloc] initWithDataStringArray:self.briefIntroductionPlist[1]];
    [self addChildViewController:twoVC];
    
    // @"行政区划"
    TestThreeVC *threeVC = [[TestThreeVC alloc] initWithDataStringArray:self.briefIntroductionPlist[2]];
    [self addChildViewController:threeVC];
    
    // @"地理环境"
    TestFourVC *fourVC = [[TestFourVC alloc] initWithDataStringArray:self.briefIntroductionPlist[3]];
    [self addChildViewController:fourVC];
    
    // 自然资源
    TestFiveVC *fiveVC = [[TestFiveVC alloc] initWithDataStringArray:self.briefIntroductionPlist[4]];
    [self addChildViewController:fiveVC];
    
    // 人口民族
    TestSixVC *sixVC = [[TestSixVC alloc] init];
    [self addChildViewController:sixVC];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * ScreenWidth;
    
    UIViewController *vc = self.childViewControllers[index];
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, WIDTH, HEIGHT-HEIGHT/20);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:@(index) userInfo:nil];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topScrollMenu.allTitileLabel[index];
    
    [self.topScrollMenu selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self.topScrollMenu setupTitleCenter:selLabel];
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
