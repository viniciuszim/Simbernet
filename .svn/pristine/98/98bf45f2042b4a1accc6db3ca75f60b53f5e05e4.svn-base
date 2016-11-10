//
//  EventoModel.h
//  Simbernet
//
//  Created by Vinicius Miguel on 08/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseModel.h"

@interface EventoModel : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic,strong)NSString *titulo;
@property(nonatomic,strong)NSString *resumo;
@property(nonatomic,strong)NSString *texto;
@property(nonatomic,strong)NSString *foto;
@property(nonatomic,strong)NSString *imagem;
@property(nonatomic,strong)NSString *dtInicioAux;
@property(nonatomic,strong)NSString *dtFimAux;
@property(nonatomic,strong)NSString *horaInicioAux;
@property(nonatomic,strong)NSString *horaFimAux;
@property(nonatomic)long totalComentarios;

+ (NSString*)getFullHour:(EventoModel*) evento;
+ (void) setUltimaAtualizacao;
+ (NSAttributedString*) getUltimaAtualizacao;

@end
