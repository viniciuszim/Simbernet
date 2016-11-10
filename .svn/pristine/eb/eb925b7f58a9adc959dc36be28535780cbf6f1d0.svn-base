
#import "HttpRequest.h"
#import "NSDictionary+UrlEncoding.h"
#import "ITException.h"
#import "Usuario.h"

@interface HttpRequest (Private)

- (void)performCallBack: (HttpResponse *)response;
- (void)sendRequestForController: (NSString *)url
                      WithValues: (NSDictionary *)headers
                          Method:(NSString *)method
                          target: (NSObject *)target
                        callBack: (SEL)callBack;

- (Usuario *)getUsuario;
- (void)handleInvalidAccessToken;

@end

@implementation HttpRequest

@synthesize request,status;

+ (void)sendRequestForController: (NSString *)url
                      WithValues: (NSDictionary *)headers
                          Method:(NSString *)method
                          target: (NSObject *)target
                        callBack: (SEL)callBack
{
    HttpRequest *request =[[HttpRequest alloc] init];
    [request sendRequestForController:url WithValues:headers Method:method target:target callBack:callBack];
}

- (void)sendRequestForController: (NSString *)url
                      WithValues: (NSDictionary *)headers
                          Method:(NSString *)method
                          target: (NSObject *)target
                        callBack: (SEL)callBack
{
    
    _target = target;
    _callBack = callBack;
    _responseBody = [NSMutableData data];
    
 
    url = [NSString stringWithFormat:@"%@%@", HTTP_WebserviceBase, url];

    NSMutableDictionary *parameters = nil;
    if(headers==nil)
        parameters =[NSMutableDictionary new];
    else
        parameters = [[NSMutableDictionary alloc] initWithDictionary:headers];
    
    
    NSString *accessToken = ([self getUsuario]).accessToken;
    if(accessToken) {
        [parameters setObject:accessToken forKey:HTTP_AccessTokenLabel];
    }
    [parameters setObject:HTTP_Platform forKey:HTTP_PlatformLabel];
    
    NSString *parameter=nil;
    
    if([method isEqualToString:HTTP_Get])
        parameter =[parameters EncodedUrlParameters];
    else
        parameter = [parameters JSONRepresentation];
    
    NSLog(@"Url : %@ \nMethod : %@ \nParameters : %@",url,method,parameter);
    
    
    NSMutableURLRequest *urlRequest;
    if(method)
    {
        if([method isEqualToString:HTTP_Get]) {
            if(parameter&&[parameter length]!=0)
                url = [NSString stringWithFormat:@"%@?%@",url,parameter ];
            urlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: url]];
        } else {

            urlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: url]];
            [urlRequest setValue:HTTP_JSONHeaderFieldValue forHTTPHeaderField:HTTP_AcceptHeaderFieldKey];
            [urlRequest setValue:HTTP_JSONHeaderFieldValue forHTTPHeaderField:HTTP_AcceptHeaderFieldKey];
            [urlRequest setValue:HTTP_JSONHeaderFieldValue forHTTPHeaderField:HTTP_ContentTypeFiedKey];
            [urlRequest setValue:[NSString stringWithFormat:@"%d", (int)[[parameter dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:HTTP_ContentLengthFieldKey];
//            NSLog(@"%d", (int)[[parameter dataUsingEncoding:NSUTF8StringEncoding] length]);
            [urlRequest setHTTPBody:[parameter dataUsingEncoding:NSISOLatin1StringEncoding]];
        }
        [urlRequest setHTTPMethod:method];
        
    }else
        [[[ITException alloc] initWithName:@"Request" reason:@"UnknownMethod" userInfo:nil] raise];
    
	
#ifdef CONNECTION_ALLOW_ANY_HTTPS_CERTIFICATE
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[[NSURL URLWithString: url] host]];
    
#endif
    NSLog(@"urlRequest: %@", urlRequest);
    self.request = urlRequest;
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest: urlRequest delegate: self];
    [connection start];
}

#pragma mark Connection Events

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    status = (int)[httpResponse statusCode];
    if (_responseBody) {
        [_responseBody setLength: 0];
    }
}

- (void)connection: (NSURLConnection *)conn didReceiveData: (NSData *)data {
    
    if (_responseBody && data) {
        [_responseBody appendData: data];
    }
}

- (void)connectionDidFinishLoading: (NSURLConnection *)conn
{

    NSString *responseString = [[NSString alloc] initWithData: _responseBody encoding: NSUTF8StringEncoding];
    HttpResponse *response = [HttpResponse new];
    response.request = self;
    response.status= self.status;
    
    @try{
        
//        responseString = [responseString stringByReplacingOccurrencesOfString:@":null" withString:@":nil"];
//        NSLog(@"Response String %@",responseString);
        if(responseString==nil)
            [[[ITException alloc] initWithName:@"Response"
                                        reason:@"UNKNown Response" userInfo:nil] raise];
        ResponseStatus *responseStatus = (ResponseStatus *) [ResponseStatus objectForJSON:responseString];
        /*
         SUCCESS=0,
         IN_VALID_ACCESS_TOKEN=1,
         ERROR_WITH_MESSAGE=2,
         SERVER_ERROR=3
         */
        switch (responseStatus.responseCode)
        {
            case SUCCESS:
                if(responseStatus.responseCodeText != nil && responseStatus.responseCodeText.length > 0) {
                    response.errorText = HTTP_SERVER_ERROR_MESSAGE;
                    break;
                }
                if(responseStatus.data!=nil)
                {
                    
                    response.responseData = [[NSString alloc] initWithData:
                                             [NSJSONSerialization dataWithJSONObject:responseStatus.data
                                                                             options:NSJSONWritingPrettyPrinted
                                                                               error:NULL] encoding:NSUTF8StringEncoding];
                }
                break;
            case IN_VALID_ACCESS_TOKEN :
                [self handleInvalidAccessToken];
                return;
                
            case ERROR_WITH_MESSAGE:;
                response.errorText = responseStatus.error;
                break;
            case SERVER_ERROR:;
                response.errorText = HTTP_SERVER_ERROR_MESSAGE;
                break;
            default:
                response.errorText = HTTP_UNKNOWN_ERROR_MESSAGE;
                break;
        }
    }
    @catch (NSException *exception)
    {
        response.errorText = HTTP_UNKNOWN_ERROR_MESSAGE;
    }
    [self performCallBack: response];
}

- (void)connection: (NSURLConnection *)conn didFailWithError: (NSError *)error {
    
    HttpResponse *response = [HttpResponse new];
    response.Request = self;
    response.errorText = HTTP_FAILED_TO_CONNECT_MESSAGE;
    [self performCallBack: response];
}

#pragma mark Connection Events End

- (void)performCallBack: (HttpResponse *)response {
    
    if (_target && [_target respondsToSelector: _callBack]) {
        
        [_target performSelector:_callBack withObject:response afterDelay:0.0f];
        
    }
}
-(void)retryRequest
{
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest: self.request delegate: self];
    [connection start];
}

-(Usuario *)getUsuario
{
    return [Usuario getUsuario];
}

-(void)handleInvalidAccessToken{
    [Usuario deleteUsuario];
    
    #warning TODO 
    //agora tem que fazer o reload do aplicativo quando a sessão tiver pronta
    
}

@end
