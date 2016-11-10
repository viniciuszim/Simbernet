//
//  APIConnection.h
//  instanTag
//
//  Created by Don Bora on 3/26/14.
//  Copyright (c) 2014 Faraj Khasib. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id);
typedef void(^FailureBlock)(NSError *);

@interface APIConnection : NSObject

+ (APIConnection*)sharedInstance;


-(void)sendAsynchronousRequest:(NSString*)path
                    parameters:(NSDictionary*)parameters
                        method:(NSString*)method
                       success:(SuccessBlock)successBlock
                       failure:(FailureBlock)failureBlock;
@end
