//
//  QPIncomeTableViewCell.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/25.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPIncomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeftCons;

@property (nonatomic, weak) BSEventModel * model;

@property (nonatomic, weak) QPRoomModel * roomModel;

+ (QPIncomeTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
