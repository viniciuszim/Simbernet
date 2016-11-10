//
//  ForumModel.m
//  Simbernet
//
//  Created by Marcio Pinto on 11/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "ForumModel.h"

@implementation ForumModel

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
