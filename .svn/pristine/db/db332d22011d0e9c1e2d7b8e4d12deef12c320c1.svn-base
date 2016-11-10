//
//  AniversarianteListViewController.m
//  Simbernet
//
//  Created by Vinicius Miguel on 12/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "AniversarianteListViewController.h"
#import "Usuario.h"
#import "UsuarioService.h"

@implementation AniversarianteTableViewCell

@end

@interface AniversarianteListViewController ()<UserServiceDelegate> {

    UsuarioService* userServ;
    
}

// Outlets
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *emptyView;

@property (strong, nonatomic) IBOutlet UIButton *btnDia;
@property (strong, nonatomic) IBOutlet UIButton *btnSemana;
@property (strong, nonatomic) IBOutlet UIButton *btnMes;

// Variables
@property (strong, nonatomic) NSMutableArray* aniversariantesList;
@property (nonatomic) BOOL isQuerying;

@end

@implementation AniversarianteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // === Setting delegates
    
    userServ = [UsuarioService new];
    userServ.delegate = self;
    
    // ========================================================
    
    self.aniversariantesList = [NSMutableArray new];
    
    [self onAniversariantesDoMesButtonPressed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Class Methods

- (IBAction)onAniversariantesDoDiaButtonPressed:(UIButton*)sender {
    
    if (!self.isQuerying) {
        
        [self.btnSemana setSelected:NO];
        [self.btnMes setSelected:NO];
        [self.btnDia setSelected:YES];
        
        self.isQuerying = YES;
        
        // Show loading activity
        [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
        
        self.isQuerying = YES;
        [userServ consultarAniversariantes:1];
    }
}

- (IBAction)onAniversariantesDaSemanaButtonPressed:(UIButton*)sender {
    
    if (!self.isQuerying) {
        
        [self.btnDia setSelected:NO];
        [self.btnMes setSelected:NO];
        [self.btnSemana setSelected:YES];
        
        self.isQuerying = YES;
        
        // Show loading activity
        [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
        
        self.isQuerying = YES;
        [userServ consultarAniversariantes:2];
    }
}

- (IBAction)onAniversariantesDoMesButtonPressed:(UIButton*)sender {
    
    if (!self.isQuerying) {
        
        [self.btnDia setSelected:NO];
        [self.btnSemana setSelected:NO];
        [self.btnMes setSelected:YES];
        
        self.isQuerying = YES;
        
        // Show loading activity
        [self.navigationController.view showActivityViewWithLabel:@"Carregando"];
        
        self.isQuerying = YES;
        [userServ consultarAniversariantes:3];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.aniversariantesList.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString* reuseIdentifier = AniversarianteTableViewCellID;
     AniversarianteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
     
     // Configure the cell...
     
     Usuario* user = [self.aniversariantesList objectAtIndex:indexPath.row ];
     
     if (user.dataNascimento != nil && ![user.dataNascimento isEqualToString:@""]) {
         cell.lblDate.hidden = NO;
         cell.lblDate.text = [user.dataNascimento substringToIndex:5];
     } else {
         cell.lblDate.hidden = YES;
     }
     cell.lblName.text = user.nome;
     
     return cell;
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

#pragma mark - BaseServiceDelegate

- (void)error:(NSString *)error onMethod:(NSString *)method withRequest:(HttpRequest *)request {
    NSLog(@"Service Delegate error: %@", error);
    NSLog(@"Service Delegate method: %@", method);
    
    self.isQuerying = NO;
}

#pragma mark UserServiceDelegate

- (void) listAniversariantesReturns:(NSMutableArray*) aniversariantesList {
    
    self.aniversariantesList = aniversariantesList;
    
    [self.tableView reloadData];
    
    self.isQuerying = NO;
    
    // Hide loading activity
    [self.navigationController.view hideActivityView];
    
    if (aniversariantesList == nil || aniversariantesList.count == 0) {
        [self.view bringSubviewToFront:self.emptyView];
    } else {
        [self.view bringSubviewToFront:self.tableView];
    }
    
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
