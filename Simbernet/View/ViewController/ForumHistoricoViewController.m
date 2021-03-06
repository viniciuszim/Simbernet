//
//  ForumHistoricoViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 11/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "ForumHistoricoViewController.h"
#import "Usuario.h"
#import "Simbernet-Swift.h"
#import "UIView+RNActivityView.h"
#import "Utils.h"

@implementation ForumHistoricoCell
@end

@interface ForumHistoricoViewController () <ForumServiceDelegate, UITextFieldDelegate, SWTableViewCellDelegate> {
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

@implementation ForumHistoricoViewController

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
    
    if (self.forum != nil) {
        
        // Informacoes do Forum
        
        [self setTitle:@"Comentários"];
        
        if (![@"(null)" isEqual:self.forum.titulo] && ![(NSString *)[NSNull null] isEqual:self.forum.titulo] && ![@"" isEqual:self.forum.titulo]) {
            self.topicoLabel.text = self.forum.titulo;
        } else {
            self.topicoLabel.text = @"";
        }
        
        if (![@"(null)" isEqual:self.forum.categoriaNome] && ![(NSString *)[NSNull null] isEqual:self.forum.categoriaNome] && ![@"" isEqual:self.forum.categoriaNome]) {
            self.categoriaSalaLabel.text = [NSString stringWithFormat:@"%@ - %@", self.forum.categoriaNome, self.forum.salaNome];
        } else {
            self.categoriaSalaLabel.text = @"";
        }
    }
    
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
    if (self.forum != nil) {
        ForumService* historicoService = [ForumService new];
        historicoService.delegate = self;
        [historicoService listHistorico:self.forum.codigo];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Lista historico do topico do forum do Java/Postgres
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

    // Loading
    if (!carregou) {
        [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Metodos da tabela

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ForumHistoricoModel *comentario = (ForumHistoricoModel *) [comentarioLista objectAtIndex:indexPath.row];
    if (comentario != nil && comentario.texto != nil && ![comentario.texto isEqual:@""]) {
        return (self.comentarioWebView.frame.size.height);
    } else {
        return 50;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [comentarioLista count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"ForumHistoricoCell";
    
    ForumHistoricoCell *cell = (ForumHistoricoCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    }
    
    if (carregou) {
        cell.nameLabel.hidden = NO;
        cell.userPhotoImage.hidden = NO;
        cell.textWebView.hidden = NO;
//        cell.textoTextView.hidden = NO;
        cell.dataLabel.hidden = NO;
    }
    
    /// Adicionando os dados na Celula/////////////////////////////////////////////
    ForumHistoricoModel *comentario = (ForumHistoricoModel *) [comentarioLista objectAtIndex:indexPath.row];
    
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
        cellIndexPathPressed = indexPath;
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
    
    // TEXTO
    CGRect newFrame = cell.textWebView.frame;
    if (![@"(null)" isEqual:comentario.texto] && ![(NSString *)[NSNull null] isEqual:comentario.texto] && ![@"" isEqual:comentario.texto]) {
        NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title><style type=\"text/css\">p { margin:-3; text-align:left; }</style></head><body style=\"font-family: Arial, Helvetica, sans-serif; font-size:10pt\">"];
        NSLog(@"%@", comentario.texto);
        [html appendString:comentario.texto];
        [html appendString:@"</body></html>"];

        [cell.textWebView loadHTMLString:html baseURL:nil];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[comentario.texto dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        newFrame.size.height = [self calculateHeightLabelText:[attributedString string]];

    } else {
        [cell.textWebView loadHTMLString:@"&nbsp;" baseURL:nil];
        newFrame.size.height = 50;
    }
    // Ajustando a altura da label de comentarios
    cell.textWebView.frame = newFrame;
    
//    cell.textoTextView.scrollEnabled = NO;
//    cell.textWebView.userInteractionEnabled = NO;
    
    self.comentarioWebView = cell.textWebView;
    
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[comentario.texto dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        cell.textoTextView.attributedText = attributedString;

    // DATA
    cell.dataLabel.text = comentario.data;
    
    return cell;
}

- (void)swipeableTableViewCell:(ForumHistoricoCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    ForumService* historicoService = [ForumService new];
    historicoService.delegate = self;
    [historicoService apagarHistorico:cell.codigo];
    
    // Loading
    [self showViewLoading:@"Apagando" navigation:self.navigationController isDone:NO];
    
    // Esconde o teclado
    [self.view endEditing:YES];
}

#pragma Metodos Uteis

#define FONT_SIZE 13.1f
-(CGFloat)calculateHeightLabelText:(NSString *)labelComment {
    CGFloat lRetval = 10;
    CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width - 68, FLT_MAX);
    
    CGRect textRect = [labelComment boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
                                                 context:nil];
    lRetval = textRect.size.height + 60;
    
    if (lRetval < 50) {
        lRetval = 50;
    }
    
    return lRetval;
}

- (void)loadImage:(NSArray *)array {
    NSString *fotoUsuario = (NSString*) [array objectAtIndex:0];
    ForumHistoricoCell *cell = (ForumHistoricoCell*) [array objectAtIndex:1];
    
    NSString *URLFoto = [NSString stringWithFormat:@"%@%@%@%@%@", url_base_arquivos, base_contexto, HTTP_Repositorio, HTTP_PathFotosUsuarios, fotoUsuario];
    
    NSLog(@"forum.historico.fotoUsuario: %@", [Utils cleanURL:URLFoto]);
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[Utils cleanURL:URLFoto]]];
    
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    
    if (image != nil) {
        [self performSelectorOnMainThread:@selector(displayImage:) withObject:@[image,cell] waitUntilDone:NO];
    }
}

- (void)displayImage:(NSArray *)array {
    UIImage *image = (UIImage*) [array objectAtIndex:0];
    ForumHistoricoCell *cell = (ForumHistoricoCell*) [array objectAtIndex:1];
    [cell.userPhotoImage setImage:image];
    
    // Arredondo a imagem
    cell.userPhotoImage.layer.masksToBounds = YES;
    cell.userPhotoImage.layer.cornerRadius = cell.userPhotoImage.bounds.size.width/2;
}

#pragma mark - Delegate ForumService

- (void)listHistoricoReturns:(NSMutableArray *)list {
    comentarioLista = [NSMutableArray arrayWithArray:list];
    
    if ([comentarioLista count] > 0) {
        carregou = YES;
        
        // Esconde loading activity
//        [self.navigationController.view hideActivityView];
        
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

    if (carregou) {
        // Esconde loading activity
        [self.navigationController.view hideActivityView];
      
        [self.tableView reloadData];
        
    }
}

- (void)inserirHistoricoReturns:(ForumHistoricoModel *)comentario success:(BOOL)success {
    
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

- (void)apagarHistoricoReturns:(ForumHistoricoModel *)comentario success:(BOOL)success {
    
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
    ForumHistoricoModel *comentario = [ForumHistoricoModel new];
    comentario.codigoTopico = self.forum.codigo;
    comentario.codigoUsuario = usuario.codigo;
    comentario.nomeUsuario = usuario.nome;
    comentario.fotoUsuario = usuario.foto;
    comentario.texto = self.addCommentTextField.text;
    
    ForumService* comentarioService = [ForumService new];
    comentarioService.delegate = self;
    [comentarioService inserirHistorico:comentario];
    
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

