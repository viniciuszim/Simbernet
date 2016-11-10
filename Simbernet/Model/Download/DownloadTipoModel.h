//
//  DownloadTipoModel.h
//  Simbernet
//
//  Created by Vinicius Miguel on 17/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseModel.h"

@interface DownloadTipoModel : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic,strong)NSString *descricao;

+ (void) setTiposDownload:(NSMutableArray*) tipos;
+ (NSMutableArray*) getFullItemsList;
    
@end
