//
//  AgendaModel.h
//  Simbernet
//
//  Created by Marcio Pinto on 28/06/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import "KVCBaseObject.h"
#import "BaseModel.h"
#import "Usuario.h"

@interface AgendaModel : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic,strong)NSString *data;
@property(nonatomic,strong)NSString *horaString;
@property(nonatomic,strong)NSString *horaStringFinal;
@property(nonatomic,strong)NSString *titulo;
@property(nonatomic,strong)NSString *descricao;
@property(nonatomic,strong)Usuario *usuario;
@property(nonatomic,strong)Usuario *criador;
@property(nonatomic,strong)NSString *tipo;

@end