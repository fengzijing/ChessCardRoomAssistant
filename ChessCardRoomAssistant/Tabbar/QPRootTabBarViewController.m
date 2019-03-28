


#import "QPRootTabBarViewController.h"
#import "QPRoomViewController.h"
#import "QPMineViewController.h"
#import "QPIncomeViewController.h"

@interface QPRootTabBarViewController ()<UITabBarControllerDelegate>

@property(strong,nonatomic) QPRoomViewController * passwordViewControl;
@property(strong,nonatomic) QPIncomeViewController * incomeViewControl;
@property(strong,nonatomic) QPMineViewController * mineViewControl;


@end
@implementation QPRootTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = SMColorFromRGB(0x787DB1);
    [self prepareSubViews];
    self.delegate = self;
}
+(instancetype)shareInstance
{
    static QPRootTabBarViewController* rootTabbar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootTabbar = [QPRootTabBarViewController new];
    });
    return rootTabbar;
}
#pragma mark - Delegate & DataSource
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if([item.title isEqualToString:@""]){
    }
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //拦截记账
    if([tabBarController.viewControllers indexOfObject:viewController] == 1){
//        if([self.viewControllers indexOfObject:self.selectedViewController] != 1){
//            BSAddGameViewController * homeViewControl = [BSAddGameViewController new];
//            homeViewControl.hidesBottomBarWhenPushed = YES;
////            homeViewControl.isEditor = NO;
//            [((UINavigationController*)tabBarController.selectedViewController).topViewController presentViewController:[[UINavigationController alloc]initWithRootViewController:homeViewControl] animated:YES completion:nil];
//        }
//        return NO;
    }
    return YES;
}
#pragma mark - 初始化子视图
-(void)prepareSubViews
    {
    [self rootMainSubViews];
}
-(void)rootMainSubViews
{
    UINavigationController* gamesNav = [[UINavigationController alloc]initWithRootViewController:self.passwordViewControl];
    
    UINavigationController* incomeNav = [[UINavigationController alloc]initWithRootViewController:self.incomeViewControl];
    
    UINavigationController* mineNav = [[UINavigationController alloc]initWithRootViewController:self.mineViewControl];
    self.viewControllers = @[gamesNav,incomeNav,mineNav];
}
#pragma mark - getter & setter

-(QPRoomViewController *)passwordViewControl
{
    if(_passwordViewControl==nil){
        _passwordViewControl = [QPRoomViewController new];
        _passwordViewControl.tabBarItem.title = @"Room";
        _passwordViewControl.tabBarItem.selectedImage = [[UIImage imageNamed:@"room_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _passwordViewControl.tabBarItem.image = [[UIImage imageNamed:@"room_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _passwordViewControl;
}

-(QPIncomeViewController *)incomeViewControl{
    if(_incomeViewControl==nil){
        _incomeViewControl = [QPIncomeViewController new];
        _incomeViewControl.tabBarItem.title = @"Income";
        _incomeViewControl.tabBarItem.selectedImage = [[UIImage imageNamed:@"income_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _incomeViewControl.tabBarItem.image = [[UIImage imageNamed:@"income_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _incomeViewControl;
}


-(QPMineViewController *)mineViewControl
{
    if(_mineViewControl==nil){
        _mineViewControl = [QPMineViewController new];
        _mineViewControl.tabBarItem.title = @"Mine";
        _mineViewControl.tabBarItem.selectedImage = [[UIImage imageNamed:@"wode_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mineViewControl.tabBarItem.image = [[UIImage imageNamed:@"wode_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _mineViewControl;
}
@end
