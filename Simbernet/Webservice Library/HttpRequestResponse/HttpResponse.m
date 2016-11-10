
#import "HttpResponse.h"

@implementation HttpResponse

@synthesize responseData = _responseData;
@synthesize errorText = _errorText;
@synthesize request;
@synthesize status;

- (BOOL)getHasError {
    
    return self.errorText != nil;
}
@end
