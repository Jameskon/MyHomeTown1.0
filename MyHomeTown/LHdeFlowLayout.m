//
//  LHdeFlowLayout.m
//  自定义瀑布流
//
//  Created by 梁辉 on 16/9/5.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "LHdeFlowLayout.h"

@implementation LHdeFlowLayout
#pragma mark - 常见数据处理
//如果没有设置数值那么返回默认值
- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    }else {
        return LHDefaultColumnMargin;
    }
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    }else {
        return LHDefaultColumnMargin;
    }
}

- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    }else {
        return LHDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    }else {
        return LHDefaultEdgeInsets;
    }
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
#pragma 懒加载
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
//初始化
- (void)prepareLayout
{
    [super prepareLayout];
    //获取item个数
    NSUInteger itemCounts = [self.collectionView numberOfItemsInSection:0];
    //清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    //清除之前所有布局属性
    [self.attrsArray removeAllObjects];
    
    for (NSInteger index = 0; index < self.columnCount; index++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    //开始创建每一个cell对应发布局属性
    for (NSInteger i = 0; i < itemCounts; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }

    
}
/**
 *  返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //设置布局属性的frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate waterflowlayout:self heightForItemAtIndex:indexPath.row itemWidth:w];
    
    //找出高度最短的那一列
    NSInteger shortColumn = [self findShortestColumn];
    CGFloat minColumnHeight = [self.columnHeights[shortColumn] doubleValue];
    CGFloat x = self.edgeInsets.left + shortColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    //更新最短那列的高度
    self.columnHeights[shortColumn] = @(CGRectGetMaxY(attrs.frame));
    
    //记录内容的高度
    CGFloat columnHeight = [self.columnHeights[shortColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

//设置集合视图contentsize
- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.bounds.size;
    NSUInteger longstIndex = [self findLongestColumn];
    float columnMax = [self.columnHeights[longstIndex] floatValue];
    size.height = columnMax + self.collectionView.frame.size.height/5 + self.collectionView.frame.origin.y + self.edgeInsets.bottom;
    return size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}


- (CGFloat)columnWidth
{
    return ((self.collectionView.bounds.size.width - (self.columnCount - 1) * self.columnMargin - (self.edgeInsets.left + self.edgeInsets.right)) / self.columnCount);
}

#pragma mark ---- public
//找出最短列
- (NSUInteger)findShortestColumn
{
    NSUInteger shortestIndex = 0;
    CGFloat shortestValue = MAXFLOAT;
    
    NSUInteger index = 0;
    for (NSNumber *columnHeight in self.columnHeights) {
        if ([columnHeight floatValue] < shortestValue) {
            shortestValue = [columnHeight floatValue];
            shortestIndex = index;
        }
        index++;
    }
    return shortestIndex;

}

//寻找最长列
- (NSUInteger)findLongestColumn
{
    NSUInteger longestIndex = 0;
    CGFloat longestValue = 0;
    
    NSUInteger index = 0;
    for (NSNumber *columnHeight in self.columnHeights) {
        if ([columnHeight floatValue] > longestValue) {
            longestValue = [columnHeight floatValue];
            longestIndex = index;
        }
        index++;
    }
    return longestIndex;
}


@end
