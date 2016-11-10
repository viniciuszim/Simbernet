//
//  EventoVisualizarViewController.h
//  Simbernet
//
//  Created by Vinicius Miguel on 09/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseViewController.h"
#import "EventoModel.h"

@interface EventoVisualizarViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIWebView *webViewDescription;

@property (weak, nonatomic) EventoModel* evento;

@end
