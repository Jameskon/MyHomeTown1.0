//
//  PushTransition.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/18.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "PushTransition.h"
#import "TestOneView.h"

@implementation PushTransition

- (instancetype)initWithViewController:(UIViewController *)controller
{
    if (self = [super init]) {
        self.toVC = controller;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.002f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    _toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    
    _toVC.view.frame = [transitionContext finalFrameForViewController:_toVC];
    _toVC.view.alpha = 0;
    
    [containerView addSubview:_toVC.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.002f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        _toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
       
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
