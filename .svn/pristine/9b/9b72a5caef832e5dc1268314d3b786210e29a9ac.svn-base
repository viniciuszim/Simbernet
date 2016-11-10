//
//  EventoModel.m
//  Simbernet
//
//  Created by Vinicius Miguel on 08/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "EventoModel.h"

@implementation EventoModel

+ (NSString*)getFullHour:(EventoModel*) evento {
    
    NSMutableString *fullHour = [NSMutableString new];
    
    [fullHour appendString:[NSString stringWithFormat:@"%@", evento.dtInicioAux]];

    if (evento.dtFimAux != nil && ![evento.dtFimAux isEqualToString:@""] && ![evento.dtFimAux isEqualToString:evento.dtInicioAux]) {
        
        if (evento.horaInicioAux != nil && ![evento.horaInicioAux isEqualToString:@""]) {
            [fullHour appendString:[NSString stringWithFormat:@" às %@", [evento.horaInicioAux substringWithRange:NSMakeRange(0, 5) ]]];
        }
        
        if (evento.dtFimAux != nil && ![evento.dtFimAux isEqualToString:@""]) {
            [fullHour appendString:[NSString stringWithFormat:@" até %@", evento.dtFimAux]];
        }
        
        if (evento.horaFimAux != nil && ![evento.horaFimAux isEqualToString:@""]) {
            [fullHour appendString:[NSString stringWithFormat:@" às %@", [evento.horaFimAux substringWithRange:NSMakeRange(0, 5) ]]];
        }
        
    } else {
        
        if (evento.horaFimAux != nil && ![evento.horaFimAux isEqualToString:@""]
            && evento.horaInicioAux != nil && ![evento.horaInicioAux isEqualToString:@""]
            && ![evento.horaInicioAux isEqualToString:evento.horaFimAux]) {
            
            [fullHour appendString:[NSString stringWithFormat:@" às %@", [evento.horaInicioAux substringWithRange:NSMakeRange(0, 5) ]]];
            [fullHour appendString:[NSString stringWithFormat:@" às %@", [evento.horaFimAux substringWithRange:NSMakeRange(0, 5) ]]];
        } else {
            
            if (evento.horaInicioAux != nil && ![evento.horaInicioAux isEqualToString:@""]) {
                [fullHour appendString:[NSString stringWithFormat:@" às %@", [evento.horaInicioAux substringWithRange:NSMakeRange(0, 5) ]]];
            }
        }
        
    }
    
    
    
    
    return fullHour;
}

+ (void) setUltimaAtualizacao {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    
    NSString* ultimaAtualizacao = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ultimaAtualizacao forKey:UserDefaults_DataUltimaAtualizacaoEventos];
    [userDefaults synchronize];
    
}

+ (NSAttributedString*) getUltimaAtualizacao {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* ultimaAtualizacao = [userDefaults objectForKey:UserDefaults_DataUltimaAtualizacaoEventos];
    
    if (ultimaAtualizacao) {
        NSString *title = [NSString stringWithFormat:@"Última atualização: %@", ultimaAtualizacao];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        return [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    } else {
        return nil;
    }
}

@end
