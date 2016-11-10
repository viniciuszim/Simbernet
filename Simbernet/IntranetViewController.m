//
//  IntranetViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 15/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "IntranetViewController.h"
#import "NoticiaService.h"
#import "HTHorizontalSelectionList.h"

@interface IntranetViewController () <NoticiaServiceDelegate, HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource>

@property (nonatomic, strong) UIView *backgroundTopo;
@property (nonatomic, strong) HTHorizontalSelectionList *textSelectionList;
@property (nonatomic, strong) NSArray *submenus;

@property (nonatomic, strong) UILabel *selectedLabel;

@end

@implementation IntranetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Lista Noticias
//    NoticiaService* noticiaService = [NoticiaService new];
//    noticiaService.delegate = self;
//    [noticiaService listNoticias];
    
    // TOPO background
    self.backgroundTopo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
//    [self.backgroundTopo setBackgroundColor:[UIColor simbernetDefaultColor]];
    self.backgroundTopo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_azul"]];
    
    [self.view addSubview:self.backgroundTopo];

    ///// Menu Horizontal
    self.textSelectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    self.textSelectionList.delegate = self;
    self.textSelectionList.dataSource = self;
    
    self.textSelectionList.selectionIndicatorColor = [UIColor simbernetSelectedColor];
    self.textSelectionList.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_azul"]];
//    [self.textSelectionList setBackgroundColor:[UIColor whiteColor]];
    //    [self.textSelectionList setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    self.submenus = @[@"Notícias",
                      @"Eventos",
                      @"Aniversariantes",
                      @"Downloads"];
    
    [self.view addSubview:self.textSelectionList];
    
    //self.selectedLabel = [UILabel new];
    //self.selectedLabel.text = self.submenus[self.textSelectionList.selectedButtonIndex];
    //self.selectedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //[self.view addSubview:self.selectedLabel];
    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedLabel
//                                                          attribute:NSLayoutAttributeCenterX
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterX
//                                                         multiplier:1.0
//                                                           constant:0.0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedLabel
//                                                          attribute:NSLayoutAttributeCenterY
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterY
//                                                         multiplier:1.0
//                                                           constant:0.0]];
    
    // Altera o tamanho da View, que é onde os dados da celula ficam em cima
    CGRect rectFrame = CGRectMake(self.view.frame.origin.x,
                                  self.view.frame.origin.y,
                                  self.view.frame.size.width,
                                  self.view.frame.size.height);
    self.containerViewNoticia.frame = rectFrame;
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.submenus.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.submenus[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
//    self.selectedLabel.text = self.submenus[index];
    
    switch (index) {
        case 0: // Noticias
            self.containerViewNoticia.hidden = NO;
            self.containerViewEvento.hidden = YES;
            self.containerViewAniversariante.hidden = YES;
            self.containerViewDownload.hidden = YES;
            break;

        case 1: // Eventos
            self.containerViewNoticia.hidden = YES;
            self.containerViewEvento.hidden = NO;
            self.containerViewAniversariante.hidden = YES;
            self.containerViewDownload.hidden = YES;
            break;

        case 2: // Aniversariantes
            self.containerViewNoticia.hidden = YES;
            self.containerViewEvento.hidden = YES;
            self.containerViewAniversariante.hidden = NO;
            self.containerViewDownload.hidden = YES;
            break;
            
        case 3: // Downloads
            self.containerViewNoticia.hidden = YES;
            self.containerViewEvento.hidden = YES;
            self.containerViewAniversariante.hidden = YES;
            self.containerViewDownload.hidden = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate

- (void)listNoticiasReturns:(NSArray *)noticiaList {
    for (Noticia* noticia in noticiaList) {
        NSLog(@"id %lu and titulo %@ ", noticia.codigo, noticia.titulo);
    }
}

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    
}

@end
