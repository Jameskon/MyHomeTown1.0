//
//  UIView+LHExtension.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "UIView+LHExtension.h"

@implementation UIView (LHExtension)
- (void)setLH_x:(CGFloat)LH_x{
    CGRect frame = self.frame;
    frame.origin.x = LH_x;
    self.frame = frame;
}

- (void)setLH_y:(CGFloat)LH_y{
    CGRect frame = self.frame;
    frame.origin.y = LH_y;
    self.frame = frame;
}

- (void)setLH_width:(CGFloat)LH_width{
    CGRect frame = self.frame;
    frame.size.width = LH_width;
    self.frame = frame;
}

- (void)setLH_height:(CGFloat)LH_height{
    CGRect frame = self.frame;
    frame.size.height = LH_height;
    self.frame = frame;
}

- (CGFloat)LH_x{
    return self.frame.origin.x;
}

- (CGFloat)LH_y{
    return self.frame.origin.y;
}

- (CGFloat)LH_width{
    return self.frame.size.width;
}

- (CGFloat)LH_height{
    return self.frame.size.height;
}

- (CGFloat)LH_centerX{
    return self.center.x;
}
- (void)setLH_centerX:(CGFloat)LH_centerX{
    CGPoint center = self.center;
    center.x = LH_centerX;
    self.center = center;
}

- (CGFloat)LH_centerY{
    return self.center.y;
}
- (void)setLH_centerY:(CGFloat)LH_centerY{
    CGPoint center = self.center;
    center.y = LH_centerY;
    self.center = center;
}

- (void)setLH_size:(CGSize)LH_size{
    CGRect frame = self.frame;
    frame.size = LH_size;
    self.frame = frame;
}
- (CGSize)LH_size{
    return self.frame.size;
}


- (CGFloat)LH_right{
    //    return self.SG_x + self.SG_width;
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)LH_bottom{
    //    return self.SG_y + self.SG_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setLH_right:(CGFloat)LH_right{
    self.LH_x = LH_right - self.LH_width;
}
- (void)setLH_bottom:(CGFloat)LH_bottom{
    self.LH_y = LH_bottom - self.LH_height;
}

+ (instancetype)LH_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
