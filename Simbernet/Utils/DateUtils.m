//
//  DateUtils.m
//  instanTag
//
//  Created by Rafael Paiva Silva on 9/7/14.
//  Copyright (c) 2014 Faraj Khasib. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSDate*) convertFromStringToDate:(NSString *)dateString withFormat:(NSString *)dateFormat{
    // Convert time from UTC to local time
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:dateFormat];
//    [format setTimeZone:[NSTimeZone timeZoneWithName:Pattern_UTC]];
    
    NSDate* date = [format dateFromString:dateString];
    
    return date;
}

+(NSString*) convertFromDateToString:(NSDate *)date withFormat:(NSString *)dateFormat{
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *localTime = [[NSDateFormatter alloc] init];
    [localTime setTimeZone:timeZone];
    [localTime setDateFormat:dateFormat];
    
    return [localTime stringFromDate:date];
}

+(NSString*) formataObjetoDataHoraPassadas:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MMM d, h:mm a"];
    
    [formatter setDateFormat:@"dd"];
    NSString *dia = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    [formatter setDateFormat:@"MM"];
    NSString *mes = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    [formatter setDateFormat:@"YYYY"];
    NSString *ano = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    
    [formatter setDateFormat:@"HH"];
    NSString *hrs = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    [formatter setDateFormat:@"mm"];
    NSString *min = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    [formatter setDateFormat:@"ss"];
//    NSString *sec = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    
    [formatter setDateFormat:@"MMM"];
    NSString *monthName = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    [formatter setDateFormat:@"EEEE"];
    NSString *weekDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    
    NSDate* dataAtual = [NSDate new];
    
    // variáveis auxiliares
    CGFloat seconds=1000;
    CGFloat minutes=seconds*60;
    CGFloat hours=minutes*60;
    CGFloat days=hours*24;
    CGFloat weeks=days*7;
//    CGFloat months=weeks*4;
    CGFloat years=days*365;
    CGFloat horarioVerao = 0;
    
    // determina o fuso horário de cada objeto Date
    [formatter setDateFormat:@"Z"];
    CGFloat fh1 = [[NSString stringWithFormat:@"%@", [formatter stringFromDate:date]] floatValue];
    CGFloat fh2 = [[NSString stringWithFormat:@"%@", [formatter stringFromDate:dataAtual]] floatValue];
    
    if (dataAtual > date) {
        horarioVerao = (fh2 - fh1) * seconds;
    } else {
        horarioVerao = (fh1 - fh2) * seconds;
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitSecond
                                                 fromDate: dataAtual toDate: date options: 0];
    CGFloat dif = (([components second] - horarioVerao) * -1) * seconds;
    
    CGFloat y = round(dif/seconds);
    
    NSString* retorno = nil;
    if (y == 0) {
        retorno = [NSString stringWithFormat:@"agora"];
    } else if(y < 60){
        retorno = [NSString stringWithFormat:@"há %d seg", (int) y];
    } else if(y == 60){
        retorno = [NSString stringWithFormat:@"há ± 1 min"];
    } else {
        
        y=round(dif/minutes);
        if(y < 60){
            retorno = [NSString stringWithFormat:@"há %d min", (int) y];
        } else if(y == 60){
            retorno = [NSString stringWithFormat:@"há ± 1 hora"];
        } else if(y > 60){
            
            y=round(dif/hours);
            if(y < 24){
                retorno = [NSString stringWithFormat:@"há %d horas", (int) y];
            } else if(y > 24){
                
                y=round(dif/days);
                if(y == 1){
                    retorno = [NSString stringWithFormat:@"Ontem às %@:%@", hrs, min];
                } else if(y > 1){
                    retorno = [NSString stringWithFormat:@"%@ às %@:%@", weekDay, hrs, min];
                    
                    y=round(dif/weeks);
                    if(y > 1){
                        retorno = [NSString stringWithFormat:@"%@ %@ às %@:%@", dia, monthName, hrs, min];
                        
                        y=round(dif/years);
                        if(y >= 1){
                            retorno = [NSString stringWithFormat:@"%@ %@ %@", dia, monthName, ano];
                        }
                        
                    }
                }
            }
        }
    }
    
    return retorno;
}

@end
