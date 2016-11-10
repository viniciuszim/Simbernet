//
//  InstitucionalModel.m
//  ProconGoias
//
//  Created by Marcio Pinto on 22/03/15.
//  Copyright (c) 2015 in6. All rights reserved.
//

#import "InstitucionalModel.h"

@implementation InstitucionalModel

+ (InstitucionalModel*) obterChave:(NSString*)chave {
    
    NSString* inst = [NSString stringWithFormat:@"%@_%@", UserDefaults_Institucional, chave];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    InstitucionalModel* institucional = nil;
    
    if (userDefaults) {
        NSString *userJSON = [userDefaults objectForKey:inst];
        if(userJSON != nil && userJSON.length != 0) {
            institucional = [InstitucionalModel new];
            institucional = (InstitucionalModel *)[InstitucionalModel objectForJSON:userJSON];
        }
    }
    
    if (institucional) {
        return institucional;
    } else {
        return nil;
    }
}

@end
