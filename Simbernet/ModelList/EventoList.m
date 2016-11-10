//
//  EventoList.m
//  Simbernet
//
//  Created by Vinicius Miguel on 08/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "EventoList.h"

@implementation EventoList

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:HTTP_Field_List]) {
        return HTTP_Object_Evento;
    }
    return nil;
}

@end
