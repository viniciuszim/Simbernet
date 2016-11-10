//
//  IntranetViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 15/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface IntranetViewController : UIViewController <SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerViewNoticia;
@property (weak, nonatomic) IBOutlet UIView *containerViewEvento;
@property (weak, nonatomic) IBOutlet UIView *containerViewAniversariante;
@property (weak, nonatomic) IBOutlet UIView *containerViewDownload;

@end
