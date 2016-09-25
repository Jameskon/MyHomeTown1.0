//
//  TestThreeVC.m
//  SGTopScrollMenu
//
//  Created by Sorgle on 16/8/15.
//  Copyright © 2016年 Sorgle. All rights reserved.
//


#import "TestThreeVC.h"
#import "TestThree1.h"
#import "TestThree5.h"
#import "SizePch.pch"

@interface TestThreeVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestThreeVC

- (id)initWithDataStringArray:(NSArray *)dataArray
{
    if (self = [super init]) {
        self.testThreeArray = dataArray;
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
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0 ) {
        return WIDTH*0.45;
    }if (indexPath.row == 1) {
     return    [self getTextCGsize:_testThreeArray[0][1] withFont:15 withWidth:TextLabelWidth].height + 10+WIDTH * 0.2;
    }
    if (indexPath.row == 2) {
        return    [self getTextCGsize:_testThreeArray[1][1] withFont:15 withWidth:TextLabelWidth].height + 10+WIDTH * 0.2;
    }
    if (indexPath.row == 3) {
        return    [self getTextCGsize:_testThreeArray[2][1] withFont:15 withWidth:TextLabelWidth].height + 10+WIDTH * 0.2;
    }
    if (indexPath.row == 4) {
    return HEIGHT/2+HEIGHT/3;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuse = [NSString stringWithFormat:@"reuse%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
        }
        if (indexPath.row == 0) {
            TestThree1 *testThree1 = [TestThree1 createViewFromNib];
            testThree1.frame = CGRectMake(0, 0, WIDTH, WIDTH*0.45);
            [cell addSubview:testThree1];
            cell.backgroundColor = [UIColor lightGrayColor];
        }if ( indexPath.row == 1) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelPading, 10, WIDTH/2, WIDTH * 0.2)];
            label.text = _testThreeArray[0][0];
            
            UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(TextLabelPading, 10+WIDTH * 0.2, TextLabelWidth, [self getTextCGsize:_testThreeArray[0][1] withFont:15 withWidth:TextLabelWidth].height)];
            textLabel.numberOfLines = 0;
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.text = _testThreeArray[0][1];
            
            [cell addSubview:label];
            [cell addSubview:textLabel];
            
        }
        if ( indexPath.row == 2) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelPading, 10, WIDTH/2, WIDTH * 0.2)];
            label.text = _testThreeArray[1][0];
            
            UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(TextLabelPading, 10+WIDTH * 0.2, TextLabelWidth, [self getTextCGsize:_testThreeArray[1][1] withFont:15 withWidth:TextLabelWidth].height)];
            textLabel.numberOfLines = 0;
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.text = _testThreeArray[1][1];
            
            [cell addSubview:label];
            [cell addSubview:textLabel];
            
        }
        if ( indexPath.row == 3) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelPading, 10, WIDTH/2, WIDTH * 0.2)];
            label.text = _testThreeArray[2][0];
            
            UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(TextLabelPading, 10+WIDTH * 0.2, TextLabelWidth, [self getTextCGsize:_testThreeArray[2][1] withFont:15 withWidth:TextLabelWidth].height)];
            textLabel.numberOfLines = 0;
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.text = _testThreeArray[2][1];
            
            [cell addSubview:label];
            [cell addSubview:textLabel];
            
        }
        if (indexPath.row == 4) {
            TestThree5 *testThree5 = [TestThree5 createViewFromNib];
    testThree5.frame = CGRectMake(0, 0, WIDTH, HEIGHT/2+HEIGHT/3);
            [cell addSubview:testThree5];

        }
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
