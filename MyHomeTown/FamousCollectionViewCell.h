//
//  FamousCollectionViewCell.h
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/17.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamousCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *instroduceLabel;

@end
