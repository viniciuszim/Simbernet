//
//  EventoViewController.h
//  Simbernet
//
//  Created by Vinicius Miguel on 08/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseViewController.h"
#import "MHGallery.h"
#import "SlideNavigationController.h"
#import "NoticiaService.h"
#import "RNActivityView.h"
#import "EventoModel.h"

@interface EventoCommentsUIButton : UIButton
@property (nonatomic, strong) NSArray *listComments;
@property (nonatomic, strong) EventoModel *evento;
@end

@interface EventoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet EventoCommentsUIButton *commentsButton;
@property (strong, nonatomic) IBOutlet EventoCommentsUIButton *continueReadingButton;
@end

@interface EventoViewController : BaseViewController<SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,MHGalleryDataSource,MHGalleryDelegate>

@property (strong,nonatomic) IBOutlet UITableView *tableView;

- (IBAction)eventoVisualizar:(EventoCommentsUIButton *)sender;
- (IBAction)goListComments:(EventoCommentsUIButton *)sender;

@end
