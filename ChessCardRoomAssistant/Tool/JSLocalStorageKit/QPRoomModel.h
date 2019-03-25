//
//  QPRoomModel.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/25.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QPRoomModel : NSObject


@property(copy,nonatomic) NSString * start_time;

@property(copy,nonatomic) NSString * end_time;

@property(copy,nonatomic) NSString * name;

@property(copy,nonatomic) NSString * time_leng;

@property(copy,nonatomic) NSString *  total_price;

@property(copy,nonatomic) NSString * room_price;

@property(copy,nonatomic) NSString * other_price;

@property (nonatomic, strong) NSMutableArray<QPOrderModel*> * orderArr;


- (instancetype)init;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
