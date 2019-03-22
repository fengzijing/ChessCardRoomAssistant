//
//  ENClassModel.h
//  EightNineScorecard
//
//  Created by 锋子 on 2019/3/14.
//  Copyright © 2019 锋子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSLocalStorageKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSEventModel : NSObject


@property(copy,nonatomic) NSString * title;

@property(copy,nonatomic) NSString * time;

@property(copy,nonatomic) NSString * venue;

@property(copy,nonatomic) NSString *  home_name;

@property(copy,nonatomic) NSData *  home_logo;

@property(copy,nonatomic) NSData *  guest_logo;

@property(strong,nonatomic) NSString * guest_name;

@property(copy,nonatomic) NSString * home_score;

@property(copy,nonatomic) NSString *  guest_score;

@property(assign,nonatomic) BOOL isStart;

- (instancetype)init;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
