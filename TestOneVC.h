//
//  TestOneVC.h
//  SGTopScrollMenu
//
//  Created by Sorgle on 16/8/15.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizePch.pch"
#import "TestOneView.h"

@interface TestOneVC : UIViewController
@property (nonatomic,strong) UIPageControl *pagecontrol;
@property (nonatomic,strong) UIScrollView *preferrescroll;
//计时器
@property (nonatomic ,strong) NSTimer *rotateTimer;
- (id)initWithDataStringArray:(NSArray *)dataArray;
@end
