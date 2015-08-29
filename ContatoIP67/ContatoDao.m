//
//  ContatoDao.m
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao

static ContatoDao *defaultDao = nil;

-(id)init{
    self = [super init];
    if(self){
        _listaContatos = [NSMutableArray new];
    }
    return self;
}

+(id)contatoDaoInstance{
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

-(void) AdicionaContato:(Contato *)contato{
    [self.listaContatos addObject:contato];
}

@end
