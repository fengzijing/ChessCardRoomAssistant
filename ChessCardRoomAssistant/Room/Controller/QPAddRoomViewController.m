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
#import "JSPictureManager.h"

@interface QPAddRoomViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) JSPictureManager * pictureManager;

@property (nonatomic, strong) BSEventModel * model;

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
    
    if (self.model.header_image.length==0) {
        [JSProgressHUD showInfoWithStatus:NSLocalizedString(@"Please select the room picture", nil)];
        return;
    }
    if (self.model.title.length==0) {
        [JSProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter the room name", nil)];
        return;
    }
    if (self.model.price.length==0) {
        [JSProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter the price", nil)];
        return;
    }
    NSMutableArray * array = [JSUserInfo shareManager].eventArr;
    [array addObject:self.model];
    [JSUserInfo shareManager].eventArr = array;
    [self.navigationController popViewControllerAnimated:YES];
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
        if (self.model.header_image.length==0) {
            cell.headerImageView.image = [UIImage imageNamed:@"camera"];
        } else {
            cell.headerImageView.image = [UIImage imageWithData:self.model.header_image];
        }
        return cell;
    } else {
        @weakify(self);
        QPAddRoomTableViewCell * cell = [QPAddRoomTableViewCell cellWithTableView:tableView];
        if (indexPath.section==1) {
            cell.leftLabel.text = @"Room name";
            cell.rightField.placeholder = @"Please enter the room name";
            if (self.model.title.length>0) {
                cell.rightField.text = self.model.title;
            }
            [[cell.rightField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
                @strongify(self);
                self.model.title = x;
            }];
        } else if (indexPath.section==2) {
            cell.leftLabel.text = @"Billing";
            cell.uniLabel.text = @"/ hour";
            cell.rightField.placeholder = @"Please enter the price";
            cell.rightField.keyboardType = UIKeyboardTypeNumberPad;
            if (self.model.price.length>0) {
                cell.rightField.text = self.model.price;
            }
            [[cell.rightField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
                @strongify(self);
                self.model.price = x;
            }];
        } else {
            cell.leftLabel.text = @"Note";
            cell.rightField.placeholder = @"Please enter remarks";
            if (self.model.note.length>0) {
                cell.rightField.text = self.model.note;
            }
            [[cell.rightField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
                @strongify(self);
                self.model.note = x;
            }];
        }
        return cell;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        [self.pictureManager getMultiplePictureInViewController:self count:1 block:^(NSArray *images, NSString *errorStr) {
            NSData *data = UIImageJPEGRepresentation(images[0], 0.1);
            self.model.header_image = data;
            [self.tableView reloadData];
        }];
    }
}


-(BSEventModel *)model{
    if (!_model) {
        _model = [[BSEventModel alloc]init];
    }
    return _model;
}

-(JSPictureManager *)pictureManager{
    if (!_pictureManager) {
        _pictureManager = [[JSPictureManager alloc]init];
    }
    return _pictureManager;
}


@end
