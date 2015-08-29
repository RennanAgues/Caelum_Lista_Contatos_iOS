//
//  ContatoDao.h
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@interface ContatoDao : NSObject

@property (strong, readonly) NSMutableArray *listaContatos;

+(id) contatoDaoInstance;

-(void) AdicionaContato:(Contato *)contato;

@end
