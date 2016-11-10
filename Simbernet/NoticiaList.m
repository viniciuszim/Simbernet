//
//  NoticiaList.m
//  Simbernet
//
//  Created by Marcio Pinto on 23/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "NoticiaList.h"

@implementation NoticiaList

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:HTTP_Field_List]) {
        return HTTP_Object_Noticia;
    }
    return nil;
}

@end
