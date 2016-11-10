//
//  DiretorioArqService.h
//  Simbernet
//
//  Created by Vinicius Miguel on 15/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseService.h"
#import "DownloadGenericModel.h"

@protocol DiretorioArqServiceDelegate <BaseServiceDelegate>

@optional
- (void) consultarDiretoriosDownloadsResult:(NSArray*) listResult;

@end

@interface DiretorioArqService : BaseService

- (void) consultarDiretoriosDownloads:(DownloadGenericModel *)diretorio;
- (void) filtrarDownloads:(DownloadGenericModel *)downloadGeneric;

@end
