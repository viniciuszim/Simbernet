//
//  DownloadGenericModel.m
//  Simbernet
//
//  Created by Vinicius Miguel on 17/09/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "DownloadGenericModel.h"

@implementation DownloadGenericModel

// Referencia: https://www.iconfinder.com/search/?q=iconset%3Ahawcons+file&price=free
+(UIImage*) obterIcone:(NSString*) nomeArquivo {
    
    if (nomeArquivo != nil && ![nomeArquivo isEqualToString:@""]) {
        
        NSRange range = [nomeArquivo rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, nomeArquivo.length)];
        if (range.length > 0) {
            NSString* icone = [nomeArquivo substringFromIndex:range.location + 1];
            return [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@",icone ]];
        }
    }
    
    return [UIImage imageNamed:@"icon_file"];
}

+ (NSString*)getUrlBase:(NSString*)value {
    
    NSRange range = [value rangeOfString:@"///" options:NSBackwardsSearch range:NSMakeRange(0, value.length)];
    if (range.length > 0) {
        value = [value stringByReplacingOccurrencesOfString:@"///"
                                               withString:@"/"];
        
        range = [value rangeOfString:@"//" options:NSBackwardsSearch range:NSMakeRange(0, value.length)];
        if (range.length > 0) {
            value = [value stringByReplacingOccurrencesOfString:@"//"
                                                     withString:@"/"];
        }
        
    } else {
        range = [value rangeOfString:@"//" options:NSBackwardsSearch range:NSMakeRange(0, value.length)];
        if (range.length > 0) {
            value = [value stringByReplacingOccurrencesOfString:@"//"
                                                     withString:@"/"];
        }
    }
    range = [value rangeOfString:@"/" options:NSBackwardsSearch range:NSMakeRange(0, 1)];
    if (range.length > 0) {
        value = [value substringFromIndex:range.location + 1];
    }
    
    NSMutableString *url = [NSMutableString new];
    
    [url appendString:[NSString stringWithFormat:@"%@/", url_base_arquivos ]];
    [url appendString:[NSString stringWithFormat:@"%@/", base_contexto ]];
    [url appendString:[NSString stringWithFormat:@"%@/", base_path ]];
//    [url appendString:[NSString stringWithFormat:@"%@/", base_aplicacao ]];
    [url appendString:[NSString stringWithFormat:@"%@/", base_download ]];
    [url appendString:[NSString stringWithFormat:@"%@", value ]];
    
    return url;
}


@end
