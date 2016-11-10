//
//  CategoriaModel.h
//  Simbernet
//
//  Created by Vinicius Miguel on 19/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "KVCBaseObject.h"
#import "BaseModel.h"
#import "UsuarioList.h"

@interface CategoriaModel : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic,strong)NSString *nome;
@property(nonatomic,strong)NSString *descricao;
//@property(nonatomic,strong)NSMutableArray *grupos;
@property(nonatomic,strong)UsuarioList *usuarios;
@property(nonatomic,strong)NSString *hashtagEspecifica;

+ (void) setCategoriasTwitter:(NSMutableArray*) categorias;
+ (NSMutableArray*) getFullItemsList;

@end
