//
//  DeviceService.h
//  SimbernetSimber
//
//  Created by Marcio Pinto on 11/08/16.
//  Copyright © 2016 Simber Tecnologia. All rights reserved.
//

#import "BaseService.h"
#import "Device.h"

@protocol DeviceServiceDelegate <BaseServiceDelegate>

@optional
- (void) inserirDeviceTokenReturn:(Device*) device success:(BOOL)success;
@end

@interface DeviceService : BaseService

- (void) inserirDeviceToken:(Device*)device;

@end
