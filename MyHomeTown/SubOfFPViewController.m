//
//  SubOfFPViewController.m
//  MyHomeTown
//
//  Created by 梁辉 on 16/9/17.
//  Copyright © 2016年 梁辉. All rights reserved.
//

#import "SubOfFPViewController.h"
#import "SizePch.pch"

@interface SubOfFPViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation SubOfFPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _famousArray[0];
    [self createTableView];
    // Do any additional setup after loading the view.
}
- (void)createTableView
{
    _mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mytableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mytableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:_famousArray[0]];
    return (WIDTH-20)*(image.size.height/image.size.width) + [self theTextSizeAndwidth:WIDTH - 20 WithContent:_famousArray[1] AndFont:16] + 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *image = [UIImage imageNamed:_famousArray[0]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, (WIDTH-20)*(image.size.height/image.size.width))];
        imageView.image = image;
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,imageView.frame.origin.y + imageView.frame.size.height + 10, WIDTH-20, [self theTextSizeAndwidth:WIDTH - 20 WithContent:_famousArray[1] AndFont:16])];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.text = _famousArray[1];
        textLabel.numberOfLines = 0;
        
        [cell addSubview:textLabel];
        [cell addSubview:imageView];
    }
    return cell;
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_mytableView]) {
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
        _mytableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    }];
}

- (void)scrollDown
{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, -40, WIDTH, 40);
        _mytableView.frame = CGRectMake(0, 20, WIDTH, HEIGHT - 20);
    }];
    
}


//计算文本的长度和高度
- (CGFloat)theTextSizeAndwidth:(CGFloat)width WithContent:(NSString *)content AndFont:(int)Font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:Font]};
    CGSize  size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)  attributes:attribute context:nil].size;
    return size.height;
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
