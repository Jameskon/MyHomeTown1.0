//
//  UIView+LHExtension.h
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LHExtension)
@property (nonatomic ,assign) CGFloat LH_x;
@property (nonatomic ,assign) CGFloat LH_y;
@property (nonatomic ,assign) CGFloat LH_width;
@property (nonatomic ,assign) CGFloat LH_height;
@property (nonatomic ,assign) CGFloat LH_centerX;
@property (nonatomic ,assign) CGFloat LH_centerY;

@property (nonatomic ,assign) CGSize LH_size;

@property (nonatomic, assign) CGFloat LH_right;
@property (nonatomic, assign) CGFloat LH_bottom;

+ (instancetype)LH_viewFromXib;
/** 在分类中声明@property， 只会生成方法的声明， 不会生成方法的实现和带有_线成员变量 */

@end
