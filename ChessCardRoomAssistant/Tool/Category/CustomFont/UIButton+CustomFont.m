//
//  UIButton+CustomFont.m
//  Pods
//
//  Created by yky on 2017/11/17.
//

#import "UIButton+CustomFont.h"
#import <objc/runtime.h>
#import "SMPageStyle.h"

const NSString* GlobleFont = @"isGlobleFont";

@implementation UIButton (CustomFont)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(willMoveToSuperview:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(myWillMoveToSuperview:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)myWillMoveToSuperview:(UIView *)newSuperview
{
    
    [self myWillMoveToSuperview:newSuperview];
    if (self) {
        if ([UIFont fontNamesForFamilyName:SMGlobalFontName]){
            self.titleLabel.font  = [UIFont fontWithName:SMGlobalFontName size:self.titleLabel.font.pointSize];
        }
        
    }
}

#pragma mark - getter & setter
-(NSInteger)FontSize
{
    return self.titleLabel.font.pointSize;
}
-(void)setFontSize:(NSInteger)FontSize
{
    switch (FontSize) {
        case 30:
            self.titleLabel.font = [UIFont fontWithName:SMGlobalFontName size:30];
            break;
        case 24:
            self.titleLabel.font = [UIFont fontWithName:SMGlobalFontName size:24];
            break;
        case 18:
            self.titleLabel.font = [UIFont fontWithName:SMGlobalFontName size:18];
            break;
        case 15:
            self.titleLabel.font = [UIFont fontWithName:SMGlobalFontName size:15];
            break;
        case 13:
            self.titleLabel.font = [UIFont fontWithName:SMGlobalFontName size:13];
            break;
        case 12:
            self.titleLabel.font = [UIFont fontWithName:SMGlobalFontName size:12];
            break;
        case 10:
            self.titleLabel.font = [UIFont fontWithName:SMGlobalFontName size:10];
            break;
            
        default:
            break;
    }
}


-(NSInteger)FontColor
{
    return 0;
}
-(void)setFontColor:(NSInteger)FontColor
{
    switch (FontColor) {
        case 0://正文颜色
            [self setTitleColor:SMMainContent forState:UIControlStateNormal];
            break;
        case 1://说明类型颜色
            [self setTitleColor:SMDeclaratives forState:UIControlStateNormal];
            break;
        case 2://价格，状态颜色
            [self setTitleColor:SMPriceStatus forState:UIControlStateNormal];
            break;
        case 3://输入占位颜色
            [self setTitleColor:SMPlaceHolder forState:UIControlStateNormal];
            break;
        case 4://弹窗交互按钮颜色
            [self setTitleColor:SMConfirmButton forState:UIControlStateNormal];
            break;
        default:[self setTitleColor:SMMainContent forState:UIControlStateNormal];
            break;
    }
}

@end
