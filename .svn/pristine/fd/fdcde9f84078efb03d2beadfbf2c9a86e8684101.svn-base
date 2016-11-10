//
//  TweetService.m
//  Simbernet
//
//  Created by Vinicius Miguel on 19/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "TweetService.h"
#import "Tweet2.h"
#import "TweetList.h"
#import "Usuario.h"

@implementation TweetService

#pragma mark List Tweets Recentes

- (void) consultarTweetsRecentes
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"TweetService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        Tweet2* tweet = [Tweet2 new];
        tweet.acao = @"consultarTweetsRecentes";
        tweet.dataPostagem = [Tweet2 getDataMaisRecente];
        tweet.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_TwitterURL
                                   WithValues:[tweet objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(consultarTweetsRecentesResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in TweetService" onMethod:@"- (void) consultarTweetsRecentes" withRequest:nil];
        return;
    }
}

-(void)consultarTweetsRecentesResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)consultarTweetsRecentesResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<TweetServiceDelegate>)self.delegate consultarTweetsRecentesResult:nil];
                    return;
                }
                
                TweetList* list = (TweetList *)[TweetList objectForJSON:data];
                
                [Tweet2 setUltimosTweets:list.lista setInicio:YES];
                
                [(id<TweetServiceDelegate>)self.delegate consultarTweetsRecentesResult:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarTweetsRecentesResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarTweetsRecentesResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark List Tweets Antigos

- (void) consultarTweetsAntigos
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"TweetService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    @try {
        
        Tweet2* tweet = [Tweet2 new];
        tweet.acao = @"consultarTweetsAntigos";
        tweet.dataPostagem = [Tweet2 getDataMaisAntiga];
        tweet.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_TwitterURL
                                   WithValues:[tweet objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(consultarTweetsAntigosResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in TweetService" onMethod:@"- (void) consultarTweetsAntigos" withRequest:nil];
        return;
    }
}

-(void)consultarTweetsAntigosResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)consultarTweetsAntigosResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<TweetServiceDelegate>)self.delegate consultarTweetsAntigosResult:nil];
                    return;
                }
                
                TweetList* list = (TweetList *)[TweetList objectForJSON:data];
                
                [Tweet2 setUltimosTweets:list.lista setInicio:NO];
                
                [(id<TweetServiceDelegate>)self.delegate consultarTweetsAntigosResult:list.lista];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarTweetsAntigosResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)consultarTweetsAntigosResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Favoritar

- (void) favoritar:(Tweet2*)tweet
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"TweetService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    //Method verification
    if (tweet == nil || tweet.codigo == 0) {
        [self.delegate error:@"ExceptionModel is null" onMethod:@"- (void) favoritar:(Tweet2*)tweet" withRequest:nil];
        return;
    }
    
    @try {
        
        Tweet2* tweetModel = [Tweet2 new];
        tweetModel.acao = @"favoritar";
        tweetModel.codigo = tweet.codigo;
        tweetModel.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_TwitterURL
                                   WithValues:[tweetModel objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(favoritarResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Usuario" onMethod:@"- (void) loginWith:(Usuario*)usuario" withRequest:nil];
        return;
    }
}

- (void) desfavoritar:(Tweet2*)tweet
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"TweetService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    //Method verification
    if (tweet == nil || tweet.codigo == 0) {
        [self.delegate error:@"ExceptionModel is null" onMethod:@"- (void) favoritar:(Tweet2*)tweet" withRequest:nil];
        return;
    }
    
    @try {
        
        Tweet2* tweetModel = [Tweet2 new];
        tweetModel.acao = @"desfavoritar";
        tweetModel.codigo = tweet.codigo;
        tweetModel.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_TwitterURL
                                   WithValues:[tweetModel objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(favoritarResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Usuario" onMethod:@"- (void) favoritar:(Tweet2*)tweet" withRequest:nil];
        return;
    }
}

-(void)favoritarResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)favoritarResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<TweetServiceDelegate>)self.delegate favoritarResult:nil success:NO];
                    return;
                }
                
                Tweet2 *tweet = (Tweet2 *)[Tweet2 objectForJSON:data];
                
                [(id<TweetServiceDelegate>)self.delegate favoritarResult:tweet success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)favoritarResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)favoritarResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Inserir

- (void) inserir:(Tweet2*)tweet
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"TweetService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    //Method verification
    if (tweet == nil || tweet.categoria.codigo == 0 || [tweet.post isEqualToString:@""]) {
        [self.delegate error:@"ExceptionModel is null" onMethod:@"- (void) inserir:(Tweet2*)tweet" withRequest:nil];
        return;
    }
    
    @try {
        
        tweet.acao = @"salvar";
        tweet.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_TwitterURL
                                   WithValues:[tweet objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(inserirResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Usuario" onMethod:@"- (void) inserir:(Tweet2*)tweet" withRequest:nil];
        return;
    }
}

-(void)inserirResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)inserirResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<TweetServiceDelegate>)self.delegate inserirResult:nil success:NO];
                    return;
                }
                
                Tweet2 *tweet = (Tweet2 *)[Tweet2 objectForJSON:data];
                
                [(id<TweetServiceDelegate>)self.delegate inserirResult:tweet success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirResult:(HttpResponse *)response" withRequest:response.request];
    }
}

#pragma mark Excluir

- (void) excluir:(Tweet2*)tweet
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"TweetService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    //Method verification
    if (tweet == nil || tweet.codigo == 0) {
        [self.delegate error:@"ExceptionModel is null" onMethod:@"- (void) deletar:(Tweet2*)tweet" withRequest:nil];
        return;
    }
    
    @try {
        
        tweet.acao = @"excluir";
        tweet.usuario = [Usuario getUsuario];
        
        [HttpRequest sendRequestForController:HTTP_TwitterURL
                                   WithValues:[tweet objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(excluirResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Usuario" onMethod:@"- (void) deletar:(Tweet2*)tweet" withRequest:nil];
        return;
    }
}

-(void)excluirResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)excluirResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<TweetServiceDelegate>)self.delegate excluirResult:NO];
                    return;
                }
                
                [(id<TweetServiceDelegate>)self.delegate excluirResult:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)excluirResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)excluirResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
