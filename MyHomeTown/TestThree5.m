//
//  TestThree5.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/18.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "TestThree5.h"
#import "SizePch.pch"

@implementation TestThree5

+ (instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib firstObject];
}

+ (instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _whereImageView.userInteractionEnabled = YES;
}

- (IBAction)whereImgeView:(UITapGestureRecognizer *)sender {
    UIImageView *imgView = (UIImageView *)sender.view;
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:imgView.image,@"image", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:kNotificationAction object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
