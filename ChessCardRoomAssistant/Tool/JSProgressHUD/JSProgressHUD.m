//
//  JSProgressHUD.m
//  Pods
//
//  Created by yky on 2017/11/22.
//

#import "JSProgressHUD.h"
#import "SVProgressHUD.h"
@implementation JSProgressHUD

+ (void)show
{
    [SVProgressHUD show];
}
+ (void)showWithMaskType
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}
+ (void)showWithStatus:(NSString*)string
{
    [SVProgressHUD showWithStatus:string];
}
+ (void)showInfoWithStatus:(NSString*)string
{
    [SVProgressHUD showInfoWithStatus:string];
}
+ (void)showSuccessWithStatus:(NSString*)string
{
    [SVProgressHUD showSuccessWithStatus:string];
}
+ (void)showErrorWithStatus:(NSString*)string
{
    [SVProgressHUD showErrorWithStatus:string];
}
+ (void)showImage:(UIImage*)image status:(NSString*)string
{
    [SVProgressHUD showImage:image status:string];
}

+ (void)dismiss
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [JSProgressHUD dismissWithDelay:0.5];
    [SVProgressHUD dismiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay
{
    [SVProgressHUD dismissWithDelay:delay];
}


@end
