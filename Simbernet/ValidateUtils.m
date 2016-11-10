//
//  ValidateUtils.m
//  Simbernet
//
//  Created by Rafael Paiva Silva on 11/15/14.
//  Copyright (c) 2014 Simber. All rights reserved.
//

#import "ValidateUtils.h"

@implementation ValidateUtils

#pragma mark Only Numbers

+ (BOOL)validateOnlyNumbers:(NSString *)number {
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_NUMBER_ONLY];
    
    return [test evaluateWithObject:number];
}

#pragma mark Size

//return true se é maior que o máximo
+ (BOOL)validateMaxSize:(NSString *)text withSize:(int)size {
    
    return (text.length > size);
}

//return true se é menor que o minimo
+ (BOOL)validateMinSize:(NSString *)text withSize:(int)size {
    
    return (text.length < size);
}

#pragma mark CPF
    
+ (BOOL)validateCPF:(NSString *)cpf {
    
    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(cpf == nil) return NO;
    cpf = [[cpf stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if ([cpf length] != 11) return NO;
    if (([cpf isEqual:@"00000000000"]) || ([cpf isEqual:@"11111111111"]) || ([cpf isEqual:@"22222222222"])|| ([cpf isEqual:@"33333333333"])|| ([cpf isEqual:@"44444444444"])|| ([cpf isEqual:@"55555555555"])|| ([cpf isEqual:@"66666666666"])|| ([cpf isEqual:@"77777777777"])|| ([cpf isEqual:@"88888888888"])|| ([cpf isEqual:@"99999999999"])) return NO;
    
    firstSum = 0;
    for (i = 0; i <= 8; i++) {
        firstSum += [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
    }
    
    if (firstSum % 11 < 2)
        firstDigit = 0;
    else
        firstDigit = 11 - (firstSum % 11);
    
    secondSum = 0;
    for (i = 0; i <= 9; i++) {
        secondSum = secondSum + [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
    }
    
    if (secondSum % 11 < 2)
        secondDigit = 0;
    else
        secondDigit = 11 - (secondSum % 11);
    
    firstDigitCheck = [[cpf substringWithRange:NSMakeRange(9, 1)] intValue];
    secondDigitCheck = [[cpf substringWithRange:NSMakeRange(10, 1)] intValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
        return YES;
    return NO;
}

#pragma mark CNPJ

+ (BOOL)validateCNPJ:(NSString *)cnpj {
    
    NSUInteger peso, soma = 0, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(cnpj == nil) return NO;
    cnpj = [[[cnpj stringByReplacingOccurrencesOfString:@"/" withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if ([cnpj length] != 14) return NO;
    if ([cnpj isEqualToString:@"00000000000000"] || [cnpj isEqualToString:@"11111111111111"] || [cnpj isEqualToString:@"22222222222222"] || [cnpj isEqualToString:@"33333333333333"] || [cnpj isEqualToString:@"44444444444444"] || [cnpj isEqualToString:@"55555555555555"] || [cnpj isEqualToString:@"66666666666666"] || [cnpj isEqualToString:@"77777777777777"] || [cnpj isEqualToString:@"88888888888888"] || [cnpj isEqualToString:@"99999999999999"]) return NO;
    
    //Verificação 13 Digito
    peso = 2;
    for (int i = 11; i >= 0; i--) {
        
        soma = soma + ( [[cnpj substringWithRange:NSMakeRange(i, 1)] integerValue] * peso);
        
        peso = peso + 1;
        
        if (peso == 10) {
            peso = 2;
        }
    }
    
    if (soma % 11 == 0 || soma % 11 == 1) {
        firstDigitCheck = 0;
    } else {
        firstDigitCheck = 11 - soma % 11;
    }
    
    //Verificação 14 Digito
    soma = 0;
    peso = 2;
    for (int i = 12; i >= 0; i--) {
        
        soma = soma + ( [[cnpj substringWithRange:NSMakeRange(i, 1)] integerValue] * peso);
        
        peso = peso + 1;
        
        if (peso == 10) {
            peso = 2;
        }
    }
    
    if (soma % 11 == 0 || soma % 11 == 1) {
        secondDigitCheck = 0;
    } else {
        secondDigitCheck = 11 - soma % 11;
    }
    
    //Retorno
    firstDigit = [[cnpj substringWithRange:NSMakeRange(12, 1)] integerValue];
    secondDigit = [[cnpj substringWithRange:NSMakeRange(13, 1)] integerValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
        return YES;
    return NO;
}

#pragma mark Email

+(BOOL) validateEmail:(NSString *)email
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *emailRegex = stricterFilter ? Regex_EMAIL_FULL : Regex_EMAIL_HALF;
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [test evaluateWithObject:email];
}

#pragma mark Cep

+(BOOL) validateCEP:(NSString *)cep
{
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_CEP];
    
    return [test evaluateWithObject:cep];
}

#pragma mark Phone

+(BOOL) validatePhone:(NSString *)phone
{
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_PHONE];
    
    return [test evaluateWithObject:phone];
}

#pragma mark Date

+(BOOL) validateDate:(NSString *)date
{
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex_DATE];
    
    if (![test evaluateWithObject:date]) {
        return NO;
    }
    
    NSArray* numbers = [date componentsSeparatedByString:@"/"];
    NSArray* daysOfMonth = @[@31, ([numbers[2] integerValue] % 4 == 0) ? @29 : @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31];
    
    if ([numbers[2] integerValue] < 1900) {
        return NO;
    } else if ([numbers[1] integerValue] < 1 || [numbers[1] integerValue] > 12) {
        return NO;
    } else if ([numbers[0] integerValue] < 1 || [numbers[0] integerValue] > [daysOfMonth[[numbers[1] integerValue] - 1] integerValue]) {
        return NO;
    }
    
    return YES;
}


@end
