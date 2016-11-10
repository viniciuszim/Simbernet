//
//  LeftMenuViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 02/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "Simbernet-Swift.h"
#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "Usuario.h"
#import "InicioViewController.h"
#import "LoginViewController.h"
#import "TwitterViewController.h"
#import "IntranetViewController.h"
#import "ForumViewController.h"
#import "InstitucionalListViewController.h"
#import "InstitucionalViewController.h"
#import "AgendaViewController.h"
#import "ConfiguracoesViewController.h"

@interface LeftMenuViewController () {
    CALayer *leftBorder;
    CALayer *layerMenu;
}
- (Usuario *)getUsuario;
- (void)deleteUsuario;
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {

        // Busca usuario logado na sessao
        Usuario* usuario = [self getUsuario];
        
        [self.labelNome setText:usuario.nome];
        
        // Busca usuario logado na sessao
        NSOperationQueue *queue = [NSOperationQueue new];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadUsuario:)
                                            object:usuario];
        [queue addOperation:operation];

    }];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_azul"]];

}

//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Usuario *)getUsuario
{
    return [Usuario getUsuario];
}

- (void)deleteUsuario {
    [Usuario deleteUsuario];
}

#pragma mark - Async Loading

- (void)loadUsuario:(Usuario *) usuario {

//    NSLog(@"Usuario logado: %@", usuario);
//    NSLog(@"Nome logado: %@", usuario.nome);
    if (usuario != nil && usuario.nome != nil) {
    
        NSString *URLFoto = [NSString stringWithFormat:@"%@%@%@%@%@", url_base_arquivos, base_contexto, HTTP_Repositorio, HTTP_PathFotosUsuarios, usuario.foto];
    
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[Utils cleanURL:URLFoto]]];
        
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        
        [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
    }
}

- (void)displayImage:(UIImage *)image {
    if (image == nil) {
        [self.imageViewFoto setImage:[UIImage imageNamed:@"icon-user"]];
    } else {
        [self.imageViewFoto setImage:image];
    }

    // Arredondo a imagem
    self.imageViewFoto.layer.masksToBounds = YES;
    self.imageViewFoto.layer.cornerRadius = self.imageViewFoto.bounds.size.width/2;
}

#pragma mark - Acoes

- (IBAction)intranetAvancar:(UIButton *)sender {
    // Redireciona para tela da Intranet
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    IntranetViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IntranetViewController"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewIntranet];
}

- (IBAction)twitterAvancar:(UIButton *)sender {
    // Redireciona para tela do Twitter
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TwitterViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"TwitterViewController"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewTwitter];
}

- (IBAction)forumAvancar:(UIButton *)sender {    
    // Redireciona para tela do Forum
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ForumViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ForumViewController"];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewForum];
}

- (IBAction)institucionalAvancar:(UIButton *)sender {
    // Redireciona para tela do Institucional
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    InstitucionalListViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InstitucionalListViewControllerID"];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewInstitucional];
}

- (IBAction)contatoAvancar:(UIButton *)sender {
    // Redireciona para tela do Institucional
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    InstitucionalListViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ContatoViewControllerID"];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewInstitucional];
}

- (IBAction)agendaAvancar:(UIButton *)sender {
    // Redireciona para tela da Agenda
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    InicioViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InicioViewController"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    
    AgendaViewController *vc1 = [mainStoryboard instantiateViewControllerWithIdentifier: @"AgendaViewController"];
    
    vc1.titulo = @"Minha Agenda";
    vc1.acao = @"listar";
    vc1.acaoObter = @"obter";
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc1
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewAgenda];
}


- (IBAction)agendaPresidenteAvancar:(UIButton *)sender {
    // Redireciona para tela da Agenda
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    InicioViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InicioViewController"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    
    AgendaViewController *vc1 = [mainStoryboard instantiateViewControllerWithIdentifier: @"AgendaViewController"];
    
    vc1.titulo = @"Agenda do Presidente";
    vc1.acao = @"listarAgendaPresidente";
    vc1.acaoObter = @"obterPresidente";
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc1
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];

    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewAgendaPresidente];
}

- (IBAction)configuracoesAvancar:(UIButton *)sender {
    // Redireciona para tela de Configuracoes
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ConfiguracoesViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ConfiguracoesViewController"];
    vc.titulo = @"Configurações";
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    // Coloca efeito ao selecionar o menu
    [self setEffectMenu:_viewConfiguracoes];
}

- (IBAction)logout:(id)sender {

    // Deslogar Usuario
    [self deleteUsuario];
    self.labelNome.text = nil;
    self.imageViewFoto.image = nil;

    // Redireciona para tela de login
    [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
    
}

- (void)setEffectMenu:(UIView *) label {
    // Clean menus
    [_viewIntranet setBackgroundColor:nil];
    [_viewTwitter setBackgroundColor:nil];
    [_viewForum setBackgroundColor:nil];
    [_viewInstitucional setBackgroundColor:nil];
    [_viewAgenda setBackgroundColor:nil];
    [_viewAgendaPresidente setBackgroundColor:nil];
    [_viewConfiguracoes setBackgroundColor:nil];
    [leftBorder setBackgroundColor:nil];
    
    // Altera cor de fundo do label no menu
    [label setBackgroundColor:[UIColor simbernetMenuSelectedColor]];
    
    // Borda branca no canto esquerdo
    [self leftBorderMenu:label];
}

- (void)leftBorderMenu:(UIView *) label {
    layerMenu = [label layer];
    
    leftBorder = [CALayer layer];
    leftBorder.backgroundColor = [UIColor whiteColor].CGColor;
    leftBorder.frame = CGRectMake(0, 0, 5, layerMenu.frame.size.height);
    [leftBorder setBorderColor:[UIColor blackColor].CGColor];
    [layerMenu addSublayer:leftBorder];
}

@end
