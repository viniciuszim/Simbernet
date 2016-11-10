//
//  EventoVisualizarViewController.m
//  Simbernet
//
//  Created by Vinicius Miguel on 09/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "EventoVisualizarViewController.h"

@implementation EventoVisualizarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Evento"];
    
    self.lblName.text = self.evento.titulo;
    self.lblDate.text = [EventoModel getFullHour:self.evento];
    [self.webViewDescription loadHTMLString:[self.evento.texto description] baseURL:nil];
    
}

@end
