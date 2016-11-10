//
//  ForumHistoricoViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 11/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "RNActivityView.h"
#import "ForumModel.h"
#import "ForumService.h"

@interface ForumHistoricoCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIWebView *textWebView;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property(nonatomic)long codigo;

@end

@interface ForumHistoricoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *topicoLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriaSalaLabel;
@property (weak, nonatomic) IBOutlet UILabel *comentarioLabel;
@property (strong, nonatomic) IBOutlet UIWebView *comentarioWebView;

@property (weak, nonatomic) IBOutlet UILabel *nenhumLabel;
@property (weak, nonatomic) IBOutlet UIView *addCommentView;
@property (weak, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (weak, nonatomic) IBOutlet UIButton *addCommentButton;
- (IBAction)adicionarComentario:(UIButton *)sender;

@property (nonatomic, strong) UIView *lastVisibleView;
@property (nonatomic) CGFloat visibleMargin;

@property (strong,nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) NSArray *commentsList;
@property (nonatomic, strong) ForumModel *forum;

@end
