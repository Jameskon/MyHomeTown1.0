//
//  LHdeFlowLayout.h
//  自定义瀑布流
//
//  Created by 梁辉 on 16/9/5.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHdeFlowLayout;

/** 默认列数 */
static const NSInteger LHDefaultColumnCount = 2;
/** 默认列间距 */
static const NSInteger LHDefaultColumnMargin = 10;
/** 默认行间距 */
static const NSInteger LHDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets LHDefaultEdgeInsets = { 0, 0, 0, 0};

@protocol LHdeFlowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowlayout:(LHdeFlowLayout *)waterlayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;
@optional
//如果没有设值用默认值
//设置列数
- (CGFloat)columnCountInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout;
//设置列间距
- (CGFloat)columnMarginInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout;
//设置行间距
- (CGFloat)rowMarginInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout;
//设置CollectionView的缩进
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(LHdeFlowLayout *)waterflowLayout;

@end


@interface LHdeFlowLayout : UICollectionViewFlowLayout
/** 代理 */
@property (nonatomic, weak) id<LHdeFlowLayoutDelegate> delegate;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;
//行间距
- (CGFloat)rowMargin;
//列间距
- (CGFloat)columnMargin;
//列数
- (NSInteger)columnCount;
//CollectionView的缩进
- (UIEdgeInsets)edgeInsets;

@end
