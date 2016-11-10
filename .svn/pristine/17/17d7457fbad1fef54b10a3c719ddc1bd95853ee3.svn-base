//
//  ForumService.h
//  Simbernet
//
//  Created by Marcio Pinto on 11/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseService.h"
#import "ForumModel.h"
#import "ForumHistoricoModel.h"

@protocol ForumServiceDelegate <BaseServiceDelegate>

@optional
- (void) listForunsReturns:(NSArray*) forunsList;
- (void) listHistoricoReturns:(NSArray*) historicoList;
- (void) inserirHistoricoReturns:(ForumHistoricoModel*)historico success:(BOOL)success;
- (void) apagarHistoricoReturns:(ForumHistoricoModel*)historico success:(BOOL)success;
- (void) alterarNotificacaoTopicoReturns:(ForumModel*)forum success:(BOOL)success;
- (void) alterarEmailNotificacaoTopicoReturns:(ForumModel*)forum success:(BOOL)success;
@end

@interface ForumService : BaseService

- (void) listForuns:(int) pagina usuario:(long) codigo;
- (void) listHistorico:(long)codigo;
- (void) inserirHistorico:(ForumHistoricoModel*)historico;
- (void) apagarHistorico:(long)codigo;
- (void) alterarNotificacaoTopico:(ForumModel*)topico;
- (void) alterarEmailNotificacaoTopico:(ForumModel*)topico;

@end
