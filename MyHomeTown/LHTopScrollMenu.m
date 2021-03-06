//
//  LHTopScrollMenu.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/13.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "LHTopScrollMenu.h"
#import "UIView+LHExtension.h"

@implementation LHTopScrollMenu
- (CGFloat)labelMargin;
{
    if ([self.LHTopScrollMenuDelegate respondsToSelector:@selector(LHTopScrollMenuOfLabelMargin:)]) {
        return [self.LHTopScrollMenuDelegate LHTopScrollMenuOfLabelMargin:self];
    }
    return LHlabelMargin;
}
- (CGFloat)indicatorHeight;
{
    if ([self.LHTopScrollMenuDelegate respondsToSelector:@selector(LHTopScrollMenuOfIndicatorHeight:)]) {
        return [self.LHTopScrollMenuDelegate LHTopScrollMenuOfIndicatorHeight:self];
    }
    return  LHindicatorHeight;
}
- (CGFloat)changeRadio;
{
    if ([self.LHTopScrollMenuDelegate respondsToSelector:@selector(LHTopScrollMenuOfChangeRadio:)]) {
        return [self.LHTopScrollMenuDelegate LHTopScrollMenuOfChangeRadio:self];
    }
    return LHradio;
}

- (NSMutableArray *)allTitileLabel
{
    if (!_allTitileLabel) {
        _allTitileLabel = [NSMutableArray array];
    }
    return _allTitileLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //scrollView的背景颜色
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        //隐藏水平导航线
        self.showsHorizontalScrollIndicator = NO;
        //禁止摇摆
        self.bounces = NO;
    }
    return self;
}

+ (instancetype)LHTopScrollMenuWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)setTitileArray:(NSArray *)titileArray{
    _titileArray = titileArray;
    
    /** 创建标题Label */
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.frame.size.height - self.indicatorHeight;
    
    for (NSUInteger i = 0; i < self.titileArray.count; i++) {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.text = self.titileArray[i];
        // 设置高亮文字颜色
        _titleLabel.highlightedTextColor = [UIColor colorWithRed:0/255.f green:197/255.f blue:202/255.f alpha:1.0];
        //设置tag值
        _titleLabel.tag = i;
        //文本居中
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 计算内容的Size
        CGSize labelSize = [self sizeWithText:_titleLabel.text font:LabelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)];
        // 计算内容的宽度
        CGFloat labelW = labelSize.width + 2 * self.labelMargin;
        
        _titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 计算每个label的X值
        labelX = labelX + labelW;
        
        // 添加到titleLabels数组
        [self.allTitileLabel addObject:_titleLabel];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [_titleLabel addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }
        
        [self addSubview:_titleLabel];
    }
    
    // 计算scrollView的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
    
    // 取出第一个子控件
    UILabel *firstLabel = self.subviews.firstObject;
    
    // 添加指示器
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = [UIColor colorWithRed:0/255.f green:197/255.f blue:202/255.f alpha:1.0];
    _indicatorView.LH_height = self.indicatorHeight;
    _indicatorView.LH_y = self.frame.size.height - self.indicatorHeight;
    [self addSubview:_indicatorView];
    
    
    // 立刻根据文字内容计算第一个label的宽度
    _indicatorView.LH_width = firstLabel.LH_width - 2 * self.labelMargin;
    _indicatorView.LH_centerX = firstLabel.LH_centerX;
}

#pragma mark - - - Label的点击事件
- (void)titleClick:(UITapGestureRecognizer *)tap {
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色,设置高亮状态下的颜色， 以及指示器位置
    [self selectLabel:selLabel];
    
    // 2.让选中的标题居中
    [self setupTitleCenter:selLabel];
    
    
    NSInteger index = selLabel.tag;
    if ([self.LHTopScrollMenuDelegate respondsToSelector:@selector(LHTopScrollMenu:didSelectTitleAtIndex:)]) {
        [self.LHTopScrollMenuDelegate LHTopScrollMenu:self didSelectTitleAtIndex:index];
    }
}

/** 选中label标题颜色变成红色以及指示器位置 */
- (void)selectLabel:(UILabel *)label {
    // 取消高亮
    _selectedLabel.highlighted = NO;
    // 取消形变
    _selectedLabel.transform = CGAffineTransformIdentity;
    // 颜色恢复
    _selectedLabel.textColor = [UIColor blackColor];
    
    // 高亮
    label.highlighted = YES;
    // 形变
    label.transform = CGAffineTransformMakeScale(self.changeRadio, self.changeRadio);
    
    _selectedLabel = label;
    
    // 改变指示器位置
    [UIView animateWithDuration:0.20 animations:^{
        self.indicatorView.LH_width = label.LH_width - 2 * self.labelMargin;
        self.indicatorView.LH_centerX = label.LH_centerX;
    }];
}

/** 设置选中的标题居中 */
- (void)setupTitleCenter:(UILabel *)centerLabel {
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - Width * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - Width;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
