//
//  NoticiaComentarioViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 12/05/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "RNActivityView.h"
#import "Noticia.h"
#import "NoticiaService.h"
#import "EventoModel.h"
#import "EventoService.h"

@interface NoticiaCommentsCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property(nonatomic)long codigo;
@property(nonatomic)NSIndexPath *cellIndexPathPressed;

@end

@interface NoticiaComentarioViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;
@property (weak, nonatomic) IBOutlet UILabel *comentarioLabel;
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
@property (nonatomic, strong) Noticia *noticia;
@property (nonatomic, strong) EventoModel *evento;

@end
