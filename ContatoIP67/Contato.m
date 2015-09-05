//
//  Contato.m
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

//Override do metodo para descricao do objeto de acordo com o que voce queira apresentar

//
- (NSString *)description{
    return[NSString stringWithFormat:@"Nome: %@\n Telefone: %@\n E-mail: %@\n Endereço: %@\n Site: %@", self.nome, self.telefone,self.email, self.endereco, self.site];
}

@end
