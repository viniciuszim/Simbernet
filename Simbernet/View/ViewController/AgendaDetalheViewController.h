//
//  AgendaDetalheViewController.h
//  Simbernet
//
//  Created by Marcio Pinto on 05/07/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "AgendaModel.h"

@interface AgendaDetalheViewController : UIViewController <SlideNavigationControllerDelegate>

@property (nonatomic, strong) AgendaModel *agenda;
@property (strong, nonatomic) IBOutlet UILabel *tituloAgenda;
@property (strong, nonatomic) IBOutlet UILabel *objetivoAgenda;
@property (strong, nonatomic) IBOutlet UILabel *horarioAgenda;
@property (strong, nonatomic) IBOutlet UILabel *tipoAgenda;
@property (strong, nonatomic) IBOutlet UILabel *criadorAgenda;

@end
