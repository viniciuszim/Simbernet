//
//  NoticiaService.m
//  Simbernet
//
//  Created by Marcio Pinto on 23/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "NoticiaService.h"
#import "NoticiaList.h"
#import "ComentarioList.h"

@implementation NoticiaService

#pragma mark List Noticias
- (void) listNoticias:(int) pagina
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"NoticiaService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        Noticia* noticia = [Noticia new];
        noticia.acao = @"listar";
        noticia.pagina = pagina;
        
        [HttpRequest sendRequestForController:HTTP_NoticiaURL
                                   WithValues:[noticia objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listNoticiasResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Noticia" onMethod:@"- (void) listNoticias" withRequest:nil];
        return;
    }
}

-(void)listNoticiasResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listNoticiasResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;

                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<NoticiaServiceDelegate>)self.delegate listNoticiasReturns:nil];
                    return;
                }
                
                NoticiaList *noticiaList = (NoticiaList *)[NoticiaList objectForJSON:data];
                
                [(id<NoticiaServiceDelegate>)self.delegate listNoticiasReturns:noticiaList.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listNoticiasResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listNoticiasResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark List Comentarios
- (void) listComentarios:(long)codigo
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"NoticiaService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        Comentario* comentario = [Comentario new];
        comentario.acao = @"listar";
        comentario.codigoNoticia = codigo;
        
        [HttpRequest sendRequestForController:HTTP_ComentarioURL
                                   WithValues:[comentario objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listComentariosResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Comentario" onMethod:@"- (void) listComentarios" withRequest:nil];
        return;
    }
}

-(void)listComentariosResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listComentariosResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<NoticiaServiceDelegate>)self.delegate listComentariosReturns:nil];
                    return;
                }
                
                ComentarioList *comentarioList = (ComentarioList *)[ComentarioList objectForJSON:data];
                
                [(id<NoticiaServiceDelegate>)self.delegate listComentariosReturns:comentarioList.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listComentariosResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listComentariosResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Adicionar Comentario
- (void) inserirComentario:(Comentario*)comentario
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"NoticiaService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        Comentario* obj = comentario;
        obj.acao = @"inserir";
        
        [HttpRequest sendRequestForController:HTTP_ComentarioURL
                                   WithValues:[obj objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(inserirComentarioResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in inserir comentario" onMethod:@"- (void) inserirComentario" withRequest:nil];
        return;
    }
}

-(void)inserirComentarioResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)inserirComentarioResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<NoticiaServiceDelegate>)self.delegate inserirComentarioReturns:nil success:NO];
                    return;
                }
                
                Comentario *comentario = (Comentario *)[Comentario objectForJSON:data];
                
                [(id<NoticiaServiceDelegate>)self.delegate inserirComentarioReturns:comentario success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirComentarioResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirComentarioResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Apagar Comentario
- (void) apagarComentario:(long)codigo
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"NoticiaService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        Comentario* obj = [Comentario new];
        obj.acao = @"apagar";
        obj.codigo = codigo;

        [HttpRequest sendRequestForController:HTTP_ComentarioURL
                                   WithValues:[obj objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(apagarComentarioResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in apagar comentario" onMethod:@"- (void) apagarComentario" withRequest:nil];
        return;
    }
}

-(void)apagarComentarioResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)apagarComentarioResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;

                if (data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<NoticiaServiceDelegate>)self.delegate apagarComentarioReturns:nil success:NO];
                    return;
                }

                Comentario *comentario = (Comentario *)[Comentario objectForJSON:data];
                
                [(id<NoticiaServiceDelegate>)self.delegate apagarComentarioReturns:comentario success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)apagarComentarioResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)apagarComentarioResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
