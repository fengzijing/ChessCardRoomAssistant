//
//  QPUseViewController.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPUseViewController.h"
#import "QPMenuTableViewCell.h"
#import "QPOrderViewController.h"
#import "QPSettlementViewController.h"

@interface QPUseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QPUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Order" style:UIBarButtonItemStylePlain target:self action:@selector(orderClick)];
}


-(void)orderClick{
    QPOrderViewController * orderVC = [[QPOrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
}


- (IBAction)timeSelectClick:(UIButton *)sender {
    
}

- (IBAction)settlementRoomClick:(UIButton *)sender {
    QPSettlementViewController * orderVC = [[QPSettlementViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma ------UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;//self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QPMenuTableViewCell * cell = [QPMenuTableViewCell cellWithTableView:tableView];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
