//
//  AgendaDetalheViewController.m
//  Simbernet
//
//  Created by Marcio Pinto on 05/07/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import "AgendaDetalheViewController.h"

@interface AgendaDetalheViewController ()

@end

@implementation AgendaDetalheViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.agenda) {
        // Seto a data escolhida no calendário
        [self setTitle:self.agenda.data];
    
        // TITULO
        self.tituloAgenda.text = self.agenda.titulo;

        // OBJETIVO
        self.objetivoAgenda.text = self.agenda.descricao;

        // TIPO
        self.tipoAgenda.text = self.agenda.tipo;

        // HORARIO
        self.horarioAgenda.text = self.agenda.horaString;

        // CRIADOR
        if (self.agenda.criador) {
            self.criadorAgenda.text = self.agenda.criador.nome;
        } else if (self.agenda.usuario) {
            self.criadorAgenda.text = self.agenda.usuario.nome;
        }
    }
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
