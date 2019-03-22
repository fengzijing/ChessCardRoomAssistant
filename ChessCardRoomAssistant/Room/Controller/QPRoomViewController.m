//
//  QPRoomViewController.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPRoomViewController.h"
#import "QPRoomTableViewCell.h"
#import "QPAddRoomViewController.h"
#import "QPUseViewController.h"

@interface QPRoomViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<BSEventModel*> * dataArr;

@end

@implementation QPRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Room";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"tianjia"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addRoomClick)];
}

-(void)addRoomClick{
    QPAddRoomViewController * addRoomVC = [[QPAddRoomViewController alloc]init];
    addRoomVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addRoomVC animated:YES];
}

#pragma UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (self.dataArr.count==0) {
//        [self.tableView showEmptyView];
//    } else {
//        [self.tableView hideEmptyView];
//    }
    return 5;//self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
//    BSEventModel * model = self.dataArr[indexPath.section];
    QPRoomTableViewCell * cell = [QPRoomTableViewCell cellWithTableView:tableView];
//    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BSEventModel * model = self.dataArr[indexPath.section];
    QPUseViewController * addPasswordVC = [[QPUseViewController alloc]init];
    addPasswordVC.hidesBottomBarWhenPushed = YES;
//    addPasswordVC.index_count = indexPath.section;
//    addPasswordVC.model = model;
    [self.navigationController pushViewController:addPasswordVC animated:YES];
    
}


@end
