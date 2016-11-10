//
//  CategoriaService.h
//  Simbernet
//
//  Created by Vinicius Miguel on 24/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseService.h"

@protocol CategoriaServiceDelegate <BaseServiceDelegate>

@optional

- (void) listCategoriasReturns:(NSArray*)categoriaList success:(BOOL)success;

@end

@interface CategoriaService : BaseService

- (void)listarTodasCategorias;

@end
