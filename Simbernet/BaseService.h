//
//  BaseService.h
//  Simbernet
//
//  Created by Rafael Paiva Silva on 11/16/14.
//  Copyright (c) 2014 in6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "ITException.h"

@protocol BaseServiceDelegate <NSObject>
//Not optional
-(void)error:(NSString *)error onMethod:(NSString*)method withRequest:(HttpRequest *)request;
@end

@interface BaseService : NSObject

@property (nonatomic, strong) id <BaseServiceDelegate> delegate ;

@end
