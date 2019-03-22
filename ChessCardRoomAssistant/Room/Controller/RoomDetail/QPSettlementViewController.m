//
//  QPSettlementViewController.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPSettlementViewController.h"
#import "QPResultsTableViewCell.h"
#import "QPSettlementTableViewCell.h"

@interface QPSettlementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end

@implementation QPSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Settlement";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.completeBtn.layer.cornerRadius = 25;
    self.completeBtn.layer.masksToBounds = YES;
    self.view.backgroundColor = self.tableView.backgroundColor;
    self.navigationItem.hidesBackButton = YES;
}



#pragma UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;//self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 200;
    } else {
        return 150;
    }
    
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
    
    if (indexPath.section==0) {
        QPSettlementTableViewCell * cell = [QPSettlementTableViewCell cellWithTableView:tableView];
        return cell;
    } else {
        QPResultsTableViewCell * cell = [QPResultsTableViewCell cellWithTableView:tableView];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
