//
//  PushTransition.h
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/18.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,strong) UIViewController *toVC;
- (instancetype)initWithViewController:(UIViewController *)controller;
@end
