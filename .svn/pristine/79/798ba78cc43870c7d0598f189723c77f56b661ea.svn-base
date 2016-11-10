//
//  NoticiaViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 04/05/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "NoticiaViewController.h"
#import "MHOverviewController.h"
#import "NoticiaComentarioViewController.h"
#import "UIView+RNActivityView.h"
#import "Utils.h"

@implementation CommentsUIButton
@end

@implementation NoticiaTableViewCell
@end

@interface NoticiaViewController () <NoticiaServiceDelegate> {
    NSMutableArray *noticiaLista;
    NSMutableArray *paginas;
    NSNumber* pagina;
    NSUInteger totalNoticiasAnt;
    BOOL carregou;
    
    UIRefreshControl* refreshControl;
}
@end

@implementation NoticiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Seto pagina 1 a primeira vez que entra na lista
    pagina = [NSNumber numberWithInt:1];
    [paginas addObject:pagina];
    
    // Lista Noticias do Java
    [self launchReload];
    NSLog(@"Pagina: %lu", (unsigned long)pagina.intValue);
    
    // Initialize the refresh control.
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor lightGrayColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(updateNoticias)
             forControlEvents:UIControlEventValueChanged];
    
    refreshControl.attributedTitle = [Noticia getUltimaAtualizacao];
    
    [self.tableView addSubview:refreshControl];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.83 green:0.84 blue:0.86 alpha:1];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Loading
    if (!carregou) {
        [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
    }
}

-(void)updateNoticias {
    
    // Seto pagina 1 para buscar do início com o refresh
    pagina = [NSNumber numberWithInt:1];
    [paginas addObject:pagina];
    
    // Lista eventos do Java
    [self launchReload];
}

-(void)launchReload {
    totalNoticiasAnt = [noticiaLista count];
    NoticiaService* noticiaService = [NoticiaService new];
    noticiaService.delegate = self;
    [noticiaService listNoticias: pagina.intValue];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    if ([self.presentedViewController isKindOfClass:[MHGalleryController class]]) {
        MHGalleryController *gallerController = (MHGalleryController*)self.presentedViewController;
        return gallerController.preferredStatusBarStyleMH;
    }
    return UIStatusBarStyleDefault;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 100;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 435;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"NoticiaTableViewCell";
    
    NoticiaTableViewCell *cell = (NoticiaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    }
    
    if (carregou) {
        cell.backView.hidden = NO;
        cell.collectionView.hidden = NO;
        cell.titleLabel.hidden = NO;
        cell.dataLabel.hidden = NO;
        cell.descriptionLabel.hidden = NO;
        cell.continueReadingButton.hidden = NO;
    }
    
    NSLog(@"Registro %ld", (long)indexPath.section);
    NSLog(@"Tamanho lista: %lu", (unsigned long)[noticiaLista count]);
    if (indexPath.section == [noticiaLista count] - 1)
    {
        int value = [pagina intValue];
        pagina = [NSNumber numberWithInt:value + 1];
        
        NSLog(@"Pagina: %lu", (unsigned long)pagina.intValue);
        [self launchReload];
        [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
    if (indexPath.section >= [noticiaLista count]) {
        cell.hidden = YES;
        return cell;
    }
    
    Noticia *noticia = (Noticia *) [noticiaLista objectAtIndex:indexPath.section];

    cell.titleLabel.text = noticia.titulo;
    NSLog(@"Titulo %@", noticia.titulo);
    NSLog(@"Foto %@", noticia.foto);
    cell.descriptionLabel.text = noticia.resumo;

    // Data da Noticia
    if (![@"(null)" isEqual:noticia.data] && ![(NSString *)[NSNull null] isEqual:noticia.data] && ![@"" isEqual:noticia.data]) {
        cell.dataLabel.text = noticia.data;
    } else {
        cell.dataLabel.text = @"-";
    }
    
    // Altera a largura da label do Titulo
    CGRect rectFrameTitle = CGRectMake(cell.titleLabel.frame.origin.x,
                                  cell.titleLabel.frame.origin.y,
                                  self.view.frame.size.width - 30,
                                  cell.titleLabel.frame.size.height);
    cell.titleLabel.frame = rectFrameTitle;
    // Altera a largura da label Descricao
    CGRect rectFrameDescriptioon = CGRectMake(cell.descriptionLabel.frame.origin.x,
                                       cell.descriptionLabel.frame.origin.y,
                                       self.view.frame.size.width - 30,
                                       cell.descriptionLabel.frame.size.height);
    cell.descriptionLabel.frame = rectFrameDescriptioon;
    
    // Botao Continuar lendo...
    //    cell.continueReadingButton.listComments = sortedArray;
    cell.continueReadingButton.noticia = noticia;
//    [cell.continueReadingButton addTarget:self
//                                   action:@selector(goListComments:)
//                         forControlEvents:UIControlEventTouchUpInside];
    [cell.continueReadingButton setTitle:@"... Continuar lendo"
                                forState:UIControlStateNormal];
    cell.continueReadingButton.backgroundColor = [UIColor whiteColor];
    cell.continueReadingButton.frame = CGRectMake(self.view.frame.size.width - 120,
                                                  cell.descriptionLabel.frame.origin.y + 22,
                                                  110, 15);
    
    // Botao Comentarios
    cell.commentsButton.noticia = noticia;
    if (noticia.totalComentarios != nil && [noticia.totalComentarios isEqualToString:@"1"]) {
        NSString *labelButton = [NSString stringWithFormat:@"%@ %@", noticia.totalComentarios, @"comentário"];
//        [cell.commentsButton addTarget:self
//                                       action:@selector(goListComments:)
//                             forControlEvents:UIControlEventTouchUpInside];
        [cell.commentsButton setTitle:labelButton forState:UIControlStateNormal];
        [cell.commentsButton setHidden:NO];
    } else if (noticia.totalComentarios != nil && ![noticia.totalComentarios isEqualToString:@"0"]) {
        NSString *labelButton = [NSString stringWithFormat:@"%@ %@", noticia.totalComentarios, @"comentários"];
        [cell.commentsButton setTitle:labelButton forState:UIControlStateNormal];
        [cell.commentsButton addTarget:self
                                action:@selector(goListComments:)
                      forControlEvents:UIControlEventTouchUpInside];
        [cell.commentsButton setHidden:NO];
    } else {
        [cell.commentsButton setHidden:YES];
    }
    
    // Altera o tamanho da View, que é onde os dados da celula ficam em cima
    CGRect rectFrame = CGRectMake(cell.backView.frame.origin.x,
                                  cell.backView.frame.origin.y,
                                  self.view.frame.size.width - 20,
                                  428);
    cell.backView.frame = rectFrame;
    
    cell.backView.layer.masksToBounds = NO;
    cell.backView.layer.shadowOffset = CGSizeMake(0, 0);
    cell.backView.layer.shadowRadius = 1.0;
    cell.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.backView.layer.shadowOpacity = 0.5;
    cell.backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.backView.bounds].CGPath;
    cell.backView.layer.cornerRadius = 2.0;
    
    // Coloca o layout na Collection
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 20);
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cell.collectionView.collectionViewLayout = layout;
    
    [cell.collectionView registerClass:[MHMediaPreviewCollectionViewCell class] forCellWithReuseIdentifier:@"MHMediaPreviewCollectionViewCell"];
    
    cell.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    [cell.collectionView setShowsHorizontalScrollIndicator:NO];
    [cell.collectionView setDelegate:self];
    [cell.collectionView setDataSource:self];
    [cell.collectionView setTag:indexPath.section];
    [cell.collectionView reloadData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    
    NSString *cellIdentifier = @"MHMediaPreviewCollectionViewCell";
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSIndexPath *indexPathNew = [NSIndexPath indexPathForRow:indexPath.row inSection:collectionView.tag];
    
    [self makeOverViewDetailCell:(MHMediaPreviewCollectionViewCell*)cell atIndexPath:indexPathNew];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIImageView *imageView = [(MHMediaPreviewCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath] thumbnail];
    
//    NSArray *galleryData = self.galleryDataSource[collectionView.tag];

    MHGalleryItem *item = nil;
    Noticia *noticia = (Noticia *) [noticiaLista objectAtIndex:collectionView.tag];
    
    if (![@"(null)" isEqual:noticia.foto] && ![(NSString *)[NSNull null] isEqual:noticia.foto] && ![@"" isEqual:noticia.foto]) {
        NSString *URLFoto = [NSString stringWithFormat:@"%@%@%@%@%@", url_base_arquivos, base_contexto, HTTP_Repositorio, HTTP_PathFotosNoticia, noticia.foto];
        item = [MHGalleryItem.alloc initWithURL:[Utils cleanURL:URLFoto]
                                    galleryType:MHGalleryTypeImage];
        
    } else {
        NSString *URLFoto = @"http://amatra-env.us-west-2.elasticbeanstalk.com/site/images/sem-foto.png";
        item = [MHGalleryItem.alloc initWithURL:[Utils cleanURL:URLFoto]
                                    galleryType:MHGalleryTypeImage];
    }

    
    NSArray *galleryData = @[item];
    
    MHGalleryController *gallery = [MHGalleryController galleryWithPresentationStyle:MHGalleryViewModeImageViewerNavigationBarShown];
    gallery.galleryItems = galleryData;
    gallery.presentingFromImageView = imageView;
    gallery.presentationIndex = indexPath.row;
    // gallery.UICustomization.hideShare = YES;
    //  gallery.galleryDelegate = self;
    //  gallery.dataSource = self;
    __weak MHGalleryController *blockGallery = gallery;
    
    gallery.finishedCallback = ^(NSInteger currentIndex,UIImage *image,MHTransitionDismissMHGallery *interactiveTransition,MHGalleryViewMode viewMode){
        if (viewMode == MHGalleryViewModeOverView) {
            [blockGallery dismissViewControllerAnimated:YES completion:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        }else{
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
            CGRect cellFrame  = [[collectionView collectionViewLayout] layoutAttributesForItemAtIndexPath:newIndexPath].frame;
            [collectionView scrollRectToVisible:cellFrame
                                       animated:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [collectionView reloadItemsAtIndexPaths:@[newIndexPath]];
                [collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                
                MHMediaPreviewCollectionViewCell *cell = (MHMediaPreviewCollectionViewCell*)[collectionView cellForItemAtIndexPath:newIndexPath];
                
                [blockGallery dismissViewControllerAnimated:YES dismissImageView:cell.thumbnail completion:^{
                    
                    [self setNeedsStatusBarAppearanceUpdate];
                    
                    MPMoviePlayerController *player = interactiveTransition.moviePlayer;
                    
                    player.controlStyle = MPMovieControlStyleEmbedded;
                    player.view.frame = cell.bounds;
                    player.scalingMode = MPMovieScalingModeAspectFill;
                    [cell.contentView addSubview:player.view];
                }];
            });
        }
    };
    [self presentMHGalleryController:gallery animated:YES completion:nil];
}

-(NSInteger)numberOfItemsInGallery:(MHGalleryController *)galleryController{
    return 10;
}

-(MHGalleryItem *)itemForIndex:(NSInteger)index{
    // You also have to set the image in the Testcell to get the correct Animation
    //    return [MHGalleryItem.alloc initWithImage:nil];
    return [MHGalleryItem itemWithImage:[UIImage imageNamed:@"twitterMH"]];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
#endif

-(BOOL)shouldAutorotate{
    return NO;
}

-(void)makeOverViewDetailCell:(MHMediaPreviewCollectionViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    //MHGalleryItem *item = self.galleryDataSource[indexPath.section][indexPath.row];
    MHGalleryItem *item = nil;
    
    Noticia *noticia = (Noticia *) [noticiaLista objectAtIndex:indexPath.section];
    
    if (![@"(null)" isEqual:noticia.foto] && ![(NSString *)[NSNull null] isEqual:noticia.foto] && ![@"" isEqual:noticia.foto]) {
        NSString *URLFoto = [NSString stringWithFormat:@"%@%@%@%@%@", url_base_arquivos, base_contexto, HTTP_Repositorio, HTTP_PathFotosNoticia, noticia.foto];
        NSLog(@"URLFoto: %@", [Utils cleanURL:URLFoto]);
        item = [MHGalleryItem.alloc initWithURL:[Utils cleanURL:URLFoto]
                                    galleryType:MHGalleryTypeImage];
    } else {
        NSString *URLFoto = @"http://amatra-env.us-west-2.elasticbeanstalk.com/site/images/sem-foto.png";
        item = [MHGalleryItem.alloc initWithURL:[Utils cleanURL:URLFoto]
                                    galleryType:MHGalleryTypeImage];
    }
    
    cell.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.thumbnail.layer.shadowOffset = CGSizeMake(0, 0);
    cell.thumbnail.layer.shadowRadius = 1.0;
    cell.thumbnail.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.thumbnail.layer.shadowOpacity = 0.5;
    cell.thumbnail.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.thumbnail.bounds].CGPath;
    cell.thumbnail.layer.cornerRadius = 2.0;
    
    cell.thumbnail.image = nil;
    cell.galleryItem = item;
}

- (IBAction)noticiaVisualizar:(CommentsUIButton *)sender {
    [self performSegueWithIdentifier:SEGUE_NOTICIAS_COMMENTS_LIST sender:sender];
}

- (IBAction)goListComments:(CommentsUIButton *)sender {
    [self performSegueWithIdentifier:SEGUE_NOTICIAS_COMMENTS_LIST sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(CommentsUIButton *)botao {
    NoticiaComentarioViewController *commentsViewController = segue.destinationViewController;

    commentsViewController.commentsList = botao.listComments;
    commentsViewController.noticia = botao.noticia;
}

#pragma mark - Delegate

- (void)listNoticiasReturns:(NSMutableArray *)list {
    if (noticiaLista == nil) {
        noticiaLista = [NSMutableArray arrayWithArray:list];
    } else {
        [noticiaLista addObjectsFromArray: list];
    }
    
    carregou = YES;
    
    // Esconde loading activity
    [self.navigationController.view hideActivityView];

    [self.tableView reloadData];
    [self setNeedsStatusBarAppearanceUpdate];

    NSLog(@"Tamanho lista2Ant: %lu", (unsigned long)totalNoticiasAnt);
    NSLog(@"Tamanho lista2: %lu", (unsigned long)[list count]);

//    for (Noticia *noticia in list) {
//        NSLog(@"id %lu and titulo %@ ", noticia.codigo, noticia.titulo);
//    }

}

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    
}


@end
