//
//  BSMineTableViewCell.h
//  BSBasketballScorecard
//
//  Created by 锋子 on 2019/3/21.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPMineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
//@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


+ (QPMineTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
