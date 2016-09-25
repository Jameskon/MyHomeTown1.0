//
//  LHTopScrollMenu.h
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//
#define LabelFontOfSize [UIFont systemFontOfSize:17]
#define Width self.frame.size.width

#import <UIKit/UIKit.h>
@class LHTopScrollMenu;

/** label之间的间距 */
static CGFloat const LHlabelMargin = 15;
/** 指示器的高度 */
static CGFloat const LHindicatorHeight = 3;
/** 形变的度数 */
static CGFloat const LHradio = 1.0;

@protocol  LHTopScrollMenuDelegate<NSObject>
@required
- (void)LHTopScrollMenu:(LHTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index;
@optional
//返回Label的间距
- (CGFloat)LHTopScrollMenuOfLabelMargin:(LHTopScrollMenu *)topScrollMenu;
//返回Label的高度
- (CGFloat)LHTopScrollMenuOfIndicatorHeight:(LHTopScrollMenu *)topScrollMenu;
//返回形变量
- (CGFloat)LHTopScrollMenuOfChangeRadio:(LHTopScrollMenu *)topScrollMenu;
@end


@interface LHTopScrollMenu : UIScrollView
//标题数组
@property (nonatomic,strong) NSArray *titileArray;
//存取Label数组
@property (nonatomic,strong) NSMutableArray *allTitileLabel;
@property (nonatomic, weak) id<LHTopScrollMenuDelegate> LHTopScrollMenuDelegate;

@property (nonatomic, strong) UILabel *titleLabel;
/** 选中时的label */
@property (nonatomic, strong) UILabel *selectedLabel;
/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;


+ (instancetype)LHTopScrollMenuWithFrame:(CGRect)frame;
// 选中label标题的标题颜色改变以及指示器位置变化
- (void)selectLabel:(UILabel *)label;
// 选中的标题居中
- (void)setupTitleCenter:(UILabel *)centerLabel;
- (CGFloat)labelMargin;
- (CGFloat)indicatorHeight;
- (CGFloat)changeRadio;
@end
