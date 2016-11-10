//
//  Usuario.m
//  Simbernet
//
//  Created by Rafael Paiva Silva on 11/16/14.
//  Copyright (c) 2014 Simber. All rights reserved.
//

#import "Usuario.h"

@implementation Usuario

#pragma mark User Session Manipulation on User Defaults

+ (Usuario *) getUsuario {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    Usuario *usuario = nil;
    if (standardUserDefaults) {
        NSString *usuarioJSON = [standardUserDefaults objectForKey:Session_UserLogged];
        if(usuarioJSON != nil && usuarioJSON.length != 0) {
            usuario = [Usuario new];
            usuario = (Usuario *)[Usuario objectForJSON:usuarioJSON];
        }
    }
    return usuario;
}

+ (void)storeUsuario:(Usuario*)usuario {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:[usuario objectToJson] forKey:Session_UserLogged];
        [standardUserDefaults synchronize];
    }
    
}

+ (void)deleteUsuario {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:nil forKey:Session_UserLogged];
        [standardUserDefaults synchronize];
    }
}

@end
