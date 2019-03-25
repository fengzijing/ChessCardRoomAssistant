//
//  QPRoomIncomeViewController.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/25.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPRoomIncomeViewController.h"
#import "QPIncomeTableViewCell.h"
#import "QPIncomeDetailViewController.h"

@interface QPRoomIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QPRoomIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        if (self.dataArr.count==0) {
            [self.tableView showEmptyView];
        } else {
            [self.tableView hideEmptyView];
        }
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
    QPRoomModel * model = self.dataArr[indexPath.section];
    QPIncomeTableViewCell * cell = [QPIncomeTableViewCell cellWithTableView:tableView];
    cell.roomModel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        QPRoomModel * model = self.dataArr[indexPath.section];
        QPIncomeDetailViewController * addPasswordVC = [[QPIncomeDetailViewController alloc]init];
        addPasswordVC.hidesBottomBarWhenPushed = YES;
        addPasswordVC.model = model;
        [self.navigationController pushViewController:addPasswordVC animated:YES];
    
}

@end
