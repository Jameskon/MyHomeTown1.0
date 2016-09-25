//
//  TestTwoVC.m
//  SGTopScrollMenu
//
//  Created by Sorgle on 16/8/15.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import "TestTwoVC.h"

@interface TestTwoVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestTwoVC

- (id)initWithDataStringArray:(NSArray *)dataArray
{
    if (self = [super init]) {
        self.testTwoArray = dataArray;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self getTextCGsize:_testTwoArray[0] withFont:15 withWidth:WIDTH].height;
    }
    return [self getTextCGsize:_testTwoArray[1] withFont:15 withWidth:WIDTH].height + WIDTH/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0 && indexPath.section == 0) {
            UILabel *textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, [self getTextCGsize:_testTwoArray[0] withFont:15 withWidth:WIDTH].height)];
            textLabel1.font = [UIFont systemFontOfSize:15];
            textLabel1.numberOfLines = 0;
            textLabel1.text = _testTwoArray[0];
            [cell.contentView addSubview:textLabel1];
            textLabel1.backgroundColor = [UIColor whiteColor];
        }else if (indexPath.row == 0 && indexPath.section == 1)
        {
            UILabel *textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, [self getTextCGsize:_testTwoArray[1] withFont:15 withWidth:WIDTH].height)];
            textLabel2.font = [UIFont systemFontOfSize:15];
            textLabel2.numberOfLines = 0;
            textLabel2.text = _testTwoArray[1];
            [cell.contentView addSubview:textLabel2];
            textLabel2.backgroundColor = [UIColor whiteColor];
        }
    }
    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *titille1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/25)];
        titille1.font = [UIFont systemFontOfSize:27];
        titille1.backgroundColor = [UIColor lightGrayColor];
        titille1.textColor = [UIColor whiteColor];
        titille1.text = @"历史";
        return titille1;
    }
    UILabel *titille2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/25)];
    titille2.textColor = [UIColor whiteColor];
    titille2.backgroundColor = [UIColor lightGrayColor];
    titille2.font = [UIFont systemFontOfSize:27];
    titille2.text = @"行政区划";
    return titille2;
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
