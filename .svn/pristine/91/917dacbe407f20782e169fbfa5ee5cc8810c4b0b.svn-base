//
//  CategoriaService.m
//  Simbernet
//
//  Created by Vinicius Miguel on 24/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "CategoriaService.h"
#import "CategoriaModel.h"
#import "CategoriaList.h"

@implementation CategoriaService

#pragma mark listar todas as Categorias

- (void)listarTodasCategorias
{
    //Verify if delegate is present **** MANDATORY ****
//    if(self.delegate == nil) {
//        [[[ITException alloc] initWithName:@"CategoriaService" reason:@"Delegate is null" userInfo:nil] raise];
//        return;
//    }
    
    @try {
        
        CategoriaModel *categoria = [CategoriaModel new];
        categoria.acao = @"listar";
        
        [HttpRequest sendRequestForController:HTTP_TwitterCategoriaURL
                                   WithValues:[categoria objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(listarTodasCategoriasResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in CategoriaService" onMethod:@"- (void)listarTodasCategorias" withRequest:nil];
        return;
    }
}

-(void)listarTodasCategoriasResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)listarTodasCategoriasResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                
                NSString *data = response.responseData;
                
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<CategoriaServiceDelegate>)self.delegate listCategoriasReturns:nil success:NO];
                    return;
                }
                
                CategoriaList *list = (CategoriaList *)[CategoriaList objectForJSON:data];
                
                [CategoriaModel setCategoriasTwitter:list.lista];
                
                [(id<CategoriaServiceDelegate>)self.delegate listCategoriasReturns:list.lista success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listarTodasCategoriasResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)listarTodasCategoriasResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
