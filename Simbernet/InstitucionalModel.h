//
//  InstitucionalModel.h
//  ProconGoias
//
//  Created by Marcio Pinto on 22/03/15.
//  Copyright (c) 2015 in6. All rights reserved.
//

#import "BaseModel.h"

@interface InstitucionalModel : BaseModel

@property(nonatomic,assign) long codigo;
@property(nonatomic,strong) NSString *titulo;
@property(nonatomic,strong) NSString *chave;
@property(nonatomic,strong) NSString *texto;

+ (InstitucionalModel*) obterChave:(NSString*)chave;

@end
