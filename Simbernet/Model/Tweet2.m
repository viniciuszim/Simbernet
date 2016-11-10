//
//  Tweet2.m
//  Simbernet
//
//  Created by Vinicius Miguel on 20/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "Tweet2.h"
#import "Usuario.h"
#import "CategoriaModel.h"

@implementation Tweet2

+ (void) setUltimosTweets:(NSMutableArray*) tweets setInicio:(BOOL)inicio {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listUserDefaults = [userDefaults objectForKey:UserDefaults_ListaUltimosTweets];
    
    NSMutableArray* array = [NSMutableArray new];
    
    if (listUserDefaults && !inicio) {
        [array addObjectsFromArray:listUserDefaults];
    }
    
    if (tweets != nil && tweets.count != 0) {
        for (Tweet2* tweet in tweets) {
            [array addObject:[tweet objectToDictionary]];
        }
    }
    
    if (listUserDefaults && inicio) {
        [array addObjectsFromArray:listUserDefaults];
    }
    
    [userDefaults setObject:array forKey:UserDefaults_ListaUltimosTweets];
    [userDefaults synchronize];
    
}

+ (void) setUltimoTweet:(Tweet2*) tweet setInicio:(BOOL)inicio {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listUserDefaults = [userDefaults objectForKey:UserDefaults_ListaUltimosTweets];
    
    NSMutableArray* array = [NSMutableArray new];
    
    if (listUserDefaults && !inicio) {
        [array addObjectsFromArray:listUserDefaults];
    }
    
    [array addObject:[tweet objectToDictionary]];
    
    if (listUserDefaults && inicio) {
        [array addObjectsFromArray:listUserDefaults];
    }
    
    [userDefaults setObject:array forKey:UserDefaults_ListaUltimosTweets];
    [userDefaults synchronize];
    
}

+ (void) removerTweet:(Tweet2*) tweet atIndex:(NSUInteger)index {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listUserDefaults = [userDefaults objectForKey:UserDefaults_ListaUltimosTweets];
    
    NSMutableArray* array = [NSMutableArray new];
    [array addObjectsFromArray:listUserDefaults];
    
    [array removeObjectAtIndex:index];
    
    [userDefaults setObject:array forKey:UserDefaults_ListaUltimosTweets];
    [userDefaults synchronize];
    
}

+ (NSMutableArray*) getTweets {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listUserDefaults = [userDefaults objectForKey:UserDefaults_ListaUltimosTweets];
    
    NSMutableArray* tweets = [NSMutableArray new];
    if (listUserDefaults != nil && listUserDefaults.count != 0) {
        
        Tweet2* tweet = nil;
        for (NSDictionary* dict in listUserDefaults) {
            tweet = [Tweet2 new];
            tweet = (Tweet2 *)[Tweet2 objectForDictionary:dict];
            
            [tweets addObject:tweet];
        }
    }
    
    return tweets;
}

+ (NSString*) getDataMaisRecente {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listUserDefaults = [userDefaults objectForKey:UserDefaults_ListaUltimosTweets];
    
    if (listUserDefaults) {
        NSDictionary* dict = [listUserDefaults objectAtIndex:0];
        return dict[@"dataPostagem"];
    }
    
    return nil;
}

+ (NSString*) getDataMaisAntiga {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* listUserDefaults = [userDefaults objectForKey:UserDefaults_ListaUltimosTweets];
    
    if (listUserDefaults) {
        NSDictionary* dict = [listUserDefaults objectAtIndex:(listUserDefaults.count - 1)];
        return dict[@"dataPostagem"];
    }
    
    return nil;
}

+ (void) setUltimaAtualizacao {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
//        NSString *languageID = [[NSBundle mainBundle] preferredLocalizations].firstObject;
//        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:languageID]];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    
    NSString* ultimaAtualizacao = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ultimaAtualizacao forKey:UserDefaults_DataUltimaAtualizacaoTweets];
    [userDefaults synchronize];
    
}

+ (NSAttributedString*) getUltimaAtualizacao {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* ultimaAtualizacao = [userDefaults objectForKey:UserDefaults_DataUltimaAtualizacaoTweets];
    
    if (ultimaAtualizacao) {
        NSString *title = [NSString stringWithFormat:@"Última atualização: %@", ultimaAtualizacao];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        return [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    } else {
        return nil;
    }
}

@end
