//
//  TestOneView.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/14.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "TestOneView.h"

@implementation TestOneView

+ (instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

+ (instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
    
}

@end
