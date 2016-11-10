//
//  InstitucionalListViewController.m
//  Simbernet
//
//  Created by Vinicius Miguel on 26/10/15.
//  Copyright © 2015 Simber. All rights reserved.
//

#import "InstitucionalListViewController.h"
#import "InstitucionalService.h"
#import "InstitucionalViewController.h"

@implementation InstitucionalListViewCell
@end

@interface InstitucionalListViewController () <InstitucionalServiceDelegate> {
    NSMutableArray *institucionalLista;
    NSMutableArray *paginas;
    NSNumber* pagina;
    BOOL carregou;
}
@end

@implementation InstitucionalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    institucionalLista = [NSMutableArray new];
    
    [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
    
    pagina = [NSNumber numberWithInt:1];
    [self launchReload];

    [self setTitle:@"Institucional"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)launchReload {
    
    InstitucionalService* instServ = [InstitucionalService new];
    instServ.delegate = self;
    [instServ listInstitucionaisMobile:pagina.intValue];
    
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [institucionalLista count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *simpleTableIdentifier = @"InstitucionalListViewCellID";
    
    InstitucionalListViewCell *cell = (InstitucionalListViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    // Configure the cell...

    if (indexPath.row == [institucionalLista count] - 10)
    {
        int value = [pagina intValue];
        pagina = [NSNumber numberWithInt:value + 1];
        
        [self launchReload];
    }
    
    InstitucionalModel *institucional = (InstitucionalModel *) [institucionalLista objectAtIndex:indexPath.row];
    
    cell.lblTitle.text = institucional.titulo;
//    cell.lblDescription.text = institucional.resumo;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstitucionalModel *institucional = (InstitucionalModel *) [institucionalLista objectAtIndex:indexPath.row];
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    InstitucionalViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InstitucionalViewController"];
    vc.chave = institucional.chave;
    vc.titulo = institucional.titulo;
    vc.backButton = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - InstitucionalServiceDelegate

- (void) listInstitucionaisMobileReturns:(NSArray*) institucionaisList {
    if ([institucionalLista count] == 0) {
        institucionalLista = [NSMutableArray arrayWithArray:institucionaisList];
    } else {
        [institucionalLista addObjectsFromArray: institucionaisList];
    }
    
    carregou = YES;
    
    // Esconde loading activity
    [self.navigationController.view hideActivityView];
    
    [self.tableView reloadData];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    
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
