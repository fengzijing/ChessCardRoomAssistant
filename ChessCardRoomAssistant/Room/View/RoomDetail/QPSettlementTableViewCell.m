//
//  QPSettlementTableViewCell.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPSettlementTableViewCell.h"

@implementation QPSettlementTableViewCell

+ (QPSettlementTableViewCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"QPSettlementTableViewCell";
    QPSettlementTableViewCell *cell=(QPSettlementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle bundleForClass:[NSClassFromString(@"QPSettlementTableViewCell") class]]];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell = (QPSettlementTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
