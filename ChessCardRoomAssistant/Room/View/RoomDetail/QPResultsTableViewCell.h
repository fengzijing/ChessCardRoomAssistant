//
//  QPResultsTableViewCell.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPResultsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

+ (QPResultsTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
