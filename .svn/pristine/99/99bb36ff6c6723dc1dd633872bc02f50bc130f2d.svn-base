//
//  ForumViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 11/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "ForumViewController.h"
#import "UIView+RNActivityView.h"
#import "ForumService.h"
#import "ForumHistoricoViewController.h"
#import "UsuarioService.h"
#import "Usuario.h"

@implementation ForumCommentsUIButton
@end

@implementation ForumTableViewCell
@end

@interface ForumViewController () <ForumServiceDelegate, UserServiceDelegate> {
    NSMutableArray *forumLista;
    NSMutableArray *paginas;
    NSNumber* pagina;
    BOOL carregou;
    
    UIRefreshControl* refreshControl;
}
- (Usuario *)getUsuario;
@end

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Seto pagina 1 a primeira vez que entra na lista
    pagina = [NSNumber numberWithInt:1];
    [paginas addObject:pagina];
    
    // Lista topicos do Java
    [self launchReload];
    
    // Initialize the refresh control.
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor lightGrayColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(updateForuns)
             forControlEvents:UIControlEventValueChanged];
    
    refreshControl.attributedTitle = [ForumModel getUltimaAtualizacao];
    
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

-(void)updateForuns {
    
    // Seto pagina 1 para buscar do início com o refresh
    pagina = [NSNumber numberWithInt:1];
    [paginas addObject:pagina];
    
    // Lista foruns do Java
    [self launchReload];
}

-(void)launchReload {
    Usuario* usuario = [self getUsuario];
//    NSLog(@"Usuario logado: %ld", usuario.codigo);
    ForumService* forumService = [ForumService new];
    forumService.delegate = self;
    [forumService listForuns: pagina.intValue usuario:usuario.codigo];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return forumLista.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"ForumTableViewCell";
    
    ForumTableViewCell *cell = (ForumTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    }
    
    if (carregou) {
        cell.backView.hidden = NO;
        cell.topicoLabel.hidden = NO;
        cell.categoriaSalaLabel.hidden = NO;
        cell.ultimaAtualizacaoLabel.hidden = NO;
    }
    
    if ((indexPath.section == [forumLista count] - 1) && ([forumLista count] > 20))
    {
        int value = [pagina intValue];
        pagina = [NSNumber numberWithInt:value + 1];
        
        [self launchReload];
        [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
    ForumModel *forum = (ForumModel *) [forumLista objectAtIndex:indexPath.section];
    
    cell.topicoLabel.text = forum.titulo;
    cell.categoriaSalaLabel.text = [NSString stringWithFormat:@"%@ - %@", forum.categoriaNome, forum.salaNome];
    cell.ultimaAtualizacaoLabel.text = [NSString stringWithFormat:@"%@ às %@", forum.usuarioUltimaAtualizacao, forum.dataUltimaAtualizacao];
    
    // Botao Comentarios
    cell.commentsButton.forum = forum;
    if (forum.totalComentarios == 1) {
        NSString *labelButton = [NSString stringWithFormat:@"%ld %@", forum.totalComentarios, @"comentário"];
        [cell.commentsButton setTitle:labelButton forState:UIControlStateNormal];
//        [cell.commentsButton setHidden:NO];
    } else if (forum.totalComentarios > 1) {
        NSString *labelButton = [NSString stringWithFormat:@"%ld %@", forum.totalComentarios, @"comentários"];
        [cell.commentsButton setTitle:labelButton forState:UIControlStateNormal];
        [cell.commentsButton addTarget:self
                    action:@selector(telaHistoricoForum:)
                    forControlEvents:UIControlEventTouchUpInside];

//        [cell.commentsButton setHidden:NO];
//    } else {
//        [cell.commentsButton setHidden:YES];
    }
    
    // Notificacao
    if (forum.notificacao != nil && [forum.notificacao isEqualToString:@"N"]) {
        cell.imageNotification.image = [UIImage imageNamed:@"ic_notifications_off_48pt"];
    } else {
        cell.imageNotification.image = [UIImage imageNamed:@"ic_notifications_48pt"];
    }
    cell.notificationButton.cell = cell;
    cell.notificationButton.forum = forum;
    [cell.notificationButton setTitle:@"" forState:UIControlStateNormal];
    [cell.notificationButton addTarget:self
                            action:@selector(changeNotification:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    // E-mail Notificacao
    if (forum.notificacaoEmail != nil && [forum.notificacaoEmail isEqualToString:@"N"]) {
        cell.imageEmailNotification.image = [UIImage imageNamed:@"ic_email_block_off"];
    } else {
        cell.imageEmailNotification.image = [UIImage imageNamed:@"ic_email_azul"];
    }
    cell.emailNotificationButton.cell = cell;
    cell.emailNotificationButton.forum = forum;
    [cell.emailNotificationButton setTitle:@"" forState:UIControlStateNormal];
    [cell.emailNotificationButton addTarget:self
                                action:@selector(changeEmailNotification:)
                      forControlEvents:UIControlEventTouchUpInside];

    // Altera o tamanho da View, que é onde os dados da celula ficam em cima
    CGRect rectFrame = CGRectMake(cell.backView.frame.origin.x,
                                  cell.backView.frame.origin.y,
                                  self.view.frame.size.width - 20,
                                  100);
    cell.backView.frame = rectFrame;

    cell.backView.layer.masksToBounds = NO;
    cell.backView.layer.shadowOffset = CGSizeMake(0, 0);
    cell.backView.layer.shadowRadius = 1.0;
    cell.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.backView.layer.shadowOpacity = 0.5;
    cell.backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.backView.bounds].CGPath;
    cell.backView.layer.cornerRadius = 2.0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate{
    return NO;
}

- (IBAction)telaHistoricoForum:(ForumCommentsUIButton *)sender {
    NSLog(@"-telaHistoricoForum");
    [self performSegueWithIdentifier:SEGUE_FORUNS_FORUM_HISTORICO sender:sender];
}

- (IBAction)changeNotification:(ForumCommentsUIButton *)button {
    NSLog(@"-changeNotification: %@", button.forum.notificacao);
    Usuario* usuario = [self getUsuario];
    ForumService* forumService = [ForumService new];
    forumService.delegate = self;
    button.forum.usuarioLogado = usuario.codigo;
    
    ForumTableViewCell *cell = (ForumTableViewCell*) button.cell;
    if (button.forum.notificacao != nil && [button.forum.notificacao isEqualToString:@"N"]) {
        button.forum.notificacao = @"S";
        cell.imageNotification.image = [UIImage imageNamed:@"ic_notifications_48pt"];
    } else {
        button.forum.notificacao = @"N";
        cell.imageNotification.image = [UIImage imageNamed:@"ic_notifications_off_48pt"];
    }
    
    [forumService alterarNotificacaoTopico:button.forum];
}

- (IBAction)changeEmailNotification:(ForumCommentsUIButton *)button {
    NSLog(@"-changeEmailNotification: %@", button.forum.notificacaoEmail);
    Usuario* usuario = [self getUsuario];
    ForumService* forumService = [ForumService new];
    forumService.delegate = self;
    button.forum.usuarioLogado = usuario.codigo;
    
    ForumTableViewCell *cell = (ForumTableViewCell*) button.cell;
    if (button.forum.notificacaoEmail != nil && [button.forum.notificacaoEmail isEqualToString:@"N"]) {
        button.forum.notificacaoEmail = @"S";
        cell.imageEmailNotification.image = [UIImage imageNamed:@"ic_email_azul"];
    } else {
        button.forum.notificacaoEmail = @"N";
        cell.imageEmailNotification.image = [UIImage imageNamed:@"ic_email_block_off"];
    }
    
    [forumService alterarEmailNotificacaoTopico:button.forum];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(ForumCommentsUIButton *)botao {
    ForumHistoricoViewController *controller = segue.destinationViewController;
    controller.forum = botao.forum;
}

#pragma mark - Delegate

- (void)listForunsReturns:(NSMutableArray *)list {
    if (forumLista == nil || pagina.intValue == 1) {
        forumLista = [NSMutableArray arrayWithArray:list];
    } else {
        [forumLista addObjectsFromArray: list];
    }
    
    carregou = YES;
    
    // Esconde loading activity
    [self.navigationController.view hideActivityView];
    
    [self.tableView reloadData];
    //    [self setNeedsStatusBarAppearanceUpdate];
    
    // End the refreshing
    if (refreshControl) {
        
        [refreshControl endRefreshing];
        
        [ForumModel setUltimaAtualizacao];
        refreshControl.attributedTitle = [ForumModel getUltimaAtualizacao];
    }
}

- (void)alterarNotificacaoTopicoReturns:(ForumModel *)forum success:(BOOL)success {
    //
    NSLog(@"Alterada notificacao com sucesso!");
}

- (void)alterarEmailNotificacaoTopicoReturns:(ForumModel *)forum success:(BOOL)success {
    //
    NSLog(@"Alterada email notificacao com sucesso!");
}

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    
}

#pragma - UsuarioServiceDelegate

-(Usuario *)getUsuario
{
    return [Usuario getUsuario];
}

@end
