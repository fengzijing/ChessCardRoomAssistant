//
//  QPAddRoomTableViewCell.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPAddRoomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *rightField;
@property (weak, nonatomic) IBOutlet UILabel *uniLabel;


+ (QPAddRoomTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
