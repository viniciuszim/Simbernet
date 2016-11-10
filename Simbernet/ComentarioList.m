//
//  ComentarioList.m
//  Simbernet
//
//  Created by Marcio Pinto on 14/05/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "ComentarioList.h"

@implementation ComentarioList

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:HTTP_Field_List]) {
        return HTTP_Object_Comentario;
    }
    return nil;
}

@end
