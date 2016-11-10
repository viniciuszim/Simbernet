//
//  AgendaList.m
//  Simbernet
//
//  Created by Marcio Pinto on 28/06/16.
//  Copyright © 2016 Simber. All rights reserved.
//

#import "AgendaList.h"

@implementation AgendaList

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:HTTP_Field_List]) {
        return HTTP_Object_Agenda;
    }
    return nil;
}

@end
