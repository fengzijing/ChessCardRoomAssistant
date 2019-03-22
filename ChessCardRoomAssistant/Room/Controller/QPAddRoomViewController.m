//
//  QPAddRoomViewController.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPAddRoomViewController.h"
#import "QPAddPhoneTableViewCell.h"
#import "QPAddRoomTableViewCell.h"

@interface QPAddRoomViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QPAddRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.saveBtn.layer.cornerRadius = 25;
    self.saveBtn.layer.masksToBounds = YES;
    self.view.backgroundColor = self.tableView.backgroundColor;
}

- (IBAction)saveRoomClick:(UIButton *)sender {
    
}


#pragma UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return 4;//self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    } else {
        return 60;
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
        QPAddPhoneTableViewCell * cell = [QPAddPhoneTableViewCell cellWithTableView:tableView];
        return cell;
    } else {
        QPAddRoomTableViewCell * cell = [QPAddRoomTableViewCell cellWithTableView:tableView];
        if (indexPath.section==1) {
            cell.leftLabel.text = @"Room name";
            cell.rightField.placeholder = @"Please enter the room name";
            
        } else if (indexPath.section==2) {
            cell.leftLabel.text = @"Billing";
            cell.uniLabel.text = @"/ hour";
            cell.rightField.placeholder = @"Please enter the price";
        } else {
            cell.leftLabel.text = @"Note";
            cell.rightField.placeholder = @"Please enter remarks";
        }
        return cell;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
