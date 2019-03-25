//
//  QPRoomIncomeViewController.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/25.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPRoomIncomeViewController : UIViewController

@property (nonatomic, copy) NSString * title;

@property (nonatomic, strong) NSMutableArray<QPRoomModel*> * dataArr;


@end

NS_ASSUME_NONNULL_END
