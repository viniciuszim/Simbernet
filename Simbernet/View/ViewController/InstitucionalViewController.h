//
//  InstitucionalViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 17/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface InstitucionalViewController : UIViewController <SlideNavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webInstitucional;
@property (nonatomic, assign) NSString* chave;
@property (nonatomic, assign) NSString* titulo;

@property (nonatomic) BOOL backButton;

@end
