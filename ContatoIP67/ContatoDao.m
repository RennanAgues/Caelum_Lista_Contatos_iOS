//
//  ContatoDao.m
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao

//Inicializacao da variavel de acesso ao Dao
static ContatoDao *defaultDao = nil;

//Metodo de inicializacao da classe
-(id)init{
    self = [super init];
    if(self){
        _listaContatos = [NSMutableArray new];
    }
    return self;
}

//Metodo de recuperacao da instancia para acesso ao Dao
+(id)contatoDaoInstance{
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

//Metodo para adicao de um novo contato a lista de contatos
-(void) adicionaContato:(Contato *)contato{
    [self.listaContatos addObject:contato];
    
    NSLog(@"Contatos : %@", self.listaContatos);
}

//Metodo para remover um novo contato da lista de contatos
-(void) removeContato:(NSInteger)posicao{
    [self.listaContatos removeObjectAtIndex:posicao];
    
    NSLog(@"Contatos : %@", self.listaContatos);
}


//Busca contato a partir da posicao indicada
-(Contato *) buscaContatoDaPosicao:(NSInteger) posicao{
    return self.listaContatos[posicao];
}

//Busca posicao do contato a partir do contato
-(NSInteger) buscaPosicaoDoContato:(Contato *) contato{
    return [self.listaContatos indexOfObject:contato];
}



@end
