//
//  JSUserInfo.m
//  Pods
//
//  Created by yky on 2017/11/21.
//

#import "JSUserInfo.h"
#import "JSLocalStorageKit.h"
//

#define gamesUserNameArray @"passwordUserNameArray"
#define UserNameArray @"userNameArray"
//当前用户的token
#define User_Token @"User_Token"

//公司名称
#define User_nickName @"User_nickName"
//公司名称
#define User_signature @"User_signature"
//头像
#define User_Image @"User_Image"

@interface JSUserInfo()

@end

@implementation JSUserInfo

+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    static JSUserInfo* userInfo = nil;
    dispatch_once(&onceToken, ^{
        userInfo = [super allocWithZone:zone];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStatusChange:) name:@"JSNetworkStatusChangeNotification" object:nil];
//        [userInfo getIPAddressByTB];
    });
    
    return userInfo;
}

+(JSUserInfo*)shareManager
{
    return [[self alloc]init];
}

#pragma mark - save & queue
-(id)getUserDefaultByKey:(NSString*)key
{
    return [JSLocalStorageKit queryForKey:key localStorageType:JSLocalStorageTypeUserDefault];
}

-(void)saveUserDefaultByKey:(NSString*)key result:(id)value
{
    [JSLocalStorageKit save:value forKey:key localStorageType:JSLocalStorageTypeUserDefault];
}

//-(id)getKeyChainByKey:(NSString*)key
//{
//    return [JSLocalStorageKit queryForKey:key localStorageType:JSLocalStorageTypeKeyChain];
//}
//
//-(void)saveKeyChainByKey:(NSString*)key result:(id)value
//{
//    [JSLocalStorageKit save:value forKey:key localStorageType:JSLocalStorageTypeKeyChain];
//}



#pragma mark - getter & setter

-(void)setEventArr:(NSMutableArray<BSEventModel *> *)eventArr
{
    if (eventArr == nil) {
        return;
    }
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:eventArr];
    [userdefaults setObject:data forKey:gamesUserNameArray];
}

-(NSMutableArray<BSEventModel *> *)eventArr
{
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSData * tmp = [userdefaults objectForKey:gamesUserNameArray];
    if (tmp == nil) {
        return  [[NSMutableArray alloc]init];
    }
    else {
        return  [NSKeyedUnarchiver unarchiveObjectWithData: tmp];
    }
}


-(void)setUserArr:(NSMutableArray *)userArr{
    if (userArr == nil) {
        return;
    }
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userArr];
    [userdefaults setObject:data forKey:UserNameArray];
}

-(NSMutableArray *)userArr{
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSData * tmp = [userdefaults objectForKey:UserNameArray];
    if (tmp == nil) {
        return  [[NSMutableArray alloc]init];
    } else {
        return  [NSKeyedUnarchiver unarchiveObjectWithData: tmp];
    }
}


-(void)setNickName:(NSString *)nickName{
    [self saveUserDefaultByKey:User_nickName result:nickName];
}

- (NSString *)nickName{
    return [self getUserDefaultByKey:User_nickName];
}

-(void)setSignature:(NSString *)signature{
    [self saveUserDefaultByKey:User_signature result:signature];
}

- (NSString *)signature{
    return [self getUserDefaultByKey:User_signature];
}

-(void)setHeader_image:(UIImage *)header_image{
    [self saveUserDefaultByKey:User_Image result:header_image];
}

- (UIImage *)header_image{
    return [self getUserDefaultByKey:User_Image];
}

-(void)setToken:(NSString *)token{
    [self saveUserDefaultByKey:User_Token result:token];
}


- (NSString *)token{
    return [self getUserDefaultByKey:User_Token];
}


@end

