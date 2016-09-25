//
//  SubOfDelicacyViewController.h
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/16.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubOfDelicacyViewController : UIViewController
@property (nonatomic,strong) NSArray *food_thingsArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic) BOOL isHidden;
@end
