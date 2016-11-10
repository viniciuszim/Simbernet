//
//  ITException.m
//  ProconGoias
//
//  Created by Rafael Paiva Silva on 11/16/14.
//  Copyright (c) 2014 in6. All rights reserved.
//

#import "ITException.h"

@implementation ITException

-(void)raise {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:[self name] message:@"ITException" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
