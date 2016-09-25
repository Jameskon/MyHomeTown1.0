//
//  DelicacyViewController.h
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//
#import "SizePch.pch"
#import <UIKit/UIKit.h>

@interface DelicacyViewController : UIViewController
@property (nonatomic,strong) UICollectionView * collect;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UILabel *indetorLabel;
@property (nonatomic,strong) UILabel *selectionLabel;
@end
