//
//  QPOrderViewController.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPOrderViewController.h"
#import "QPAddRoomTableViewCell.h"


@interface QPOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation QPOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Order";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.saveBtn.layer.cornerRadius = 25;
    self.saveBtn.layer.masksToBounds = YES;
    self.view.backgroundColor = self.tableView.backgroundColor;
}

- (IBAction)saveOrderClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;//self.dataArr.count;
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
    
    QPAddRoomTableViewCell * cell = [QPAddRoomTableViewCell cellWithTableView:tableView];
    if (indexPath.section==0) {
        cell.leftLabel.text = @"Goods";
        cell.rightField.placeholder = @"Please enter the name of the product";
        
    } else if (indexPath.section==1) {
        cell.leftLabel.text = @"Price";
        cell.rightField.placeholder = @"Please enter the price";
    } else {
        cell.leftLabel.text = @"Note";
        cell.rightField.placeholder = @"Please enter remarks";
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
