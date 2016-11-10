
#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@class HttpRequest;
@interface HttpResponse : NSObject
{
NSString *_responseData;
NSString *_errorText;
}

/// Gets or sets the response data.
@property (nonatomic,strong) NSString *responseData;
@property(nonatomic,strong)HttpRequest *request;
/// Gets or sets the error text.
@property (nonatomic,strong) NSString *errorText;
@property(nonatomic,assign)int status;

/// Gets error status for response. Returns YES if request has been failed.
@property (readonly, getter = getHasError) BOOL hasError;

@end
