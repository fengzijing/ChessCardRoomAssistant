//
//  PMPersonViewController.m
//  PMPasswordmemo
//
//  Created by 锋子 on 2019/3/18.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPPersonViewController.h"
#import "QPAddEventTableViewCell.h"
#import "JSPictureManager.h"

@interface QPPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic,strong) UIImage * headerImage;
@property (nonatomic,copy) NSString * nickName;
@property (nonatomic,copy) NSString * signature;
@property (nonatomic, strong) JSPictureManager * pictureManager;

@end

@implementation QPPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Personal information";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.view.backgroundColor = self.tableView.backgroundColor;
    [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius = 25;
    self.saveBtn.layer.masksToBounds = YES;
    self.headerImage = [UIImage imageWithData:[JSUserInfo shareManager].header_image];
    self.nickName = [JSUserInfo shareManager].nickName;
    self.signature = [JSUserInfo shareManager].signature;
    
}

- (IBAction)savePersonClick:(UIButton *)sender {
    if (self.headerImage != nil) {
        NSData *data = UIImageJPEGRepresentation(self.headerImage, 0.1);
        [JSUserInfo shareManager].header_image = data;
    }
    if (self.nickName.length > 0) {
        [JSUserInfo shareManager].nickName = self.nickName;
    }
    if (self.signature.length > 0) {
        [JSUserInfo shareManager].signature = self.signature;
    }
//    [JSProgressHUD showSuccessWithStatus:NSLocalizedString(@"添加信息成功!", nil)];
    [self.navigationController popViewControllerAnimated:YES];
}


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
    QPAddEventTableViewCell * cell = [QPAddEventTableViewCell cellWithTableView:tableView];
    cell.rightField.hidden = NO;
    cell.rightImageView.hidden = YES;
    if (indexPath.section==0) {
        cell.rightImageView.hidden = NO;
        cell.rightHeightCons.constant = 30;
        cell.rightImageView.layer.cornerRadius = 15;
        cell.rightImageView.layer.masksToBounds = YES;
        cell.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.rightField.hidden = YES;
        if (self.headerImage) {
            cell.rightImageView.image = self.headerImage;
        }else{
            cell.rightImageView.image = [UIImage imageNamed:@"camera"];
        }
        cell.leftLabel.text = @"Head portrait";
    } else if (indexPath.section==1) {
        cell.leftLabel.text = @"Nickname";
        cell.rightField.placeholder = @"Please enter nickname";
        if (self.nickName.length>0) {
            cell.rightField.text = self.nickName;
        }
        @weakify(self);
        [[cell.rightField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.nickName = x;
        }];
    } else {
        cell.leftLabel.text = @"Personality signature";
        cell.rightField.placeholder = @"Please enter your signature";
        if (self.signature.length>0) {
            cell.rightField.text = self.signature;
        }
        @weakify(self);
        [[cell.rightField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.signature = x;
        }];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        WS(wSelf);
        [self.pictureManager getMultiplePictureInViewController:self count:1 block:^(NSArray *images, NSString *errorStr) {
            wSelf.headerImage = images[0];
            [wSelf.tableView reloadData];
        }];
    }
}

-(JSPictureManager *)pictureManager{
    if (!_pictureManager) {
        _pictureManager = [[JSPictureManager alloc]init];
    }
    return _pictureManager;
}


@end
