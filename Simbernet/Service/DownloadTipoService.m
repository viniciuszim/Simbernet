//
//  DownloadTipoService.m
//  Simbernet
//
//  Created by Vinicius Miguel on 17/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "DownloadTipoService.h"
#import "DownloadTipoModel.h"
#import "DownloadTipoList.h"

@implementation DownloadTipoService

#pragma mark List Tipos Downloads

- (void) consultarTiposDownloads
{
    //Verify if delegate is present **** MANDATORY ****
//    if(self.delegate == nil) {
//        [[[ITException alloc] initWithName:@"DownloadTipoService" reason:@"Delegate is null" userInfo:nil] raise];
//        return;
//    }
    
    @try {
        
        DownloadTipoModel* tipo = [DownloadTipoModel new];
        tipo.acao = @"listarTipos";
        
        [HttpRequest sendRequestForController:HTTP_DownloadTipoURL
                                   WithValues:[tipo objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(consultarTiposDownloadsResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in DiretorioArqService" onMethod:@"- (void) consultarTiposDownloads" withRequest:nil];
        return;
    }
}

-(void)consultarTiposDownloadsResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)consultarTiposDownloadsResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<DownloadTipoServiceDelegate>)self.delegate consultarTiposDownloadsResult:nil];
                    return;
                }
                
                DownloadTipoList* list = (DownloadTipoList *)[DownloadTipoList objectForJSON:data];
                
                [DownloadTipoModel setTiposDownload:list.lista];
                
                [(id<DownloadTipoServiceDelegate>)self.delegate consultarTiposDownloadsResult:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarTiposDownloadsResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarTiposDownloadsResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
