//
//  Tweet2.h
//  Simbernet
//
//  Created by Vinicius Miguel on 20/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseModel.h"
#import "Usuario.h"
#import "CategoriaModel.h"

@interface Tweet2 : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic,strong)NSString *dataPostagem;
@property(nonatomic,strong)NSString *post;
@property(nonatomic,strong)Usuario *usuario;
@property(nonatomic,strong)CategoriaModel *categoria;
@property(nonatomic)long codgFavorito;
@property(nonatomic)BOOL enviadoViaTwitter;
@property(nonatomic)long lido;
@property(nonatomic)BOOL podeExcluir;

+ (void) setUltimosTweets:(NSMutableArray*) tweets setInicio:(BOOL)inicio;
+ (void) setUltimoTweet:(Tweet2*) tweet setInicio:(BOOL)inicio;
+ (void) removerTweet:(Tweet2*) tweet atIndex:(NSUInteger)index;
+ (NSMutableArray*) getTweets;
+ (NSString*) getDataMaisRecente;
+ (NSString*) getDataMaisAntiga;
+ (void) setUltimaAtualizacao;
+ (NSAttributedString*) getUltimaAtualizacao;

@end
