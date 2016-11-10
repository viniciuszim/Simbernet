//
//  TweetService.h
//  Simbernet
//
//  Created by Vinicius Miguel on 19/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseService.h"
#import "Tweet2.h"

@protocol TweetServiceDelegate <BaseServiceDelegate>

@optional
- (void) consultarTweetsRecentesResult:(NSArray*) tweetListResult;
- (void) consultarTweetsAntigosResult:(NSArray*) tweetListResult;
- (void) favoritarResult:(Tweet2*) tweet success:(BOOL)success;
- (void) inserirResult:(Tweet2*) tweet success:(BOOL)success;
- (void) excluirResult:(BOOL)success;
@end

@interface TweetService : BaseService

- (void) consultarTweetsRecentes;
- (void) consultarTweetsAntigos;

- (void) favoritar:(Tweet2*)tweet;
- (void) desfavoritar:(Tweet2*)tweet;

- (void) inserir:(Tweet2*)tweet;
- (void) excluir:(Tweet2*)tweet;

@end
