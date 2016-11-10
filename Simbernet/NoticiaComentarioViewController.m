//
//  NoticiaComentarioViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 12/05/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "NoticiaComentarioViewController.h"
#import "Usuario.h"
#import "Simbernet-Swift.h"
#import "UIView+RNActivityView.h"
#import "Utils.h"

@implementation NoticiaCommentsCell
@end

@interface NoticiaComentarioViewController () <NoticiaServiceDelegate, UITextFieldDelegate, SWTableViewCellDelegate> {
    NSMutableArray *comentarioLista;
    BOOL carregou;
    Usuario *usuario;
    NSIndexPath *cellIndexPathPressed;
}
@property (nonatomic) CGFloat visibleOffset;
- (Usuario *)getUsuario;
- (void)showViewLoading:(NSString *)label navigation:(UINavigationController*)navigationController isDone:(BOOL)done;
- (void)showViewLoadingErro:(NSString *)label navigation:(UINavigationController*)navigationController isDone:(BOOL)done;
- (void)hideSpinnerLoading:(UINavigationController*)navigationController;
@end

@implementation NoticiaComentarioViewController

- (Usuario *)getUsuario
{
    return [Usuario getUsuario];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Busca usuario logado na sessao
    usuario = [self getUsuario];
    
    // Cor de fundo na view
    self.view.backgroundColor = [UIColor colorWithRed:0.83 green:0.84 blue:0.86 alpha:1];
    // Coloca um layout legal e estilizado na view da celula
    self.tableView.layer.masksToBounds = NO;
    self.tableView.layer.shadowOffset = CGSizeMake(0, 0);
    self.tableView.layer.shadowRadius = 1.0;
    self.tableView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tableView.layer.shadowOpacity = 0.5;
    //self.tableView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.tableView.bounds].CGPath;
    self.tableView.layer.cornerRadius = 2.0;
    
    if (self.noticia != nil) {
        
        // Informacoes da Noticia
        
        [self setTitle:@"Notícia"];
        
        if (![@"(null)" isEqual:self.noticia.titulo] && ![(NSString *)[NSNull null] isEqual:self.noticia.titulo] && ![@"" isEqual:self.noticia.titulo]) {
            self.nameLabel.text = self.noticia.titulo;
        } else {
            self.nameLabel.text = @"";
        }
        
        if (![@"(null)" isEqual:self.noticia.data] && ![(NSString *)[NSNull null] isEqual:self.noticia.data] && ![@"" isEqual:self.noticia.data]) {
            self.dateLabel.text = self.noticia.data;
        } else {
            self.dateLabel.text = @"";
        }
        
        if (![@"(null)" isEqual:self.noticia.texto] && ![(NSString *)[NSNull null] isEqual:self.noticia.texto] && ![@"" isEqual:self.noticia.texto]) {
            [self.descriptionWebView loadHTMLString:[self.noticia.texto description] baseURL:nil];
        } else {
            [self.descriptionWebView loadHTMLString:@"Sem texto" baseURL:nil];
        }
    } else if (self.evento != nil) {
        
        // Informacoes do Evento
        
        [self setTitle:@"Evento"];
        
        if (![@"(null)" isEqual:self.evento.titulo] && ![(NSString *)[NSNull null] isEqual:self.evento.titulo] && ![@"" isEqual:self.evento.titulo]) {
            self.nameLabel.text = self.evento.titulo;
        } else {
            self.nameLabel.text = @"";
        }
        
        if (![@"(null)" isEqual:self.evento.dtInicioAux] && ![(NSString *)[NSNull null] isEqual:self.evento.dtInicioAux] && ![@"" isEqual:self.evento.dtInicioAux]) {
            self.dateLabel.text = self.evento.dtInicioAux;
        } else {
            self.dateLabel.text = @"";
        }
        
        if (![@"(null)" isEqual:self.evento.texto] && ![(NSString *)[NSNull null] isEqual:self.evento.texto] && ![@"" isEqual:self.evento.texto]) {
            [self.descriptionWebView loadHTMLString:[self.evento.texto description] baseURL:nil];
        } else {
            [self.descriptionWebView loadHTMLString:@"Sem texto" baseURL:nil];
        }
    }
    
    ////////

    // Ajustando a altura da webView de descricao
    CGRect newFrameDescription = self.descriptionWebView.frame;
    newFrameDescription.size.height = self.view.frame.size.height - (newFrameDescription.origin.y + newFrameDescription.size.height + 20);
    self.descriptionWebView.frame = newFrameDescription;

    // Ajustando a altura da view
    CGRect newFrameView = self.backView.frame;
    newFrameView.size.height = self.descriptionWebView.frame.size.height + 120;
    self.backView.frame = newFrameView;
//    [self.backView setBackgroundColor: [UIColor redColor]];

    // Ajustando o posicionamento da Label Comentarios
    CGRect newFrameComentarioLabel = self.comentarioLabel.frame;
    newFrameComentarioLabel.origin.y = self.backView.frame.size.height - 70;
    self.comentarioLabel.frame = newFrameComentarioLabel;
    
    // Ajustando o posicionamento da Label Comentarios
    CGRect newFrameNenhumLabel = self.nenhumLabel.frame;
    newFrameNenhumLabel.origin.y = self.backView.frame.size.height - 30;
    self.nenhumLabel.frame = newFrameNenhumLabel;

    //SET THE LAST VIEW WHICH THE KEYBOARD WILL NOT HIDE
    self.lastVisibleView = self.tableView;
    self.visibleMargin = 15.;
    
    // Muda a posição inicial do scroll
//    [self.tableView setContentOffset:CGPointMake(0, 1500) animated:YES];
}

-(void)launchReload {
    if (self.noticia != nil) {
        NoticiaService* comentarioService = [NoticiaService new];
        comentarioService.delegate = self;
        [comentarioService listComentarios:self.noticia.codigo];
    } else if (self.evento != nil) {
        EventoService* comentarioService = [EventoService new];
        comentarioService.delegate = self;
//        [comentarioService listComentarios:self.evento.codigo];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Lista Comentarios da noticia do Java/Postgres
    [self launchReload];
    
    // Teclado
    self.addCommentTextField.returnKeyType = UIReturnKeyDone;
    [self.addCommentTextField setDelegate:self];
    
    //// Controla o movimento da view quando o teclado é acionado
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.visibleMargin = 10.;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Metodos da tabela

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Comentario *comentario = (Comentario *) [comentarioLista objectAtIndex:indexPath.row];
    if (comentario != nil) {
        return [self calculateHeightLabelText:comentario.comentario] + 35;
    } else {
        return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [comentarioLista count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"NoticiaCommentsCell";
    
    NoticiaCommentsCell *cell = (NoticiaCommentsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    }
    
    if (carregou) {
        cell.nameLabel.hidden = NO;
        cell.userPhotoImage.hidden = NO;
        cell.commentLabel.hidden = NO;
        cell.dataLabel.hidden = NO;
    }
    
    /// Adicionando os dados na Celula/////////////////////////////////////////////
    Comentario *comentario = (Comentario *) [comentarioLista objectAtIndex:indexPath.row];

    // PHOTO
    @try
    {
        if (comentario.fotoUsuario != nil
                && ![comentario.fotoUsuario isEqualToString:@""]) {
            
            // Busca foto do usuario assincronamente
            NSOperationQueue *queue = [NSOperationQueue new];
            NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                                initWithTarget:self
                                                selector:@selector(loadImage:)
                                                object:@[comentario.fotoUsuario,cell]];
            [queue addOperation:operation];
        }
    }
    @catch (NSException *ex) {
        NSLog(@"erro ao buscar imagem da lista de comentarios");
    }
    // Se for o author do comentario adiciono o swipe para Apagar comentario

    if (usuario.codigo == comentario.codigoUsuario) {
        //////////////////////////////////////////////////////////////////
        // Add utility buttons
//    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        // Armazeno qual linha deve ser excluida da lista
        cell.cellIndexPathPressed = indexPath;
        // Passo o codigo do comentario que deve ser excluido
        cell.codigo = comentario.codigo;
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Apagar"];
        
        cell.rightUtilityButtons = rightUtilityButtons;
        cell.delegate = self;
    }
    
    // NAME
//    NSString *nome = [NSString stringWithFormat:@"%d - %@", indexPath.row, comentario.nomeUsuario];
    cell.nameLabel.text = comentario.nomeUsuario;
    
    // COMMENT
    cell.commentLabel.text = comentario.comentario;
    
    // DATA
    cell.dataLabel.text = comentario.data;
    
    // Ajustando a altura da label de comentarios
    CGRect newFrame = cell.commentLabel.frame;
    newFrame.size.height = [self calculateHeightLabelText:comentario.comentario];
    cell.commentLabel.frame = newFrame;
    
    return cell;
}

- (void)swipeableTableViewCell:(NoticiaCommentsCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {

    NoticiaService* comentarioService = [NoticiaService new];
    comentarioService.delegate = self;
    [comentarioService apagarComentario:cell.codigo];
    
    // Armazeno qual linha deve ser excluida da lista
    cellIndexPathPressed = cell.cellIndexPathPressed;
    
    // Loading
    [self showViewLoading:@"Apagando" navigation:self.navigationController isDone:NO];

    // Esconde o teclado
    [self.view endEditing:YES];
}

#pragma Metodos Uteis

#define FONT_SIZE 13.0f
-(CGFloat)calculateHeightLabelText:(NSString *)labelComment {
    CGFloat lRetval = 10;
    CGSize maximumLabelSize = CGSizeMake(231, FLT_MAX);
    
    CGRect textRect = [labelComment boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
                                                 context:nil];
    lRetval = textRect.size.height;
    
    return lRetval;
}

- (void)loadImage:(NSArray *)array {
    NSString *fotoUsuario = (NSString*) [array objectAtIndex:0];
    NoticiaCommentsCell *cell = (NoticiaCommentsCell*) [array objectAtIndex:1];
    
    NSString *URLFoto = [NSString stringWithFormat:@"%@%@%@%@%@", url_base_arquivos, base_contexto, HTTP_Repositorio, HTTP_PathFotosUsuarios, fotoUsuario];
    
    NSLog(@"comentario.fotoUsuario: %@", [Utils cleanURL:URLFoto]);
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[Utils cleanURL:URLFoto]]];
    
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(displayImage:) withObject:@[image,cell] waitUntilDone:NO];
}

- (void)displayImage:(NSArray *)array {
    UIImage *image = (UIImage*) [array objectAtIndex:0];
    NoticiaCommentsCell *cell = (NoticiaCommentsCell*) [array objectAtIndex:1];
    [cell.userPhotoImage setImage:image];

    // Arredondo a imagem
    cell.userPhotoImage.layer.masksToBounds = YES;
    cell.userPhotoImage.layer.cornerRadius = cell.userPhotoImage.bounds.size.width/2;
}

#pragma mark - Delegate NoticiaService

- (void)listComentariosReturns:(NSMutableArray *)list {
    comentarioLista = [NSMutableArray arrayWithArray:list];

    if ([comentarioLista count] > 0) {
        carregou = YES;
        self.comentarioLabel.hidden = NO;
        self.addCommentView.hidden = NO;
        
        self.nenhumLabel.hidden = YES;
        
        // Ajustando o posicionamento da Label Comentarios
        CGRect newFrameComentarioLabel = self.comentarioLabel.frame;
        newFrameComentarioLabel.origin.y = self.backView.frame.size.height - 30;
        self.comentarioLabel.frame = newFrameComentarioLabel;
    } else {
        self.nenhumLabel.hidden = NO;

    }

    [self.tableView reloadData];
}

- (void)inserirComentarioReturns:(Comentario *)comentario success:(BOOL)success {
    
    if (success) {
        if (comentarioLista == nil) {
            comentarioLista = [NSMutableArray new];
            [comentarioLista addObject:comentario];
            
        } else {
            [comentarioLista addObject:comentario];

        }
        
        //**//
        carregou = YES;
        self.comentarioLabel.hidden = NO;
        self.addCommentView.hidden = NO;
        
        self.nenhumLabel.hidden = YES;
        
        // Ajustando o posicionamento da Label Comentarios
        CGRect newFrameComentarioLabel = self.comentarioLabel.frame;
        newFrameComentarioLabel.origin.y = self.backView.frame.size.height - 30;
        self.comentarioLabel.frame = newFrameComentarioLabel;
        /**/
        
        NSMutableArray *_tempIndexPathArr = [NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:[comentarioLista count] -1  inSection:0]];
        [self.tableView insertRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationLeft];
        
        self.addCommentTextField.text = @"Adicionar comentário...";

        // Alerta Conectou
        [self showViewLoading:@"Enviado" navigation:self.navigationController isDone:YES];

        // Redireciona
        [self performSelector:@selector(hideSpinnerLoading:) withObject:self.navigationController afterDelay:1.0];
        
    } else {
        // Alerta de Erro
        [self showViewLoadingErro:@"Erro" navigation:self.navigationController isDone:YES];

    }

}

- (void)apagarComentarioReturns:(Comentario *)comentario success:(BOOL)success {
    
    if (success) {
        // Delete button is pressed
        [comentarioLista removeObjectAtIndex:cellIndexPathPressed.row];
        [self.tableView deleteRowsAtIndexPaths:@[cellIndexPathPressed] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView reloadData];
        
        // Alerta Conectou
        [self showViewLoading:@"Apagado" navigation:self.navigationController isDone:YES];
        
        // Redireciona
        [self performSelector:@selector(hideSpinnerLoading:) withObject:self.navigationController afterDelay:1.0];
        
    } else {
        // Alerta de Erro
        [self showViewLoadingErro:@"Erro" navigation:self.navigationController isDone:YES];
        
    }
    
}

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    NSLog(@"Erro: %@", error);
    // Alerta de Mensagem de Erro
    [self showViewLoadingErro:@"Erro" navigation:self.navigationController isDone:YES];
}

#pragma mark TextField Hidden
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Esconde o teclado
    [self.view endEditing:YES];
    
    return YES;
}

#pragma keyboard height

- (void) keyboardWillShow:(NSNotification *)note
{
    // Tiro o texto do textField
    [self.addCommentTextField setTextColor:[UIColor darkGrayColor]];
    if ([self.addCommentTextField.text isEqualToString:@"Adicionar comentário..."]) {
        self.addCommentTextField.text = @"";
    }
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    CGRect frame = self.view.frame;
    CGFloat visibleHeight = frame.size.height - keyboardBounds.size.height ;
    CGFloat lastVisiblePointY = self.lastVisibleView.frame.origin.y + self.lastVisibleView.frame.size.height;
    if (self.lastVisibleView && self.visibleOffset == 0 && (lastVisiblePointY + self.visibleMargin ) > visibleHeight) {
        self.visibleOffset = lastVisiblePointY - visibleHeight + self.visibleMargin ;
        frame.origin.y -= self.visibleOffset;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
}


- (void) keyboardWillHide:(NSNotification *)note
{
    // Coloco o texto do textField
    [self.addCommentTextField setTextColor:[UIColor lightGrayColor]];
    if ([self.addCommentTextField.text isEqualToString:@""]) {
        self.addCommentTextField.text = @"Adicionar comentário...";
    }
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect frame = self.view.frame;
    frame.origin.y += self.visibleOffset;
    self.visibleOffset = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
}

#pragma Adicionar Comentario
- (IBAction)adicionarComentario:(UIButton *)sender {
    Comentario *comentario = [Comentario new];
    comentario.codigoNoticia = self.noticia.codigo;
    comentario.codigoUsuario = usuario.codigo;
    comentario.nomeUsuario = usuario.nome;
    comentario.fotoUsuario = usuario.foto;
    comentario.comentario = self.addCommentTextField.text;
    
    NoticiaService* comentarioService = [NoticiaService new];
    comentarioService.delegate = self;
    [comentarioService inserirComentario:comentario];
    
    // Loading
    [self showViewLoading:@"Enviando" navigation:self.navigationController isDone:NO];

    // Esconde o teclado
    [self.view endEditing:YES];
}

#pragma Utils
- (void)showViewLoading:(NSString *)label navigation:(UINavigationController*)navigationController isDone:(BOOL)done {
    [Utils showViewLoading:label navigation:navigationController isDone:done];
}

- (void)showViewLoadingErro:(NSString *)label navigation:(UINavigationController*)navigationController isDone:(BOOL)done {
    [Utils showViewLoadingErro:label navigation:navigationController isDone:done];
}

- (void)hideSpinnerLoading:(UINavigationController*)navigationController {
    [Utils hideSpinnerLoading:navigationController];
}

@end
