//
//  DeviceService.m
//  SimbernetSimber
//
//  Created by Marcio Pinto on 11/08/16.
//  Copyright © 2016 Simber Tecnologia. All rights reserved.
//

#import "DeviceService.h"

@implementation DeviceService

#pragma mark Inserir Token Device

- (void) inserirDeviceToken:(Device*)device
{
    //Verify if delegate is present **** MANDATORY ****
    if(self.delegate == nil) {
        [[[ITException alloc] initWithName:@"UsuarioService" reason:@"Delegate is null" userInfo:nil] raise];
        return;
    }
    
    //Method verification
    if (device == nil || device.token == nil || device.appID == nil) {
        [self.delegate error:@"ExceptionModel is null" onMethod:@"- (void) inserirDeviceToken:(Device*)device" withRequest:nil];
        return;
    }
    
    @try {
        device.acao = @"inserirIOSToken";
        
        [HttpRequest sendRequestForController:HTTP_DeviceURL
                                   WithValues:[device objectToDictionary]
                                       Method:HTTP_Post
                                       target:self
                                     callBack:@selector(inserirDeviceTokenResult:)];
        
    } @catch (NSException *exception) {
        [self.delegate error:@"Error in Device" onMethod:@"- (void) inserirDeviceToken:(Device*)device" withRequest:nil];
        return;
    }
}

-(void)inserirDeviceTokenResult:(HttpResponse *)response
{
    if (response) {
        if ([response getHasError]) {
            [self.delegate error:response.errorText onMethod:@"-(void)inserirDeviceTokenResult:(HttpResponse *)response" withRequest:response.request];
        } else {
            @try {
                NSString *data = response.responseData;
                NSLog(@"DATA: %@", data);
                if(data == nil || [data length] == 0 || [data isEqualToString:@"[\n\n]"]){
                    [(id<DeviceServiceDelegate>)self.delegate inserirDeviceTokenReturn:nil success:NO];
                    return;
                }
                
                Device *device = (Device *)[Device objectForJSON:data];
                
                [(id<DeviceServiceDelegate>)self.delegate inserirDeviceTokenReturn:device success:YES];
                
            } @catch (NSException *exception) {
                [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirDeviceTokenResult:(HttpResponse *)response" withRequest:response.request];
            }
        }
    } else {
        [self.delegate error:HTTP_UNKNOWN_ERROR_MESSAGE onMethod:@"-(void)inserirDeviceTokenResult:(HttpResponse *)response" withRequest:response.request];
    }
}

@end
