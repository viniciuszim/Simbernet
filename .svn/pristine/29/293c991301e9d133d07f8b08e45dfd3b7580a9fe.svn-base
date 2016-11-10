//
//  Device.h
//  SimbernetSimber
//
//  Created by Marcio Pinto on 11/08/16.
//  Copyright © 2016 Simber Tecnologia. All rights reserved.
//

#import "KVCBaseObject.h"
#import "BaseModel.h"
#import "Usuario.h"

@interface Device : BaseModel

@property(nonatomic)long codigo;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *appID;
@property(nonatomic,strong)NSString *appNome;
@property(nonatomic,strong)Usuario *usuario;
@property(nonatomic)long tipo;

+ (Device *) getDevice;
+ (void)storeDevice:(Device*)device;
+ (void)deleteDevice;

@end
