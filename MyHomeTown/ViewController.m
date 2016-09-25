//
//  ViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "ViewController.h"
#import "SizePch.pch"

@interface ViewController ()<UIScrollViewDelegate>
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    TabBarViewController *tabbarView = [[TabBarViewController alloc]init];
    [self addChildViewController:tabbarView];
    [self.view addSubview:tabbarView.view];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
