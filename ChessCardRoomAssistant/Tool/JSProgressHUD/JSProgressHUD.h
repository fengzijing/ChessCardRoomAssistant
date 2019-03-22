//
//  JSProgressHUD.h
//  Pods
//
//  Created by yky on 2017/11/22.
//

#import <Foundation/Foundation.h>

//内部包一层HUD壳，有时间自定义一个特殊HUD，为了方便到时候统一入口修改
@interface JSProgressHUD : NSObject

+ (void)show;
+ (void)showWithStatus:(NSString*)string;
+ (void)showWithMaskType;


+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;

+ (void)showInfoWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showErrorWithStatus:(NSString*)string;
+ (void)showImage:(UIImage*)image status:(NSString*)string;
@end
