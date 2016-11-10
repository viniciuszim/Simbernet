//
//  DiretorioArqService.m
//  Simbernet
//
//  Created by Vinicius Miguel on 15/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "DiretorioArqService.h"
#import "DownloadGenericModel.h"
#import "DownloadModel.h"
#import "DiretorioArqModel.h"
#import "DownloadGenericList.h"

@implementation DiretorioArqService

#pragma mark List Diretorios

- (void) consultarDiretoriosDownloads:(DownloadGenericModel *)downloadGeneric
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"DiretorioArqService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }

    @try {
        
        if (downloadGeneric.diretorio == nil) {
            downloadGeneric.diretorio = [DiretorioArqModel new];
        }
        if (downloadGeneric.download == nil) {
            downloadGeneric.download = [DownloadModel new];
        }
        
        downloadGeneric.acao = @"listarIntranet";
        downloadGeneric.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_DownloadURL
                                   WithValues:[downloadGeneric objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(consultarDiretoriosDownloadsResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in DiretorioArqService" onMethod:@"- (void) consultarDiretoriosDownloads" withRequest:nil];
        return;
    }
}

- (void) filtrarDownloads:(DownloadGenericModel *)downloadGeneric
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"DiretorioArqService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        if (downloadGeneric.diretorio == nil) {
            downloadGeneric.diretorio = [DiretorioArqModel new];
        }
        if (downloadGeneric.download == nil) {
            downloadGeneric.download = [DownloadModel new];
        }
        
        downloadGeneric.acao = @"listarPorTipo";
        downloadGeneric.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_DownloadURL
                                   WithValues:[downloadGeneric objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(consultarDiretoriosDownloadsResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in DiretorioArqService" onMethod:@"- (void) consultarDiretoriosDownloads" withRequest:nil];
        return;
    }
}

-(void)consultarDiretoriosDownloadsResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)consultarDiretoriosDownloadsResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<DiretorioArqServiceDelegate>)self.delegate consultarDiretoriosDownloadsResult:nil];
                    return;
                }
                
                DownloadGenericList* list = (DownloadGenericList *)[DownloadGenericList objectForJSON:data];
                
                [(id<DiretorioArqServiceDelegate>)self.delegate consultarDiretoriosDownloadsResult:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarDiretoriosDownloadsResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarDiretoriosDownloadsResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
