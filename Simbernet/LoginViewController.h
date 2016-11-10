//
//  LoginViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 02/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SlideNavigationController.h"
#import "RNActivityView.h"

@interface LoginViewController : UIViewController

- (IBAction)logar:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *viewWhite;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLogin;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSenha;
@property (weak, nonatomic) IBOutlet UILabel *labelMensagem;

@property (nonatomic, strong) UIView *lastVisibleView;
@property (nonatomic) CGFloat visibleMargin;

@end
