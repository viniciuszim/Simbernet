//
//  Comentario.h
//  Simbernet
//
//  Created by Marcio Pinto on 13/05/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "KVCBaseObject.h"
#import "BaseModel.h"

@interface Comentario : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic)long codigoNoticia;
@property(nonatomic)long codigoUsuario;
@property(nonatomic,strong)NSString *fotoUsuario;
@property(nonatomic,strong)NSString *nomeUsuario;
@property(nonatomic,strong)NSString *data;
@property(nonatomic,strong)NSString *comentario;

@end
