//
//  DiretorioArqList.m
//  Simbernet
//
//  Created by Vinicius Miguel on 15/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "DiretorioArqList.h"

@implementation DiretorioArqList

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:HTTP_Field_List]) {
        return HTTP_Object_DownloadDiretorio;
    }
    return nil;
}

@end
