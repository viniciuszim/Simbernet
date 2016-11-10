//
//  ForumService.m
//  Simbernet
//
//  Created by Marcio Pinto on 11/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "ForumService.h"
#import "ForumModel.h"
#import "ForumList.h"
#import "ForumHistoricoList.h"

@implementation ForumService

#pragma mark - List Foruns

- (void) listForuns:(int) pagina
            usuario:(long) codigo
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"ForumService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        ForumModel* forum = [ForumModel new];
        forum.acao = @"listar";
        forum.pagina = pagina;
        forum.usuarioLogado = codigo;
        
        [HttpRequest sendRequestForController:HTTP_ForumURL
                                   WithValues:[forum objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listForunsResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in ForumService" onMethod:@"- (void) listForuns" withRequest:nil];
        return;
    }
}

-(void)listForunsResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listForunsResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if (data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]) {
                    [(id<ForumServiceDelegate>)self.delegate listForunsReturns:nil];
                    return;
                }
                
                ForumList *list = (ForumList *)[ForumList objectForJSON:data];
                
                [(id<ForumServiceDelegate>)self.delegate listForunsReturns:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listForunsResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listForunsResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark List Historico
- (void) listHistorico:(long)codigo
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"ForumService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        ForumHistoricoModel* historico = [ForumHistoricoModel new];
        historico.acao = @"listar";
        historico.codigoTopico = codigo;
        
        [HttpRequest sendRequestForController:HTTP_ForumHistoricoURL
                                   WithValues:[historico objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listHistoricoResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in ForumHistorico" onMethod:@"- (void) listForumHistorico" withRequest:nil];
        return;
    }
}

-(void)listHistoricoResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listHistoricoResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<ForumServiceDelegate>)self.delegate listHistoricoReturns:nil];
                    return;
                }
                
                ForumHistoricoList *historicoList = (ForumHistoricoList *)[ForumHistoricoList objectForJSON:data];
                
                [(id<ForumServiceDelegate>)self.delegate listHistoricoReturns:historicoList.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listHistoricoResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listHistoricoResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Adicionar Historico
- (void) inserirHistorico:(ForumHistoricoModel*)historico
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"ForumService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        ForumHistoricoModel* obj = historico;
        obj.acao = @"inserir";
        
        [HttpRequest sendRequestForController:HTTP_ForumHistoricoURL
                                   WithValues:[obj objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(inserirHistoricoResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in inserir comentario" onMethod:@"- (void) inserirHistorico" withRequest:nil];
        return;
    }
}

-(void)inserirHistoricoResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)inserirHistoricoResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<ForumServiceDelegate>)self.delegate inserirHistoricoReturns:nil success:NO];
                    return;
                }
                
                ForumHistoricoModel *historico = (ForumHistoricoModel *)[ForumHistoricoModel objectForJSON:data];
                
                [(id<ForumServiceDelegate>)self.delegate inserirHistoricoReturns:historico success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirHistoricoResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirHistoricoResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Apagar Historico
- (void) apagarHistorico:(long)codigo
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"HistoricoService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        ForumHistoricoModel* obj = [ForumHistoricoModel new];
        obj.acao = @"apagar";
        obj.codigo = codigo;
        
        [HttpRequest sendRequestForController:HTTP_ForumHistoricoURL
                                   WithValues:[obj objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(apagarHistoricoResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in apagar historico" onMethod:@"- (void) apagarHistorico" withRequest:nil];
        return;
    }
}

-(void)apagarHistoricoResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)apagarHistoricoResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;

                if (data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<ForumServiceDelegate>)self.delegate apagarHistoricoReturns:nil success:NO];
                    return;
                }

                ForumHistoricoModel *historico = (ForumHistoricoModel *)[ForumHistoricoModel objectForJSON:data];

                [(id<ForumServiceDelegate>)self.delegate apagarHistoricoReturns:historico success:YES];

            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)apagarHistoricoResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)apagarHistoricoResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Alterar notificacao topico usuario logado
- (void) alterarNotificacaoTopico:(ForumModel*)topico
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"ForumService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        ForumModel* forum = topico;
        forum.acao = @"alterarNotificacaoTopico";
        
        [HttpRequest sendRequestForController:HTTP_ForumURL
                                   WithValues:[forum objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(alterarNotificacaoTopicoResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in alterar notificacao" onMethod:@"- (void) alterarNotificacaoTopico" withRequest:nil];
        return;
    }
}

-(void)alterarNotificacaoTopicoResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)alterarNotificacaoTopicoResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if (data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]) {
                    [(id<ForumServiceDelegate>)self.delegate alterarNotificacaoTopicoReturns:nil success:NO];
                    return;
                }
                
                ForumModel *forum = (ForumModel *)[ForumModel objectForJSON:data];
                
                [(id<ForumServiceDelegate>)self.delegate alterarNotificacaoTopicoReturns:forum success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)alterarNotificacaoTopicoResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)alterarNotificacaoTopicoResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Alterar email notificacao topico usuario logado
- (void) alterarEmailNotificacaoTopico:(ForumModel*)topico
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"ForumService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        ForumModel* forum = topico;
        forum.acao = @"alterarEmailTopico";
        
        [HttpRequest sendRequestForController:HTTP_ForumURL
                                   WithValues:[forum objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(alterarEmailNotificacaoTopicoResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in alterar email notificacao" onMethod:@"- (void) alterarEmailNotificacaoTopico" withRequest:nil];
        return;
    }
}

-(void)alterarEmailNotificacaoTopicoResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)alterarEmailNotificacaoTopicoResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if (data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]) {
                    [(id<ForumServiceDelegate>)self.delegate alterarEmailNotificacaoTopicoReturns:nil success:NO];
                    return;
                }
                
                ForumModel *forum = (ForumModel *)[ForumModel objectForJSON:data];
                
                [(id<ForumServiceDelegate>)self.delegate alterarEmailNotificacaoTopicoReturns:forum success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)alterarEmailNotificacaoTopicoResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)alterarEmailNotificacaoTopicoResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
