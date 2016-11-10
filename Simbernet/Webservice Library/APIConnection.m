//
//  APIConnection.m
//  instanTag
//
//  Created by Don Bora on 3/26/14.
//  Copyright (c) 2014 Faraj Khasib. All rights reserved.
//

#import "APIConnection.h"

static APIConnection* sAPIConnection;


@implementation APIConnection


+(APIConnection*)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sAPIConnection = [APIConnection new];
    });
    return sAPIConnection;
}


-(void)sendAsynchronousRequest:(NSString*)path
                    parameters:(NSDictionary*)parameters
                        method:(NSString*)method
                       success:(SuccessBlock)successBlock
                       failure:(FailureBlock)failureBlock
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", HTTP_WebserviceBase, path]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    NSData *jsonData;
    NSString* postData;
    NSError* error;
    
    jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                               options:NSJSONWritingPrettyPrinted
                                                 error:&error];
    
    postData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    request.HTTPMethod = method;
    [request setValue:HTTP_JSONHeaderFieldValue forHTTPHeaderField:HTTP_AcceptHeaderFieldKey];
    [request setValue:HTTP_JSONHeaderFieldValue forHTTPHeaderField:HTTP_ContentTypeFiedKey];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:[NSString stringWithFormat:@"%d", (int)[[postData dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:HTTP_ContentLengthFieldKey];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            failureBlock(connectionError);
        }
        else{
            NSDictionary* results;
            NSError* error;
            
            results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                failureBlock(error);
            }
            else{
                successBlock(results);
            }
            
        }
    }];
}

@end
