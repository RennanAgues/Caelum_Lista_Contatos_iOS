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

//Variavel de instanciad da classe dao
+(id) contatoDaoInstance;

//Metodo para adicionar contato na lista de contatos
-(void) adicionaContato:(Contato *)contato;

//Metodo para remover contato da lista de contatos
-(void) removeContato:(NSInteger)posicao;

//Metodo para resgatar um contato a partir da posicao indicada
-(Contato *) buscaContatoDaPosicao:(NSInteger) posicao;


@end
