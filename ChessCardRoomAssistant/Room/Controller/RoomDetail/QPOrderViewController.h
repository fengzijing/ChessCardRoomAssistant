//
//  QPOrderViewController.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPOrderViewController : UIViewController

typedef void(^MenuBlock)(QPOrderModel * orderModel);

@property (nonatomic, copy) MenuBlock itemBlock;


@end

NS_ASSUME_NONNULL_END
