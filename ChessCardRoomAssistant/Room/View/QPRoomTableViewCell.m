//
//  QPRoomTableViewCell.m
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPRoomTableViewCell.h"

@implementation QPRoomTableViewCell

+ (QPRoomTableViewCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"QPRoomTableViewCell";
    QPRoomTableViewCell *cell=(QPRoomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle bundleForClass:[NSClassFromString(@"QPRoomTableViewCell") class]]];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell = (QPRoomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
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
    self.headerImageView.layer.cornerRadius = 30;
    self.headerImageView.layer.masksToBounds = YES;
}

-(void)setModel:(BSEventModel *)model{
    _model = model;
    self.headerImageView.image = [UIImage imageWithData:model.header_image];
    self.roomLabel.text = model.title;
    self.priceLabel.text = model.price;
    if (model.isState) {
        self.stateLabel.text = @"In use";
        self.stateLabel.textColor = SMColorFromRGB(0xeb5300);
    } else {
        self.stateLabel.text = @"Empty";
        self.stateLabel.textColor = SMColorFromRGB(0x448ADF);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
