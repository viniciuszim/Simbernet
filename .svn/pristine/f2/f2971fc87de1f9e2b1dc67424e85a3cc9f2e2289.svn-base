//
//  UserService.m
//  ProconGoias
//
//  Created by Rafael Paiva Silva on 11/16/14.
//  Copyright (c) 2014 in6. All rights reserved.
//

#import "UsuarioService.h"
#import "UsuarioList.h"

@implementation UsuarioService

#pragma mark Login

- (void) loginWith:(Usuario*)usuario
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"UsuarioService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    //Method verification
    if (usuario == nil || usuario.login == nil || usuario.senha == nil) {
        [self.delegate error:@"ExceptionModel is null" onMethod:@"- (void) loginWith:(Usuario*)usuario" withRequest:nil];
        return;
    }
    
    @try {
        Usuario* usu = [Usuario new];
        usu.login = usuario.login;
        usu.senha = usuario.senha;
        usu.deviceToken = usuario.deviceToken;
        usu.acao = @"login";
        
        [HttpRequest sendRequestForController:HTTP_LoginURL
                                   WithValues:[usu objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(loginResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Usuario" onMethod:@"- (void) loginWith:(Usuario*)usuario" withRequest:nil];
        return;
    }
}

-(void)loginResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)loginResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                NSLog(@"DATA: %@", data);
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<UserServiceDelegate>)self.delegate userServiceDidLogin:nil success:NO];
                    return;
                }

                Usuario *usuario = (Usuario *)[Usuario objectForJSON:data];
                
                [(id<UserServiceDelegate>)self.delegate userServiceDidLogin:usuario success:YES];

            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)loginResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)loginResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Aniversariantes

- (void) consultarAniversariantes:(int)tipoPeriodo
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"UsuarioService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        Usuario* usu = [Usuario new];
        // 1 - Usuário do marxnet.
        // 2 - Usuário do marxnet bloqueado.
        // 3 - Contato genérico.
        usu.status = 1;
        
        if (tipoPeriodo == 1) {
            usu.acao = @"listarAniversariantesDoDia";
        } else if (tipoPeriodo == 2) {
            usu.acao = @"listarAniversariantesDaSemana";
        } else if (tipoPeriodo == 3) {
            usu.acao = @"listarAniversariantesDoMes";
        }
        
        [HttpRequest sendRequestForController:HTTP_UserAniversarianteURL
                                   WithValues:[usu objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(consultarAniversariantesResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Usuario" onMethod:@"- (void) loginWith:(Usuario*)usuario" withRequest:nil];
        return;
    }
}

-(void)consultarAniversariantesResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)consultarAniversariantesResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<UserServiceDelegate>)self.delegate userServiceDidLogin:nil success:NO];
                    return;
                }
                                
                UsuarioList* list = (UsuarioList *)[UsuarioList objectForJSON:data];
                
                [(id<UserServiceDelegate>)self.delegate listAniversariantesReturns:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarAniversariantesResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarAniversariantesResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Atualizar Token Device

- (void) atualizarDeviceToken:(Usuario*)usuario
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"UsuarioService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    //Method verification
    if (usuario == nil || usuario.login == nil || usuario.senha == nil) {
        [self.delegate error:@"ExceptionModel is null" onMethod:@"- (void) atualizarDeviceToken:(Usuario*)usuario" withRequest:nil];
        return;
    }
    
    @try {
        usuario.acao = @"atualizarIOSToken";
        
        [HttpRequest sendRequestForController:HTTP_LoginURL
                                   WithValues:[usuario objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(atualizarDeviceTokenResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Usuario" onMethod:@"- (void) atualizarDeviceToken:(Usuario*)usuario" withRequest:nil];
        return;
    }
}

-(void)atualizarDeviceTokenResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)atualizarDeviceTokenResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                NSLog(@"DATA: %@", data);
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<UserServiceDelegate>)self.delegate atualizarDeviceTokenReturn:nil success:NO];
                    return;
                }
                
                Usuario *usuario = (Usuario *)[Usuario objectForJSON:data];
                
                [(id<UserServiceDelegate>)self.delegate atualizarDeviceTokenReturn:usuario success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)atualizarDeviceTokenResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)atualizarDeviceTokenResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
