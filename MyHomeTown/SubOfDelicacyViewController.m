//
//  SubOfDelicacyViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/16.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "SubOfDelicacyViewController.h"
#import "SizePch.pch"

@interface SubOfDelicacyViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation SubOfDelicacyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_tableView]) {
        static float newy = 0;
        static float oldy = 0;
        newy = scrollView.contentOffset.y ;
        if (newy > oldy) {
            [self scrollDown];
        }else if (newy < oldy){
            [self scrollUp];
        }
    }
}

- (void)scrollUp
{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, 20, WIDTH, 40);
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    }];
}

- (void)scrollDown
{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, -40, WIDTH, 40);
        _tableView.frame = CGRectMake(0, 20, WIDTH, ScreenHeight - 20);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightToimageOfString:_food_thingsArray[0] withWidth:WIDTH]+[self theTextSizeAndwidth:self.view.frame.size.width WithContent:_food_thingsArray[1] AndFont:16]+HEIGHT/5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, [self getHeightToimageOfString:_food_thingsArray[0] withWidth:WIDTH])];
        imageView.image = [UIImage imageNamed:_food_thingsArray[0]];
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,imageView.frame.origin.y + imageView.frame.size.height + 10, WIDTH-20,HEIGHT/5 + [self getHeightToimageOfString:_food_thingsArray[0] withWidth:WIDTH]+[self theTextSizeAndwidth:self.view.frame.size.width WithContent:_food_thingsArray[1] AndFont:16] - (imageView.frame.origin.y + imageView.frame.size.height))];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.text = _food_thingsArray[1];
        textLabel.numberOfLines = 0;
        
        [cell addSubview:textLabel];
        [cell addSubview:imageView];
    }
    return cell;
}
//计算文本的长度和高度
- (CGFloat)theTextSizeAndwidth:(CGFloat)width WithContent:(NSString *)content AndFont:(int)Font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:Font]};
    CGSize  size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)  attributes:attribute context:nil].size;
    return size.height;
}
- (CGFloat)getHeightToimageOfString:(NSString *)imageStr withWidth:(CGFloat)width
{
    UIImage *image = [UIImage imageNamed:imageStr];
    return width * (image.size.height/image.size.width);
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
