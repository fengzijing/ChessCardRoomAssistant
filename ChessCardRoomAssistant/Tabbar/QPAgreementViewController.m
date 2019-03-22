//
//  TFAgreementViewController.m
//  TFScorecardProject
//
//  Created by 锋子 on 2019/2/22.
//  Copyright © 2019 锋子. All rights reserved.
//

#import "QPAgreementViewController.h"
#import "QPRootTabBarViewController.h"

@interface QPAgreementViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightCons;

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation QPAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Privacy policy";
    self.textView.delegate = self;
    if (self.isMine) {
        self.bottomHeightCons.constant = 0;
    } else {
        self.bottomHeightCons.constant = 50;
    }
    [self.agreeBtn setTitle:@"Agreed" forState:UIControlStateNormal];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}


- (IBAction)agreeDelegateBtn:(UIButton *)sender {
    [JSUserInfo shareManager].token = @"token_key";
    QPRootTabBarViewController* control = [QPRootTabBarViewController shareInstance];
    KEY_WINDOW.rootViewController = control;
    [KEY_WINDOW makeKeyAndVisible];
}




@end
