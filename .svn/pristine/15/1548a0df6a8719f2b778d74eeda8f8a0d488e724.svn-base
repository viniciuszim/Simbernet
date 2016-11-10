//
//  CategoriaModel.m
//  Simbernet
//
//  Created by Vinicius Miguel on 19/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "CategoriaModel.h"

@implementation CategoriaModel

+ (void) setCategoriasTwitter:(NSMutableArray*) categorias {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray* array = [NSMutableArray new];
    
    if (categorias != nil && categorias.count != 0) {
        for (CategoriaModel* categoria in categorias) {
            [array addObject:[categoria objectToDictionary]];
        }
    }
    
    [userDefaults setObject:array forKey:UserDefaults_ListaCategoriasTwitter];
    [userDefaults synchronize];
    
}

+ (NSMutableArray*) getFullItemsList {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listCategoriasUserDefaults = [userDefaults objectForKey:UserDefaults_ListaCategoriasTwitter];
    
    NSMutableArray* categorias = [NSMutableArray new];
    if (listCategoriasUserDefaults != nil && listCategoriasUserDefaults.count != 0) {
        
        CategoriaModel* categoria = nil;
        for (NSDictionary* dict in listCategoriasUserDefaults) {
            categoria = (CategoriaModel *)[CategoriaModel objectForDictionary:dict];
            
            [categorias addObject:categoria];
        }
    }
    
    return categorias;
}


@end
