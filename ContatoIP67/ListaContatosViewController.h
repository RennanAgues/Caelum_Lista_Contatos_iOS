//
//  ListaContatosViewController.h
//  ContatoIP67
//
//  Created by ios5436 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ContatoDao.h"
#import "FormularioContatoViewController.h"
#import "GerenciadorDeAcoes.h"


@interface ListaContatosViewController : UITableViewController<FormularioContatoViewControllerDelegate>

@property (strong)  ContatoDao  *dao;
@property (strong)  Contato     *contatoSelecionado;
@property           NSInteger   linhaDestacada;
@property (readonly) GerenciadorDeAcoes * gerenciador;

-(void) exibirMaisAcoes:(UIGestureRecognizer *) gesture;

@end
