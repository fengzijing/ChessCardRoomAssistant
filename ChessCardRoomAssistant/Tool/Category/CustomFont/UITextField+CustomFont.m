//
//  UITextField+CustomFont.m
//  Pods
//
//  Created by yky on 2017/11/17.
//

#import "UITextField+CustomFont.h"
#import <objc/runtime.h>
#import "SMPageStyle.h"
@implementation UITextField (CustomFont)
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
        
        
        //获得viewController的生命周期方法的selector
        SEL systemSel2 = @selector(didMoveToWindow);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel2 = @selector(myDidMoveToWindow);
        //两个方法的Method
        Method systemMethod2 = class_getInstanceMethod([self class], systemSel2);
        Method swizzMethod2 = class_getInstanceMethod([self class], swizzSel2);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd2 = class_addMethod(self, systemSel2, method_getImplementation(swizzMethod2), method_getTypeEncoding(swizzMethod2));
        if (isAdd2) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel2, method_getImplementation(systemMethod2), method_getTypeEncoding(systemMethod2));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod2, swizzMethod2);
        }
    });
}

- (void)myWillMoveToSuperview:(UIView *)newSuperview
{
    
    [self myWillMoveToSuperview:newSuperview];
    if (self) {
        //修改全局占位符的颜色
        [self setValue:SMPlaceHolder forKeyPath:@"_placeholderLabel.textColor"];
        
        //全局字体配置
        if ([UIFont fontNamesForFamilyName:SMGlobalFontName]){
            self.font  = [UIFont fontWithName:SMGlobalFontName size:self.font.pointSize];
        }
    }
}

- (void)myDidMoveToWindow
{
    [self myDidMoveToWindow];
    //ios 11，UITextField内存泄漏修改
    if (@available(iOS 11, *)) {
        NSString *keyPath = @"textContentView.provider";
        @try {
            if (self.window) {
                id provider = [self valueForKeyPath:keyPath];
                
                if (!provider && self) {
                    [self setValue:self forKeyPath:keyPath];
                }
                
            } else {
                
                [self setValue:nil forKeyPath:keyPath];
                
            }
            
        } @catch (NSException *exception) {
            
            NSLog(@"%@", exception);
            
        }
    }
}

#pragma mark - getter & setter
-(NSInteger)FontSize
{
    return self.font.pointSize;
}
-(void)setFontSize:(NSInteger)FontSize
{
    switch (FontSize) {
        case 30:
            self.font = [UIFont fontWithName:SMGlobalFontName size:30];
            break;
        case 24:
            self.font = [UIFont fontWithName:SMGlobalFontName size:24];
            break;
        case 18:
            self.font = [UIFont fontWithName:SMGlobalFontName size:18];
            break;
        case 15:
            self.font = [UIFont fontWithName:SMGlobalFontName size:15];
            break;
        case 13:
            self.font = [UIFont fontWithName:SMGlobalFontName size:13];
            break;
        case 12:
            self.font = [UIFont fontWithName:SMGlobalFontName size:12];
            break;
        case 10:
            self.font = [UIFont fontWithName:SMGlobalFontName size:10];
            break;
            
        default:
            break;
    }
}


-(NSInteger)FontColor
{
    return self.FontColor;
}
-(void)setFontColor:(NSInteger)FontColor
{
    switch (FontColor) {
        case 0://正文颜色
            self.textColor = SMMainContent;
            break;
        case 1://说明类型颜色
            self.textColor = SMDeclaratives;
            break;
        case 2://价格，状态颜色
            self.textColor = SMPriceStatus;
            break;
        case 3://输入占位颜色
            self.textColor = SMPlaceHolder;
            break;
        case 4://弹窗交互按钮颜色
            self.textColor = SMConfirmButton;
            break;
        default:self.textColor = SMMainContent;
            break;
    }
}

@end

