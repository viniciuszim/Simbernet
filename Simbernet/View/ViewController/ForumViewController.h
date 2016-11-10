//
//  ForumViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 11/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideNavigationController.h"
#import "ForumService.h"
#import "RNActivityView.h"
#import "ForumModel.h"

@interface ForumCommentsUIButton : UIButton
@property (nonatomic, strong) NSArray *listComments;
@property (nonatomic, strong) ForumModel *forum;
@property (nonatomic, strong) UITableViewCell *cell;
@end

@interface ForumTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *topicoLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoriaSalaLabel;
@property (strong, nonatomic) IBOutlet UILabel *ultimaAtualizacaoLabel;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet ForumCommentsUIButton *commentsButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageNotification;
@property (strong, nonatomic) IBOutlet ForumCommentsUIButton *notificationButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageEmailNotification;
@property (strong, nonatomic) IBOutlet ForumCommentsUIButton *emailNotificationButton;
@end

@interface ForumViewController : BaseViewController<SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate>

@property (strong,nonatomic) IBOutlet UITableView *tableView;

- (IBAction)telaHistoricoForum:(ForumCommentsUIButton *)sender;
- (IBAction)changeNotification:(ForumCommentsUIButton *)sender;
- (IBAction)changeEmailNotification:(ForumCommentsUIButton *)sender;

@end
