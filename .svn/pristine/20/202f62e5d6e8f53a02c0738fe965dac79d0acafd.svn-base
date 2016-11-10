//
//  NoticiaService.h
//  Simbernet
//
//  Created by Marcio Pinto on 23/04/15.
//  Copyright (c) 2015 Simber. All rights reserved.
//

#import "BaseService.h"
#import "Noticia.h"
#import "Comentario.h"

@protocol NoticiaServiceDelegate <BaseServiceDelegate>

@optional
- (void) listNoticiasReturns:(NSArray*) noticiasList;
- (void) listComentariosReturns:(NSArray*) comentariosList;
- (void) inserirComentarioReturns:(Comentario*)comentario success:(BOOL)success;
- (void) apagarComentarioReturns:(Comentario*)comentario success:(BOOL)success;
@end

@interface NoticiaService : BaseService

- (void) listNoticias:(int)pagina;
- (void) listComentarios:(long)codigo;
- (void) inserirComentario:(Comentario*)comentario;
- (void) apagarComentario:(long)codigo;

@end
