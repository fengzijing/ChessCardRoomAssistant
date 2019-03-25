//
//  JSUserInfo.h
//  Pods
//
//  Created by yky on 2017/11/21.
//

#import <Foundation/Foundation.h>
#import "JSLocalStorageKit.h"
#import <UIKit/UIKit.h>

@class BSEventModel;

@interface JSUserInfo : NSObject


+(JSUserInfo *)shareManager;

/**

 */
@property (strong, nonatomic) NSMutableArray <BSEventModel *> * eventArr;


/**
 *  token
 */
@property (copy, nonatomic) NSString *token;
/**
 device token
 */
@property (copy,nonatomic) NSString* pushDeviceToken;


/**
 *  昵称
 */
@property (copy, nonatomic) NSString *nickName;

/**
 *  个性签名
 */
@property (copy, nonatomic) NSString *signature;

/**
*  头像
*/
@property (copy , nonatomic) NSData * header_image;


@end

