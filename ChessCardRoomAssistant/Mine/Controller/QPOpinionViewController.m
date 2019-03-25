//
//  OpinionViewController.m
//  BoardGamesItems
//
//  Created by 锋子 on 2018/12/10.
//  Copyright © 2018 锋子. All rights reserved.
//

#import "QPOpinionViewController.h"
#import "QPFillContantTableViewCell.h"
#import "AFNetworkReachabilityManager.h"

@interface QPOpinionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,copy) NSString * note;

@property (nonatomic,copy) NSString * email;


@end

@implementation QPOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Feedback";
    self.submitBtn.layer.cornerRadius = 25;
    self.submitBtn.layer.masksToBounds = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = self.tableView.backgroundColor;
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (IBAction)submitClick:(UIButton *)sender {
    if (self.note.length>0&&self.email.length>0) {
        if ([self isReachable]) {
            [JSProgressHUD showSuccessWithStatus:@"Submission successful!"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [JSProgressHUD showInfoWithStatus:@"Unconnected network"];
        }
    } else {
        if (self.note.length == 0) {
            [JSProgressHUD showInfoWithStatus:@"The feedback is not filled in"];
        } else {
            [JSProgressHUD showInfoWithStatus:@"Mailbox not filled"];
        }
        
    }
}


# pragma mark - UITableViewDelegate UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 100;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    QPFillContantTableViewCell* cell = [QPFillContantTableViewCell cellWithTableView:tableView];
    cell.optionLabel.font = [UIFont systemFontOfSize:13];
    cell.textView.font = [UIFont systemFontOfSize:13];
    if (indexPath.section == 0) {
        cell.optionLabel.text = @"Feedback content";
        cell.textView.PlaceHolder = @"Please enter feedback";
//        [cell.textView becomeFirstResponder];
        [[cell.textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.note = x;
        }];
    } else {
        cell.optionLabel.text = @"Email address";
        cell.textView.PlaceHolder = @"Please enter your email address";
        [[cell.textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.email = x;
        }];
    }
    return cell;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
