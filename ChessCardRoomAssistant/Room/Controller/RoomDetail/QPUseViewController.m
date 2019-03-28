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
#import "QPOrderModel.h"

@interface QPUseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<QPOrderModel*> * dataArr;

@property (nonatomic,strong) NSTimer * time;

@property (nonatomic, assign) NSInteger time_count;

@property (nonatomic, assign) NSTimeInterval timestamp;

@property (nonatomic, assign) BOOL isSuspended;

@property (nonatomic, assign) NSInteger other_price;

@end

@implementation QPUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.model.title;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.isSuspended = NO;
    self.time_count = 0;
    self.other_price = 0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Order" style:UIBarButtonItemStylePlain target:self action:@selector(orderClick)];
    [self observeApplicationActionNotification];
    if (self.isState) {
        self.isSuspended = YES;
        [self.startBtn setImage:[UIImage imageNamed:@"no_click"] forState:UIControlStateNormal];
        self.startBtn.userInteractionEnabled = NO;
        QPRoomModel * roomModel = [self.model.roomArr firstObject];;
        self.timestamp = [NSDate date].timeIntervalSince1970;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate * datestr = [dateFormatter dateFromString:roomModel.start_time];
        NSTimeInterval  startSp = datestr.timeIntervalSince1970;
        
        self.time_count = self.timestamp-startSp;
        self.dataArr = [NSMutableArray arrayWithArray:roomModel.orderArr];
        
        for (QPOrderModel*orderModel in self.dataArr) {
            self.other_price = self.other_price +orderModel.price.integerValue;
        }
        
        self.time = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            self.time_count = self.time_count+1;
            [self getHeaderViewData];
        } repeats:YES];
    }
    
    [self getHeaderViewData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.time = nil;
    [self.time invalidate];
}

-(void)dealloc{
    self.time = nil;
    [self.time invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getHeaderViewData{
    NSString * str = @"0";
   
    if (self.isSuspended) {
        str = [NSString stringWithFormat:@"%ld",(self.time_count * self.model.price.integerValue)/3600];
        
    }
    
    str = [NSString stringWithFormat:@"%ld",self.other_price+str.integerValue];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:32];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, str.length)];
    self.totalLabel.attributedText = attrString;
    self.timeLabel.text = [self fromCountNumber:self.time_count];
}

- (void)observeApplicationActionNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationDidEnterBackground {
    self.timestamp = [NSDate date].timeIntervalSince1970;
}

- (void)applicationDidBecomeActive {
    NSTimeInterval timeInterval = [NSDate date].timeIntervalSince1970-self.timestamp;
    self.time_count = self.time_count+timeInterval;
    [self getHeaderViewData];
}

-(NSString*)fromCountNumber:(NSInteger)count{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",self.time_count/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(self.time_count%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",self.time_count%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}


-(void)orderClick{
    if (self.isSuspended) {
        QPOrderViewController * orderVC = [[QPOrderViewController alloc]init];
        orderVC.itemBlock = ^(QPOrderModel * _Nonnull orderModel) {
            [self.dataArr addObject:orderModel];
            self.other_price = 0;
            for (QPOrderModel*orderModel in self.dataArr) {
                self.other_price = self.other_price +orderModel.price.integerValue;
            }
            [self.tableView reloadData];
            NSMutableArray * array = [JSUserInfo shareManager].eventArr;
            QPRoomModel * roomModel = [self.model.roomArr firstObject];
            roomModel.orderArr = [NSMutableArray arrayWithArray:self.dataArr];
            [array replaceObjectAtIndex:self.index_count withObject:self.model];
            [JSUserInfo shareManager].eventArr = array;
        };
        [self.navigationController pushViewController:orderVC animated:YES];
    }else{
        [JSProgressHUD showInfoWithStatus:@"Please click on start!"];
    }
}


- (IBAction)timeSelectClick:(UIButton *)sender {
    self.isSuspended = YES;
    if (self.time_count==0) {
        NSMutableArray * array = [JSUserInfo shareManager].eventArr;
        self.model.isState = YES;
        QPRoomModel * roomModel = [[QPRoomModel alloc]init];
        roomModel.name = self.model.title;
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        roomModel.start_time = strDate;
        [self.model.roomArr insertObject:roomModel atIndex:0];
        [array replaceObjectAtIndex:self.index_count withObject:self.model];
        [JSUserInfo shareManager].eventArr = array;
    }
    [sender setImage:[UIImage imageNamed:@"no_click"] forState:UIControlStateNormal];
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        self.time_count = self.time_count+1;
        [self getHeaderViewData];
    } repeats:YES];
    sender.userInteractionEnabled = NO;
}

- (IBAction)settlementRoomClick:(UIButton *)sender {
    if (self.time_count==0) {
        [JSProgressHUD showInfoWithStatus:@"Please click on start!"];
    }else{
        self.time = nil;
        [self.time invalidate];
        
        NSMutableArray * array = [JSUserInfo shareManager].eventArr;
        self.model.isState = NO;
        QPRoomModel * roomModel = [self.model.roomArr firstObject];
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        roomModel.end_time = strDate;
        roomModel.time_leng = [self fromCountNumber:self.time_count];
        roomModel.room_price = [NSString stringWithFormat:@"%ld",(self.time_count * self.model.price.integerValue)/3600];
        roomModel.other_price = [NSString stringWithFormat:@"%ld",self.other_price];
        roomModel.total_price = self.totalLabel.text;
        
        self.model.total_price = [NSString stringWithFormat:@"%ld",self.model.total_price.integerValue+roomModel.total_price.integerValue];
        [array replaceObjectAtIndex:self.index_count withObject:self.model];
        [JSUserInfo shareManager].eventArr = array;
        QPSettlementViewController * orderVC = [[QPSettlementViewController alloc]init];
        orderVC.roomModel = roomModel;
        [self.navigationController pushViewController:orderVC animated:YES];
    }
}

#pragma ------UITableViewDelegate,UITableViewDataSource

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
    QPOrderModel * orderModel = self.dataArr[indexPath.section];
    QPMenuTableViewCell * cell = [QPMenuTableViewCell cellWithTableView:tableView];
    cell.menuLabel.text = orderModel.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"+%@",orderModel.price];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(NSMutableArray<QPOrderModel *> *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(BSEventModel *)model{
    if (!_model) {
        _model = [[BSEventModel alloc]init];
    }
    return _model;
}

@end
