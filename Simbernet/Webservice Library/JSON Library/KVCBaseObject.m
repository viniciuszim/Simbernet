//
//  KVCBaseObject.m
//  JSONTest
//
//  Created by mahadevan on 09/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "KVCBaseObject.h"
#import "SBJson.h"

@implementation KVCBaseObject

const char * property_getTypeString( objc_property_t property );

- (id) init {
    if (self = [super init]) {
        
    }
    return self;
}

/*
 * Should be implemented by subclasses using NSArray types.
 */
- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    return nil;
}

/*
 * Should be implemented by subclasses that will have a different propertyName for a json key.
 */
- (NSString *) getPropertyNameForJsonKey:(NSString *)jsonKey {
    return nil;
}

+ (id)objectForJSON:(NSString *) inputJSON {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *jDict = [parser objectWithString:inputJSON error:nil];
    return [self objectForDictionary:jDict];
}


const char * property_getTypeString( objc_property_t property )
{
    const char * attrs = property_getAttributes( property );
    if ( attrs == NULL )
        return ( NULL );
    
    static char buffer[256];
    const char * e = strchr( attrs, ',' );
    if ( e == NULL )
        return ( NULL );
    
    int len = (int)(e - attrs);
    memcpy( buffer, attrs, len );
    buffer[len] = '\0';
    
    return ( buffer );
}

+ (BOOL) hasPropertyNamed: (NSString *) name
{
    return ( class_getProperty(self, [name UTF8String]) != NULL );
}


+ (BOOL) hasPropertyForKVCKey: (NSString *) key
{
    if ( [self hasPropertyNamed: key] )
        return ( YES );
    
    return NO;
}

+ (char *) typeOfPropertyNamed: (const char *) rawPropType
{
    int k = 0;
    char * parsedPropertyType = malloc(sizeof(char *) * 16);
    if (*rawPropType == 'T') {
        rawPropType++;
    } else { 
        rawPropType = NULL;
    }
    
    if (rawPropType == NULL) {
        return NULL;
    }
    if (*rawPropType == '@') {
        rawPropType+=2;
        for (; *rawPropType != '\"';) {
            parsedPropertyType[k++] = *rawPropType;
            rawPropType++;
        }
        parsedPropertyType[k] = '\0';
        return parsedPropertyType;
        
    } else if (*rawPropType == 'i'){
        return "NSInteger";
    } else if (*rawPropType == 'd'){
        return "double";
    } else if (*rawPropType == 'f') {
        return "float";
    } else if (*rawPropType == 'c') {
        return "BOOL";
    }
    else if (*rawPropType == 'l') {
        return "long";
    }
    else if (*rawPropType == 'q') {
        return "long long ";
    }
    else if (*rawPropType == 'b') {
        return "BOOL";
    } else if (*rawPropType == 'B') {
            return "BOOL";
    }
    return ( NULL );
}




+ (NSMutableDictionary *) getPropertiesAndTypesForClassName:(const char *)className {
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    id class = objc_getClass(className);
    
    /*
     * Recursively get properties and types of a class including its parent classes.
     * Stop when NSObject is reached.
     * PS : If you are using models of NSManagedObject, you might want to replace the 
     * below line to 
     * if ([class superclass] != [NSManagedObject class]) {
     * and subclass KVCBaseObject from NSObject to NSManagedObject
     */
    
    if ([class superclass] != [NSObject class]) {
        dict = [KVCBaseObject getPropertiesAndTypesForClassName:class_getName([class superclass])] ;
    }
    unsigned int outCount, i; objc_property_t *properties = class_copyPropertyList(class, &outCount);

    for (i = 0; i < outCount; i++) {

        objc_property_t property = properties[i];
        const char * propName = property_getName(property);
         NSString * propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
        const char * rawPropType = property_getTypeString(property);
        const char * objCType = [self typeOfPropertyNamed:rawPropType];
        if (objCType == NULL) {
            NSLog(@"Invalid property type for propertyName %@. Skip ", propertyName);
        } else {
            NSString * propertyType = [NSString stringWithCString:objCType encoding:NSUTF8StringEncoding];
            
            [dict setValue:propertyType forKey:propertyName];
        }

        
    }
    return dict;
}

+(BOOL) isPropertyTypeArray:(NSString *)propertyType {
    if ([propertyType isEqualToString:@"NSArray"] ||
        [propertyType isEqualToString:@"NSMutableArray"]) {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL) isPropertyTypeBasic:(NSString *)propertyType {
    if ([propertyType isEqualToString:@"NSString"] ||
        [propertyType isEqualToString:@"NSNumber"] ||
        [propertyType isEqualToString:@"NSInteger"] ||
        [propertyType isEqualToString:@"float"] || 
        [propertyType isEqualToString:@"double"] ||
        [propertyType isEqualToString:@"BOOL"]||
        [propertyType isEqualToString:@"long"]||
        [propertyType isEqualToString:@"int"]||
        [propertyType isEqualToString:@"long long "]) {
        
        return YES;
    } else {
        return NO;
    }
}

+(id) objectForPropertyKey:(NSString *)propertyType {
    id kvcObject = [[NSClassFromString(propertyType) alloc] init];
    return kvcObject;
}

+ (NSArray *)arrayForType:(NSString *)componentType withJSONArray:(NSArray *)jArray {
    if ([componentType isEqualToString:@"NSString"] ||
        [componentType isEqualToString:@"NSNumber"]) {
        return [NSArray arrayWithArray:jArray];
    }
    
    /*
     * Now for some good object mapping
     * with classic recursion!
     */
    
    NSMutableArray * resultArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary * item in jArray) {
        Class childClass = NSClassFromString(componentType);
        id kvcChild = [childClass objectForDictionary:item];
        [resultArray addObject:kvcChild];
    }
    
    return resultArray;
}

+ (id)objectForDictionary:(NSDictionary *) inputDict {
    
    if ([inputDict isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    
    const char* className ;
    NSDictionary * propertyDict;
    NSArray * propertyKeys;
    id kvcObject;
    
   /* @try {*/
       className = class_getName([self class]);
       propertyDict = [self getPropertiesAndTypesForClassName:className];
       propertyKeys = [propertyDict allKeys];
   
    
    
    //Create our object
    kvcObject = [[NSClassFromString([NSString stringWithCString:className encoding:NSUTF8StringEncoding]) alloc] init];
    
    for (__strong NSString * key in [inputDict allKeys]) {
        id propertyValue = [inputDict objectForKey:key];
       // NSLog(@"Current key = %@",key);
        
        if (![propertyKeys containsObject:key]) {
            key = [kvcObject getPropertyNameForJsonKey:key];
        }
        if (key) {
            NSString * propType = [propertyDict objectForKey:key];
            /*
             * Sometimes an invalid property type can be used by the client object.
             * Gracefully ignore it.
             */
            if (propType == nil) {
                continue;
            }
            
            if ([KVCBaseObject isPropertyTypeArray:propType]) {
                
                NSString * componentType = [kvcObject getComponentTypeForCollection:key];
                NSArray  * jArray = (NSArray *)propertyValue;
                // If the object has specified a type, create objects of that type. else 
                // set the array as such.
                if ([componentType length] > 1) {
                    NSArray * componentArray = [KVCBaseObject arrayForType:componentType withJSONArray:jArray];
                    [kvcObject setValue:componentArray forKey:key];
                } else {
                    [kvcObject setValue:jArray forKey:key];
                }
                
            } else if ([KVCBaseObject isPropertyTypeBasic:propType]) {
                if([propType isEqualToString:@"BOOL"])
                {
                    if([propertyValue isKindOfClass:[NSString class]])
                    {   
                        if([propertyValue isEqualToString:@"true"])
                           [kvcObject setValue:[NSNumber numberWithBool:YES] forKey:key];
                        else 
                            [kvcObject setValue:[NSNumber numberWithBool:NO] forKey:key];
                    }else 
                        [kvcObject setValue:propertyValue forKey:key];
                } else if([propType isEqualToString:@"NSString"])
                {
                    if (![propertyValue isEqual:[NSNull null]]) {
                        [kvcObject setValue:[NSString stringWithFormat:@"%@",propertyValue] forKey:key];
                    } else
                        [kvcObject setValue:[NSString stringWithFormat:@""] forKey:key];
                    
                } else
                    [kvcObject setValue:propertyValue forKey:key];
                
            } else if ([propType isEqualToString:@"NSDate"])
            {
                NSString *sDateValue = propertyValue;
                if(sDateValue!=nil)
                {
                    if([sDateValue rangeOfString:@"("].location!=NSNotFound)
                    {
                        int iStartPos = (int)[sDateValue rangeOfString:@"("].location+1;
                        int iEndPos = (int)[sDateValue rangeOfString:@")"].location;
                        NSRange range = NSMakeRange(iStartPos,iEndPos-iStartPos);
                        unsigned long long ullMilliseconds = [[sDateValue substringWithRange:range] longLongValue];
                        NSTimeInterval objInterval = ullMilliseconds/1000;
                       NSDate *objResultDate= [NSDate dateWithTimeIntervalSince1970:objInterval];                    
                      [kvcObject setValue:objResultDate forKey:key] ;
                    }else
                    {
                        NSDateFormatter *objDateFormater = [[NSDateFormatter alloc] init];
                        [objDateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        [kvcObject setValue:[objDateFormater dateFromString:sDateValue] forKey:key];
                    }
                }
                
            }else
            
            {
                /*
                 * If the component is not any primitive type or array
                 * create a custom object of it and pass the dictionary to it.
                 */
                Class childClass = NSClassFromString(propType);
                if ([childClass isSubclassOfClass:[KVCBaseObject class]]) {
                    id kvcChild = [childClass objectForDictionary:propertyValue];
                    [kvcObject setValue:kvcChild forKey:key];
                } else {
                    [kvcObject setValue:propertyValue forKey:key];
                }
            }
        }
        
    }
    /*}
    @catch (NSException *exception)
    {
        NSLog(@"Exception %@",exception);
        NSLog(@"Input Dic %@",inputDict);
        NSLog(@"Class Name %@",[NSString stringWithUTF8String:className]);
        NSLog(@"Proprty Name %@",propertyDict);

        [NSException raise:@"Exception Parsing" format:@""];
    }*/
    return kvcObject;
}



- (NSDictionary *)objectToDictionary {
    const char* className = class_getName([self class]);
    NSDictionary * propertyDict = [KVCBaseObject getPropertiesAndTypesForClassName:className];
    
    NSRegularExpression *expression=[NSRegularExpression regularExpressionWithPattern:@"__.*__" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSMutableDictionary * resultDict = [[NSMutableDictionary alloc] init];
    for (NSString * currentProperty in propertyDict) {
        NSString *key ;
        if ([currentProperty isEqualToString:@"Id"])
            key = @"id" ;
        else
            key = currentProperty ;
        
        key = [expression stringByReplacingMatchesInString:key options:0 range:NSMakeRange(0, [key length]) withTemplate:@""];
        
        NSString * propType = [propertyDict objectForKey:currentProperty];
        
        /*
         * Sometimes an invalid property type can be used by the client object.
         * Gracefully ignore it.
         */
        if (propType == nil) {
            continue;
        }
        
        if ([KVCBaseObject isPropertyTypeArray:propType]) {
            
            NSArray * objArray = [self valueForKey:currentProperty];
            if ([objArray count] > 0) {
                id firstObject = [objArray objectAtIndex:0];
                if ([firstObject isKindOfClass:[NSString class]] ||
                    [firstObject isKindOfClass:[NSNumber class]]) {
                    
                    [resultDict setValue:objArray forKey:key];
                    
                } else {
                    
                    NSMutableArray * customObjArray = [[NSMutableArray alloc] init];
                    for (id arrayObj in objArray) {
                        if ([arrayObj isKindOfClass:[KVCBaseObject class]]){
                            NSDictionary * childDict = [arrayObj objectToDictionary];
                            [customObjArray addObject:childDict];
                        }
                    }
                    [resultDict setValue:customObjArray forKey:key];
                    
                }
            } else {
                NSArray * emptyArray = [[NSArray alloc] init];
                [resultDict setValue:emptyArray forKey:key];
            }
            
            
        } 
        else if ([propType isEqualToString:@"NSDate"])
        {
            NSDateFormatter *dateFormatter = [NSDateFormatter new] ;
            [dateFormatter setDateFormat:@"yyyy-MM-dd"] ;
            [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
            id sDate = [self valueForKey:currentProperty] ;
            if(sDate)
            {
                if([sDate isKindOfClass:[NSString class]])
                {
                    NSDate *objDate = [dateFormatter dateFromString:sDate];
                    if (objDate)
                        [resultDict setObject:objDate forKey:key] ;
                    else
                        [resultDict setObject:@"" forKey:key] ;
                }
                else 
                    [resultDict setObject:((NSDate *)sDate).description forKey:key] ;
                }
           
        }
        else if ([propType isEqualToString:@"NSTimeZone"])
        {
            NSTimeZone *objTimeZone = [[NSTimeZone alloc]initWithName:[self valueForKey:currentProperty]] ;
            [resultDict setValue:objTimeZone forKey:key] ;
        }
        else if ([propType isEqualToString:@"NSDictionary"]) {
            
            NSDictionary* basicValue = [self valueForKey:currentProperty];
            
            if (basicValue) {
                [resultDict setObject:basicValue forKey:key];
            }
            
        }
        else if ([KVCBaseObject isPropertyTypeBasic:propType]) {
            
            id basicValue = [self valueForKey:currentProperty];
            if (basicValue == nil) {
                basicValue = @"";
            } else if([propType isEqualToString:@"BOOL"]) {
                basicValue = [basicValue boolValue]?@"true":@"false";
            }
            
            [resultDict setValue:basicValue forKey:key];
            
        } else {
            
            id kvcChild = [self valueForKey:currentProperty];
            if (kvcChild == nil) {
                kvcChild = [[KVCBaseObject alloc] init];
            }
            if ([kvcChild isKindOfClass:[KVCBaseObject class]]) {
                NSDictionary * childDict = [kvcChild objectToDictionary];
                [resultDict setValue:childDict forKey:key];
            }
            
        }
        
    }
    return resultDict;
}

- (NSString *)objectToJson {
    return [[self objectToDictionary] JSONRepresentation];
}

@end
