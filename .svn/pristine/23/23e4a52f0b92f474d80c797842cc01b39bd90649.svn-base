//
//  DownloadViewController.m
//  Simbernet
//
//  Created by Vinicius Miguel on 14/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "DownloadViewController.h"
#import "DiretorioArqService.h"
#import "DownloadGenericModel.h"
#import "DownloadTipoModel.h"
#import "DownloadModel.h"
#import "Utils.h"
#import "WebViewController.h"

@implementation DownloadTableViewCell
@end

@interface DownloadViewController () <DiretorioArqServiceDelegate, IQDropDownTextFieldDelegate> {
    
    DownloadGenericModel* downloadGeneric;
    
    // Services
    DiretorioArqService* diretorioServ;
    
}

// Views
@property (strong, nonatomic) IBOutlet UIView *viewFiltro;
@property (strong, nonatomic) IBOutlet UIView *viewDiretorio;
@property (strong, nonatomic) IBOutlet UIView *viewTableTitle;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// viewFiltro
@property (strong, nonatomic) IBOutlet UIButton *btnFiltrar;
@property (strong, nonatomic) IBOutlet IQDropDownTextField *txtFiltroTipo;
@property (strong, nonatomic) IBOutlet UITextField *txtFiltroNome;
@property (strong, nonatomic) IBOutlet UIButton *btnBuscar;

// viewDiretorio
@property (strong, nonatomic) IBOutlet UIButton *btnDiretorio;
@property (strong, nonatomic) IBOutlet UILabel *lblDiretorioName;

// Variables
@property (strong, nonatomic) NSMutableArray* tipoList;
@property (strong, nonatomic) NSMutableArray* downloadList;
@property (nonatomic) BOOL isQuerying;

@property (strong, nonatomic) NSMutableDictionary* cellArray;

@property (nonatomic,retain) UIDocumentInteractionController *docFile;

@end

@implementation DownloadViewController

#pragma mark - Class' Variables

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // Setting configurations
    
    [self fontSetting];
    [self screenSetting];
    
    // ================================================================================
    
    // === Setting Tipos
    
    self.tipoList = [DownloadTipoModel getFullItemsList];

    NSMutableArray* tipos = [NSMutableArray new];
    for (DownloadTipoModel* tipo in self.tipoList) {
        [tipos addObject:tipo.descricao];
    }
    
    self.txtFiltroTipo.delegate = self;
    [self.txtFiltroTipo setItemList:tipos];
    
    // ========================================================
    
    self.lblDiretorioName.text = @".";
    [self.btnDiretorio setImage:[UIImage imageNamed:@"folder"] forState:UIControlStateNormal];
    self.btnDiretorio.tag = 0;
    
    self.cellArray = [NSMutableDictionary new];
    self.downloadList = [NSMutableArray new];
    
    diretorioServ = [DiretorioArqService new];
    diretorioServ.delegate = self;
    
    downloadGeneric = [DownloadGenericModel new];
    [diretorioServ consultarDiretoriosDownloads:downloadGeneric];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fontSetting {
    
}

- (void)screenSetting {
    
    self.viewFiltro.frame = CGRectMake(0, -self.viewFiltro.frame.size.height, self.viewFiltro.frame.size.width, self.viewFiltro.frame.size.height);
    self.viewFiltro.hidden = YES;
    
    self.viewDiretorio.frame = CGRectMake(0, 0, self.viewDiretorio.frame.size.width, self.viewDiretorio.frame.size.height);
    
    self.viewTableTitle.frame = CGRectMake(0, self.viewDiretorio.frame.size.height, self.viewTableTitle.frame.size.width, self.viewTableTitle.frame.size.height);
    
    CGFloat tablePosition = 0;
    tablePosition = self.viewDiretorio.frame.size.height + self.viewTableTitle.frame.size.height;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat tableHeight = screenBounds.size.height - self.viewDiretorio.frame.size.height - self.viewTableTitle.frame.size.height;
    self.tableView.frame = CGRectMake(0, tablePosition, self.tableView.frame.size.width, tableHeight);
    
}

#pragma mark - Method's Submenu

- (IBAction)onButtonFiltrarPressed:(UIButton *)sender {
    
    if (self.viewFiltro.hidden) {
        [self showSubMenu];
    } else {
        [self hideSubMenu];
    }
}

-(void) showSubMenu {
    
    self.viewFiltro.hidden = NO;
    
    // Set new origin of menu
    CGRect menuFrame = self.viewFiltro.frame;
    menuFrame.origin.y = 0;
    
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.viewFiltro.frame = menuFrame;
                         self.viewFiltro.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         self.viewFiltro.hidden = NO;
                     }];
    [UIView commitAnimations];
}

- (void) hideSubMenu {
    
    // Set new origin of menu
    CGRect menuFrame = self.viewFiltro.frame;
    menuFrame.origin.y = -self.viewFiltro.frame.size.height;
    
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.viewFiltro.frame = menuFrame;
                         self.viewFiltro.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         self.viewFiltro.hidden = YES;
                     }];
    [UIView commitAnimations];
}

#pragma mark - DownloadViewController's Methods

- (void)buscarDownloads {
    
}

- (IBAction)onButtonBuscarPressed:(UIButton *)sender {
    
    int selectedTipo = (int) self.txtFiltroTipo.selectedRow;
    NSString* filtro = self.txtFiltroNome.text;
    
    if (selectedTipo > -1 || ![filtro isEqualToString:@""]) {
        
        downloadGeneric = [DownloadGenericModel new];
        downloadGeneric.download = [DownloadModel new];
        downloadGeneric.download.tipo = [DownloadTipoModel new];
        if (selectedTipo > -1) {
            downloadGeneric.download.tipo = (DownloadTipoModel*) [self.tipoList objectAtIndex:selectedTipo];
        }
        downloadGeneric.download.arquivo = filtro;
        
        [diretorioServ filtrarDownloads:downloadGeneric];
        
    } else {
        
        downloadGeneric = [DownloadGenericModel new];
        
        [diretorioServ consultarDiretoriosDownloads:downloadGeneric];
    }
    
    [self.view endEditing:YES];
    [self hideSubMenu];
    
    self.lblDiretorioName.text = @".";
    [self.btnDiretorio setImage:[UIImage imageNamed:@"folder"] forState:UIControlStateNormal];
    self.btnDiretorio.tag = 0;
    
    // Show loading activity
    [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.downloadList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat sizeDefaulCell = 44;
    CGFloat sizeDefaultLabel = 20;
    CGFloat sizeDefaultBottomSpace = 10;
    
    if (self.cellArray.count > 0 && self.cellArray.count > indexPath.row) {
        
        DownloadTableViewCell *cell = (DownloadTableViewCell *) [self.cellArray valueForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row ]];
        UILabel* label = cell.lblArquivoNome;
        DownloadGenericModel* download = (DownloadGenericModel*) [self.downloadList objectAtIndex:indexPath.row];
        
        CGFloat height = 0;
        if (download.diretorio != nil) {
            height = [Utils heightForLabel:label withText:download.diretorio.nome];
        } else if (download.download != nil) {
            height = [Utils heightForLabel:label withText:download.download.titulo];
        }
        
        if (height > sizeDefaultLabel) {
            if (((int)height % (int)sizeDefaultLabel) == 0) {
                height = (height / sizeDefaultLabel) * sizeDefaultLabel;
            } else {
                height = ((height / sizeDefaultLabel) + 1) * sizeDefaultLabel;
            }
            
            return height + sizeDefaultBottomSpace;//label.frame.origin.y + height + sizeDefaultBottomSpace;
        } else {
            return sizeDefaulCell;
        }
    } else {
        
        return sizeDefaulCell;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_NOT_OS_8_OR_LATER) {
        [tableView beginUpdates];
    }
    
    DownloadTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:DownloadTableViewCellID forIndexPath:indexPath];
    
    // Configure the cell...
    
    DownloadGenericModel* download = (DownloadGenericModel*) [self.downloadList objectAtIndex:indexPath.row];
    
    if (download.diretorio != nil) {
        
        cell.imgIconeArquivo.image = [UIImage imageNamed:@"folder"];
        cell.lblArquivoNome.text = download.diretorio.nome;
        cell.lblArquivoData.text = @"";
    } else if (download.download != nil) {
        
        cell.imgIconeArquivo.image = [DownloadGenericModel obterIcone:download.download.arquivo];
        
        cell.lblArquivoNome.text = download.download.titulo;
        
        if (download.download.data.length > 10) {
            cell.lblArquivoData.text = [download.download.data substringWithRange:NSMakeRange(0, 10)];
        } else {
            cell.lblArquivoData.text = download.download.data;
        }
    }
    
    [self.cellArray setValue:cell forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row ]];
    
    if (IS_NOT_OS_8_OR_LATER) {
        [tableView endUpdates];
    }
    
    return cell;
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DownloadGenericModel* download = (DownloadGenericModel*) [self.downloadList objectAtIndex:indexPath.row];
    
    if (download.diretorio != nil) {
        
        NSMutableString* path = [NSMutableString new];
        [path appendString:self.lblDiretorioName.text];
        [path appendString:[NSString stringWithFormat:@"/%@",download.diretorio.nome ]];
        
        self.lblDiretorioName.text = path;
        [self.btnDiretorio setImage:[UIImage imageNamed:@"folder_back"] forState:UIControlStateNormal];
        self.btnDiretorio.tag = 1;
        
        [diretorioServ consultarDiretoriosDownloads:download];
        
        downloadGeneric = download;
        
    } else if (download.download != nil) {
        
        NSString* arquivo = [NSString stringWithFormat:@"%@%@", download.download.caminho, download.download.arquivo ];
        NSString* urlArquivo = [DownloadGenericModel getUrlBase:arquivo];
        NSLog(@"arq: %@", urlArquivo);
        
        
        NSRange range = [urlArquivo rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, urlArquivo.length)];
        if (range.length > 0) {
//            NSString* tipo = [urlArquivo substringFromIndex:range.location + 1];
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"document" ofType:tipo];
            
//            self.docFile=[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:urlArquivo]];
            
            if (self.docFile != nil) {
//                self.docFile.UTI = @"com.instagram.photo";
//                self.docFile.UTI = @"net.whatsapp.image";

                CGRect rect = CGRectMake(0 ,0 , 0, 0);
                [self.docFile presentOptionsMenuFromRect: rect inView: self.view animated: YES ];
            } else {
                NSLog(@"No Others Apps Found");
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                WebViewController* vc = [mainStoryboard instantiateViewControllerWithIdentifier:VCWebView];
                vc.url = urlArquivo;
        
                [self presentViewController:vc animated:YES completion:nil];
            }
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)onButtonDiretorioBackPressed:(UIButton *)sender {
    if (sender.tag == 1) {
        
        NSString *path= self.lblDiretorioName.text;
        NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch range:NSMakeRange(0, path.length)];
        self.lblDiretorioName.text = [path substringToIndex:range.location];
        
        if ([self.lblDiretorioName.text isEqualToString:@"."]) {
            [self.btnDiretorio setImage:[UIImage imageNamed:@"folder"] forState:UIControlStateNormal];
            self.btnDiretorio.tag = 0;
        }
        
        DownloadGenericModel* download = [DownloadGenericModel new];
        download.diretorio = downloadGeneric.diretorio.diretorioArqVOPai;
        
        [diretorioServ consultarDiretoriosDownloads:download];
        
        downloadGeneric = download;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - IQDropDownTextFieldDelegate

- (void)textField:(IQDropDownTextField *)textField didSelectItem:(NSString *)item {
    //    NSLog(@"%@",item);
}

#pragma mark - BaseServiceDelegate

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    NSLog(@"Service Delegate error: %@", error);
    NSLog(@"Service Delegate method: %@", method);
    
    self.isQuerying = NO;
}

#pragma mark DiretorioArqServiceDelegate

- (void) consultarDiretoriosDownloadsResult:(NSMutableArray*) listResult {
    
    self.downloadList = [NSMutableArray new];
    self.downloadList = listResult;
    
    [self.tableView reloadData];
    
    self.isQuerying = NO;
    
    // Hide loading activity
    [self.navigationController.view hideActivityView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
