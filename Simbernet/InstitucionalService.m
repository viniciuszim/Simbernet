//
//  InstitucionalService.m
//  Simbernet
//
//  Created by Marcio Pinto on 22/03/15.
//  Copyright (c) 2015 in6. All rights reserved.
//

#import "InstitucionalService.h"
#import "InstitucionalModel.h"
#import "InstitucionalList.h"

@implementation InstitucionalService

#pragma mark Obter Institucional

- (void)obterPorChave:(NSString*) chave
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"InstitucionalService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        InstitucionalModel *institucional = [InstitucionalModel new];
        institucional.acao = @"obterPorchave";
        institucional.chave = chave;
        
        [HttpRequest sendRequestForController:HTTP_InstitucionalURL
                                   WithValues:[institucional objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(obterPorChaveResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in InstitucionalService" onMethod:@"- (void)obterPorChave" withRequest:nil];
        return;
    }
}

-(void)obterPorChaveResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)obterPorChaveResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<InstitucionalServiceDelegate>)self.delegate obterPorChaveReturn:nil success:NO];
                    return;
                }
                
                InstitucionalModel *institucionalModel = (InstitucionalModel *)[InstitucionalModel objectForJSON:data];
                
                if (institucionalModel != nil && institucionalModel.codigo != 0) {
                    
                    NSString* inst = [NSString stringWithFormat:@"%@_%@", UserDefaults_Institucional, institucionalModel.chave];
                    
                    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:[institucionalModel objectToJson] forKey:inst];
                    [userDefaults synchronize];
                }
                
                [(id<InstitucionalServiceDelegate>)self.delegate obterPorChaveReturn:institucionalModel success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)obterPorChaveResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)obterPorChaveResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark List Institucionais Mobile

- (void) listInstitucionaisMobile:(int) pagina
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"InstitucionalService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        InstitucionalModel *institucional = [InstitucionalModel new];
        institucional.acao = @"listarMobile";
        institucional.pagina = pagina;
        
        [HttpRequest sendRequestForController:HTTP_InstitucionalURL
                                   WithValues:[institucional objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listInstitucionaisMobileResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in InstitucionalService" onMethod:@"- (void) listInstitucionaisMobile" withRequest:nil];
        return;
    }
}

-(void)listInstitucionaisMobileResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listInstitucionaisMobileResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id)self.delegate listInstitucionaisMobileReturns:nil];
                    return;
                }
                
                InstitucionalList *list = (InstitucionalList *)[InstitucionalList objectForJSON:data];
                
                [(id)self.delegate listInstitucionaisMobileReturns:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listInstitucionaisMobileResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listInstitucionaisMobileResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
