//
//  UsuarioList.m
//  Simbernet
//
//  Created by Rafael Paiva Silva on 11/29/14.
//  Copyright (c) 2014 Simber. All rights reserved.
//

#import "UsuarioList.h"

@implementation UsuarioList

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:HTTP_Field_List]) {
        return HTTP_Object_User;
    }
    return nil;
}

@end
