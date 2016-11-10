
#import <Foundation/Foundation.h>
#import "KVCBaseObject.h"

typedef enum ResponseStatusCodeValues {
    SUCCESS = 0,
    IN_VALID_ACCESS_TOKEN = 1,
    ERROR_WITH_MESSAGE = 2,
    SERVER_ERROR = 3
} ResponseState;


@interface ResponseStatus : KVCBaseObject {
    
}

@property(nonatomic,assign)int responseCode;
@property(nonatomic,strong)NSString *responseCodeText;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSString *error;

@end
