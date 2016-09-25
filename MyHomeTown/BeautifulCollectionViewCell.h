//
//  BeautifulCollectionViewCell.h
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/17.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautifulCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *theNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *whereLabel;
@property (strong, nonatomic) IBOutlet UILabel *starsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *whereImageView;

@end
