//
//  EventoService.m
//  Simbernet
//
//  Created by Vinicius Miguel on 08/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "EventoService.h"
#import "EventoModel.h"
#import "EventoList.h"

@implementation EventoService

#pragma mark - List Eventos

- (void) listEventos:(int) pagina
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"EventoService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        EventoModel* evento = [EventoModel new];
        evento.acao = @"listar";
        evento.pagina = pagina;
        
        [HttpRequest sendRequestForController:HTTP_EventoURL
                                   WithValues:[evento objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listEventosResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in EventoService" onMethod:@"- (void) listEventos" withRequest:nil];
        return;
    }
}

-(void)listEventosResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listEventosResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<EventoServiceDelegate>)self.delegate listEventosReturns:nil];
                    return;
                }
                
                EventoList *list = (EventoList *)[EventoList objectForJSON:data];
                
                [(id<EventoServiceDelegate>)self.delegate listEventosReturns:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listEventosResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listEventosResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
