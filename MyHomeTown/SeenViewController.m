//
//  SeenViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 2016/9/23.
//  Copyright © 2016年 梁辉. All rights reserved.
//
#define NavigationBarHight 64
#import "SeenViewController.h"
#import "BeautifulSceneryViewController.h"

@interface SeenViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UIImageView *zoomImageView;
    CGFloat ImageHeight;
}

@end

@implementation SeenViewController

#pragma 懒加载
- (NSArray *)seenArray
{
    if (!_seenArray) {
        // 从未初始化
        // 初始化数据
        // File : 全路径
        // NSBundle : 一个NSBundle代表一个文件夹
        // 利用mainBundle就可以访问软件资源包中的任何资源
        NSBundle *bundle = [NSBundle mainBundle];
        //  获得imageData.plist的全路径
        NSString *path = [bundle pathForResource:@"seen" ofType:@"plist"];
        //加载plist文件
        _seenArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _seenArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风景";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置导航颜色  可用
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    //创建一个高20的假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    //设置成深黑
    statusBarView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    // 添加到 navigationBar 上
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    // Attributes 属性
    NSDictionary  *textAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    // 设置导航栏的字体大小  颜色
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    [self CresteTableView];
    // Do any additional setup after loading the view.
}

- (void)CresteTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, HEIGHT - 64)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    UIImage *image = [UIImage imageNamed:@"庐山"];
    ImageHeight = (WIDTH - 20)*(image.size.height/image.size.width);
    tableView.contentInset = UIEdgeInsetsMake(ImageHeight, 0, ImageHeight, 0);
    [self.view addSubview:tableView];
    
    
    zoomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -ImageHeight, WIDTH - 20, ImageHeight)];
    zoomImageView.image = image;
    zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    zoomImageView.autoresizesSubviews = YES;
    [tableView addSubview:zoomImageView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.seenArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 55)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = self.seenArray[indexPath.row][0];
        [cell addSubview:label];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeautifulSceneryViewController *seenVc = [[BeautifulSceneryViewController alloc]init];
    seenVc.hidesBottomBarWhenPushed = YES;
    seenVc.subViewOfseenArray = self.seenArray[indexPath.row];
    [self.navigationController pushViewController:seenVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if (y < -ImageHeight) {
        CGRect frame = zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        zoomImageView.frame = frame;
    }
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
