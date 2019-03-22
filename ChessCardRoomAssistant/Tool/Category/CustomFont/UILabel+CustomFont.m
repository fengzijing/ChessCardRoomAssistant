//
//  UILabel+CustomFont.m
//  Pods
//
//  Created by yky on 2017/11/17.
//

#import "UILabel+CustomFont.h"
#import <objc/runtime.h>
#import "SMPageStyle.h"
@implementation UILabel (CustomFont)

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
            self.font  = [UIFont fontWithName:SMGlobalFontName size:self.font.pointSize];
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
    return 0;
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

//=============label复制功能=================
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

//  处理手势相应事件
- (void)handleTap:(UIGestureRecognizer *)g {
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}


//  复制时执行的方法
- (void)copyText:(id)sender {
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self attachTapHandler];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
