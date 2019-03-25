//
//  QPUseViewController.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPUseViewController : UIViewController

@property (nonatomic, assign) BOOL isState;

@property (nonatomic, assign) NSInteger index_count;

@property (nonatomic, strong) BSEventModel * model;

@end



NS_ASSUME_NONNULL_END
