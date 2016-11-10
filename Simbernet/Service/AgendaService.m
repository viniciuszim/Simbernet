//
//  AgendaService.m
//  Simbernet
//
//  Created by Marcio Pinto on 28/06/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import "AgendaModel.h"
#import "AgendaList.h"
#import "AgendaService.h"

@implementation AgendaService

#pragma mark List Compromissos Mobile

- (void) listCompromissosMobile:(NSString*)data
                           user:(Usuario*)usuario
                           acao:(NSString*)acao
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"AgendaService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        AgendaModel *agenda = [AgendaModel new];
        agenda.acao = acao;
        agenda.data = data;
        agenda.usuario = usuario;
        
        [HttpRequest sendRequestForController:HTTP_AgendaURL
                                   WithValues:[agenda objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listCompromissosMobileResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in AgendaService" onMethod:@"- (void) listCompromissosMobile" withRequest:nil];
        return;
    }
}

-(void)listCompromissosMobileResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listCompromissosMobileResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<AgendaServiceDelegate>)self.delegate listCompromissosReturns:nil];
                    return;
                }

                AgendaList *agendaList = (AgendaList *)[AgendaList objectForJSON:data];
                
                [(id<AgendaServiceDelegate>)self.delegate listCompromissosReturns:agendaList.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listCompromissosMobileResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listCompromissosMobileResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Obter Compromissos de um dia

- (void) obterCompromissosDiaMobile:(NSString*)data
                               user:(Usuario*)usuario
                               acao:(NSString*)acao
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"AgendaService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        AgendaModel *agenda = [AgendaModel new];
        agenda.acao = acao;
        agenda.data = data;
        agenda.usuario = usuario;
        
        [HttpRequest sendRequestForController:HTTP_AgendaURL
                                   WithValues:[agenda objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(obterCompromissosDiaMobileResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in AgendaService" onMethod:@"- (void) obterCompromissosDiaMobile" withRequest:nil];
        return;
    }
}

-(void)obterCompromissosDiaMobileResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)obterCompromissosDiaMobileResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<AgendaServiceDelegate>)self.delegate obterCompromissosDiaReturns:nil];
                    return;
                }
                
                AgendaList *agendaList = (AgendaList *)[AgendaList objectForJSON:data];
                
                [(id<AgendaServiceDelegate>)self.delegate obterCompromissosDiaReturns:agendaList.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)obterCompromissosDiaMobileResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)obterCompromissosDiaMobileResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
