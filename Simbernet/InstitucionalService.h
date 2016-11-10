//
//  InstitucionalService.h
//  Simbernet
//
//  Created by Marcio Pinto on 22/03/15.
//  Copyright (c) 2015 in6. All rights reserved.
//

#import "BaseService.h"
#import "InstitucionalModel.h"

@protocol InstitucionalServiceDelegate <BaseServiceDelegate>

@optional

- (void) obterPorChaveReturn:(InstitucionalModel*)institucional success:(BOOL)success;
- (void) listInstitucionaisMobileReturns:(NSArray*) institucionaisList;

@end

@interface InstitucionalService : BaseService

- (void)obterPorChave:(NSString*) chave;
- (void) listInstitucionaisMobile:(int) pagina;

@end
