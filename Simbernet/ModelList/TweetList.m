//
//  TweetList.m
//  Simbernet
//
//  Created by Vinicius Miguel on 19/08/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "TweetList.h"

@implementation TweetList

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:HTTP_Field_List]) {
        return HTTP_Object_Tweet;
    }
    return nil;
}

@end
