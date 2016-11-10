//
//  Device.m
//  SimbernetSimber
//
//  Created by Marcio Pinto on 11/08/16.
//  Copyright © 2016 Simber Tecnologia. All rights reserved.
//

#import "Device.h"

@implementation Device

#pragma mark Device Session Manipulation on User Defaults

+ (Device *) getDevice {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    Device *device = nil;
    if (standardUserDefaults) {
        NSString *deviceJSON = [standardUserDefaults objectForKey:Session_DeviceTokenUser];
        if(deviceJSON != nil && deviceJSON.length != 0) {
            device = [Device new];
            device = (Device *)[Device objectForJSON:deviceJSON];
        }
    }
    return device;
}

+ (void)storeDevice:(Device*)device {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:[device objectToJson] forKey:Session_DeviceTokenUser];
        [standardUserDefaults synchronize];
    }
    
}

+ (void)deleteDevice {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:nil forKey:Session_DeviceTokenUser];
        [standardUserDefaults synchronize];
    }
}

@end
