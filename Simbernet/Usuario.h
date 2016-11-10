//
//  Usuario.h
//  Simbernet
//
//  Created by Rafael Paiva Silva on 11/16/14.
//  Copyright (c) 2014 Simber. All rights reserved.
//

#import "KVCBaseObject.h"
#import "BaseModel.h"

@interface Usuario : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic,strong)NSString *nome;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *login;
@property(nonatomic,strong)NSString *senha;
@property(nonatomic,strong)NSString *foto;
@property(nonatomic,strong)NSString *deviceToken;
@property(nonatomic,strong)NSString *dataNascimento;
@property(nonatomic)long status;

+ (Usuario *) getUsuario;
+ (void)storeUsuario:(Usuario*)usuario;
+ (void)deleteUsuario;

@end
