//
//  ENClassModel.h
//  EightNineScorecard
//
//  Created by 锋子 on 2019/3/14.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSLocalStorageKit.h"
@class QPRoomModel;

NS_ASSUME_NONNULL_BEGIN

@interface BSEventModel : NSObject


@property(copy,nonatomic) NSData *  header_image;

@property(copy,nonatomic) NSString * title;

@property(copy,nonatomic) NSString * price;

@property(copy,nonatomic) NSString * note;

@property(copy,nonatomic) NSString *  total_price;

@property (nonatomic, assign) BOOL isState;

@property (nonatomic, strong) NSMutableArray<QPRoomModel*> * roomArr;



@property(assign,nonatomic) BOOL isStart;

- (instancetype)init;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
