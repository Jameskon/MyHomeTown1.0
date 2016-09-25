//
//  TabBarViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "TabBarViewController.h"
#import "BriefIntroductionViewController.h"
#import "DelicacyViewController.h"
#import "SeenViewController.h"
#import "FamousPersonViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tabBarItem背景色
    self.tabBar.tintColor = [UIColor colorWithRed:0/255.f green:197/255.f blue:202/255.f alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:13],NSFontAttributeName,nil] forState:UIControlStateNormal];
    //初始化商城ViewController的子类
    BriefIntroductionViewController *briefIntroduction = [[BriefIntroductionViewController alloc]init];
    //设置shop栏的标题
    briefIntroduction.tabBarItem.title=@"简介";
    //设置商城栏的图标
    briefIntroduction.tabBarItem.image=[[UIImage imageNamed:@"BriefIntroduction.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //初始化活动ViewController的子类
    DelicacyViewController *delicacy = [[DelicacyViewController alloc]init];
    //设置active栏的标题
    delicacy.tabBarItem.title=@"特产";
    //设置商城栏的图标
    delicacy.tabBarItem.image=[[UIImage imageNamed:@"Delicacy.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //初始化订单ViewController的子类
    SeenViewController *beautifulScenery = [[SeenViewController alloc]init];
    //设置order栏的标题
    beautifulScenery.tabBarItem.title=@"风景";
    //设置订单栏的图标
    beautifulScenery.tabBarItem.image=[[UIImage imageNamed:@"BeautifulScenery.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //初始化我的ViewController的子类
    FamousPersonViewController *famousPerson = [[FamousPersonViewController alloc]init];
    //设置my栏的标题
    famousPerson.tabBarItem.title=@"名人";
    //设置我的栏的图标
    famousPerson.tabBarItem.image=[[UIImage imageNamed:@"FamousPerson.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置各视图控制器的navigation
    UINavigationController *a = [[UINavigationController alloc]initWithRootViewController:briefIntroduction];
    UINavigationController *b = [[UINavigationController alloc]initWithRootViewController:delicacy];
    UINavigationController *c = [[UINavigationController alloc]initWithRootViewController:beautifulScenery];
    UINavigationController *d=  [[UINavigationController alloc]initWithRootViewController:famousPerson];
    // 快速添加TabBarController
    self.viewControllers = @[a,b,c,d];

    // Do any additional setup after loading the view.
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
