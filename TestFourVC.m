//
//  TestFourVC.m
//  SGTopScrollMenu
//
//  Created by Sorgle on 16/8/15.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import "TestFourVC.h"
#import "SizePch.pch"

@interface TestFourVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestFourVC

- (id)initWithDataStringArray:(NSArray *)dataArray
{
    if (self = [super init]) {
        self.testFourArray = dataArray;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
    return [self getTextCGsize:_testFourArray[indexPath.row][1] withFont:15 withWidth:TextLabelWidth].height + 10 + WIDTH * 0.2 + HEIGHT/3;
    }
    return   [self getTextCGsize:_testFourArray[indexPath.row][1] withFont:15 withWidth:TextLabelWidth].height + 10+WIDTH * 0.2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuse = [NSString stringWithFormat:@"reuse%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelPading, 10, WIDTH/2, WIDTH * 0.2)];
        label.text = _testFourArray[indexPath.row][0];
        
        UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(TextLabelPading, 10+WIDTH * 0.2, TextLabelWidth, [self getTextCGsize:_testFourArray[indexPath.row][1] withFont:15 withWidth:TextLabelWidth].height)];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.text = _testFourArray[indexPath.row][1];
        
        [cell addSubview:label];
        [cell addSubview:textLabel];
        }
    return cell;
    
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
