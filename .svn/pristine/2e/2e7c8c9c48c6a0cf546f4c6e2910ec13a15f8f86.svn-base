//
//  DownloadTipoModel.m
//  Simbernet
//
//  Created by Vinicius Miguel on 17/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "DownloadTipoModel.h"

@implementation DownloadTipoModel

+ (void) setTiposDownload:(NSMutableArray*) tipos {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray* array = [NSMutableArray new];
    
    if (tipos != nil && tipos.count != 0) {
        for (DownloadTipoModel* tipo in tipos) {
            [array addObject:[tipo objectToDictionary]];
        }
    }
    
    [userDefaults setObject:array forKey:UserDefaults_ListaTiposDownload];
    [userDefaults synchronize];
    
}

+ (NSMutableArray*) getFullItemsList {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listTiposUserDefaults = [userDefaults objectForKey:UserDefaults_ListaTiposDownload];
    
    NSMutableArray* tipos = [NSMutableArray new];
    if (listTiposUserDefaults != nil && listTiposUserDefaults.count != 0) {
        
        DownloadTipoModel* tipo = nil;
        for (NSDictionary* dict in listTiposUserDefaults) {
            tipo = (DownloadTipoModel *)[DownloadTipoModel objectForDictionary:dict];
            
            [tipos addObject:tipo];
        }
    }
    
    return tipos;
}

@end
