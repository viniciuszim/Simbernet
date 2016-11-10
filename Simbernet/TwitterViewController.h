//
//  TwitterViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 15/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseService.h"
#import "SlideNavigationController.h"
#import "Tweet2.h"
#import "SESlideTableViewCell.h"

@protocol TwitterViewControllerDelegate <BaseServiceDelegate>

@optional
- (void) inserirResult:(Tweet2*) tweet success:(BOOL)success;
- (void) onCloseButtonPressed;
    
@end

@interface TwitterTableViewCell : SESlideTableViewCell

@property (strong, nonatomic) IBOutlet AsyncImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *lblProfileName;
@property (strong, nonatomic) IBOutlet UILabel *lblHashTag;
@property (strong, nonatomic) IBOutlet UILabel *lblPost;
@property (strong, nonatomic) IBOutlet UIImageView *favoritarImage;
@property (strong, nonatomic) IBOutlet UIButton *btnFavoritar;
@property (strong, nonatomic) IBOutlet UILabel *lblDataPost;

@end

@interface TwitterViewController : BaseViewController <SlideNavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *containerView;

@end
