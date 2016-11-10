
#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "HttpResponse.h"
#import "ResponseStatus.h"

@interface HttpRequest : NSObject{
    
    NSMutableData *_responseBody;
    NSObject *_target;
    SEL _callBack;
    NSURLRequest *request;
}

@property(nonatomic,strong)NSURLRequest *request;
@property(nonatomic,assign)int status;

//@property(nonatomic,strong)Error *Error;

+ (void)sendRequestForController: (NSString *)url
                 WithValues: (NSDictionary *)headers
                          Method:(NSString *)method
                   target: (NSObject *)target
 
                        callBack: (SEL)callBack;
-(void)retryRequest;

@end
