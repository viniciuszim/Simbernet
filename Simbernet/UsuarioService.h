//
//  UsuarioService.h
//  Simbernet
//
//  Created by Rafael Paiva Silva on 11/16/14.
//  Copyright (c) 2014 in6. All rights reserved.
//

#import "BaseService.h"
#import "Usuario.h"

@protocol UserServiceDelegate <BaseServiceDelegate>

@optional
- (void) userServiceDidLogin:(Usuario*) user success:(BOOL)success;
- (void) listAniversariantesReturns:(NSArray*) aniversariantesList;
- (void) atualizarDeviceTokenReturn:(Usuario*) user success:(BOOL)success;

@end

@interface UsuarioService : BaseService

- (void) loginWith:(Usuario*)usuario;
- (void) consultarAniversariantes:(int)tipoPeriodo;
- (void) atualizarDeviceToken:(Usuario*)usuario;

@end
