//
//  AgendaService.h
//  Simbernet
//
//  Created by Marcio Pinto on 28/06/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import "BaseService.h"
#import "AgendaModel.h"

@protocol AgendaServiceDelegate <BaseServiceDelegate>

@optional

- (void) listCompromissosReturns:(NSArray*) compromissosList;
- (void) obterCompromissosDiaReturns:(NSArray*) compromissosList;

@end

@interface AgendaService : BaseService

- (void) listCompromissosMobile:(NSString*)data
                           user:(Usuario*)usuario
                           acao:(NSString*) acao;
- (void) obterCompromissosDiaMobile:(NSString*)data
                               user:(Usuario*)usuario
                               acao:(NSString*) acao;

@end
