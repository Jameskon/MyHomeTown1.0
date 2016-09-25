//
//  TestOneVC.m
//  SGTopScrollMenu
//
//  Created by Sorgle on 16/8/15.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import "TestOneVC.h"
#import "PushTransition.h"

@interface TestOneVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *testOneArray;
@end

@implementation TestOneVC

- (id)initWithDataStringArray:(NSArray *)dataArray
{
    if (self = [super init]) {
        self.testOneArray = dataArray;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self crateTimer];
}
- (void)crateTimer{
    
    
    //实例化计时器
    _rotateTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(imageViewChange) userInfo:nil repeats:YES];
    
    
}

- (void)imageViewChange
{
    //通过改变contentOffset来切换滚动视图的子界面
    float offset_X = _preferrescroll.contentOffset.x;
    //每次切换一个屏幕
    offset_X += WIDTH;
    
    //说明要从最右边的多余视图开始滚动了，最右边的多余视图实际上就是第一个视图。所以偏移量需要更改为第一个视图的偏移量。
    if (offset_X > WIDTH * 5) {
        _preferrescroll.contentOffset = CGPointMake(0, 0);
        
    }
    //说明正在显示的就是最右边的多余视图，最右边的多余视图实际上就是第一个视图。所以pageControl的小白点需要在第一个视图的位置。
    if (offset_X == WIDTH * 5) {
        _pagecontrol.currentPage = 0;
    }else{
        _pagecontrol.currentPage = offset_X / WIDTH;
    }
    
    //得到最终的偏移量
    CGPoint resultPoint = CGPointMake(offset_X, 0);
    //切换视图时带动画效果
    //最右边的多余视图实际上就是第一个视图，现在是要从第一个视图向第二个视图偏移，所以偏移量为一个屏幕宽度
    if (offset_X  > WIDTH * 5) {
        _pagecontrol.currentPage = 1;
        [_preferrescroll setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
    }else{
        [_preferrescroll setContentOffset:resultPoint animated:YES];
    }
    
}


- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
    return HEIGHT/2;
    }if (indexPath.row == 1) {
    CGSize labelTextSize =  [self getTextCGsize:self.testOneArray[0] withFont:15 withWidth:WIDTH];
    return labelTextSize.height;
    }
    return 955;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *reuse = [NSString stringWithFormat:@"reuse%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            _preferrescroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,HEIGHT/2)];
            _preferrescroll.contentSize = CGSizeMake(WIDTH*5, 1);
            _preferrescroll.pagingEnabled = YES;
            _preferrescroll.showsHorizontalScrollIndicator = NO;
            _preferrescroll.delegate = self;
            for (int i = 1; i < 6; i++) {
                UIImage *image = [UIImage imageNamed:_testOneArray[i]];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*(i-1), 0, WIDTH,HEIGHT/2)];
                imageView.tag = i;
                imageView.image = image;
                //imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.userInteractionEnabled = YES;
                // 添加点按手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
                [imageView addGestureRecognizer:tap];
                [_preferrescroll addSubview:imageView];
                
            }
            
            UIImageView *sImageView = [_preferrescroll viewWithTag:1];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 5, 0, WIDTH,HEIGHT/2)];
            imageView.image = sImageView.image;
            imageView.userInteractionEnabled = YES;
            // 添加点按手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
            [imageView addGestureRecognizer:tap];
            [_preferrescroll addSubview:imageView];
            
            _pagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake(0,(_preferrescroll.frame.size.height/5)*4, cell.frame.size.width, 10)];
            _pagecontrol.numberOfPages = 5;
            _pagecontrol.pageIndicatorTintColor = [UIColor blackColor];
            _pagecontrol.currentPageIndicatorTintColor = [UIColor whiteColor];
            [cell addSubview:_preferrescroll];
            [cell addSubview:_pagecontrol];
        }
        if (indexPath.row == 1) {
            UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, [self getTextCGsize:self.testOneArray[0] withFont:15 withWidth:WIDTH].height)];
            textLabel.backgroundColor = [UIColor colorWithRed:139/255.f green:232/255.f blue:226/255.f alpha:1.0];
            textLabel.text = self.testOneArray[0];
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.numberOfLines = 0;
            [cell.contentView addSubview:textLabel];
        }else if (indexPath.row == 2){
            TestOneView *oneView = [TestOneView createViewFromNib];
            oneView.frame = CGRectMake(0, 5, WIDTH, 808);
            [cell addSubview:oneView];
        }
    }
    return cell;
}


- (void)imageViewClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imgView = (UIImageView *)tap.view;
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:imgView.image,@"image", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:kNotificationAction object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
#pragma mark -- 滚动视图的代理方法

//开始拖拽的代理方法，在此方法中暂停定时器。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //setFireDate：设置定时器在什么时间启动
    //[NSDate distantFuture]:将来的某一时刻
    [_rotateTimer setFireDate:[NSDate distantFuture]];
}

//视图静止时（没有人在拖拽），开启定时器，让自动轮播
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //视图静止之后，过1.5秒在开启定时器
    //[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]  返回值为从现在时刻开始 再过1.5秒的时刻
    [_rotateTimer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
    NSInteger i = _preferrescroll.contentOffset.x / self.view.frame.size.width ;
    _pagecontrol.currentPage = i;
}

- (CGSize)getTextCGsize:(NSString *)text withFont:(int)font withWidth:(CGFloat)width
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)  attributes:attribute context:nil].size;
    return size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
