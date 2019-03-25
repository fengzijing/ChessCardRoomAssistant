//
//  QPOrderModel.h
//  ChessCardRoomAssistant
//
//  Created by 锋子 on 2019/3/25.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QPOrderModel : NSObject

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * price;

@property (nonatomic, copy) NSString * note;

- (instancetype)init;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
