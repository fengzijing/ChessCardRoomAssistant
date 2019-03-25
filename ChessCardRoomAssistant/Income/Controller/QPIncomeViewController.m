//
//  QPIncomeViewController.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPIncomeViewController.h"
#import "QPIncomeTableViewCell.h"
#import "QPRoomIncomeViewController.h"

@interface QPIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<BSEventModel*> * dataArr;

@end

@implementation QPIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Income";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArr = [JSUserInfo shareManager].eventArr;
    [self.tableView reloadData];
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
    BSEventModel * model = self.dataArr[indexPath.section];
    QPIncomeTableViewCell * cell = [QPIncomeTableViewCell cellWithTableView:tableView];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BSEventModel * model = self.dataArr[indexPath.section];
    if (model.roomArr.count==0) {
        [JSProgressHUD showInfoWithStatus:@"The room hasn't started making money yet."];
    } else {
        QPRoomIncomeViewController * addPasswordVC = [[QPRoomIncomeViewController alloc]init];
        addPasswordVC.hidesBottomBarWhenPushed = YES;
        addPasswordVC.title = model.title;
        if (model.isState) {
            [model.roomArr removeFirstObject];
            addPasswordVC.dataArr = model.roomArr;
        } else {
           addPasswordVC.dataArr = model.roomArr;
        }
        [self.navigationController pushViewController:addPasswordVC animated:YES];
    }
}




@end
