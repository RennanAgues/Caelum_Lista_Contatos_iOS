//
//  ViewController.h
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"

@interface FormularioContatoViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;

//Metodo para criacao de um novo contato a partir do formulario
- (void)criaNovoContato;

//Instancia do dao
@property (strong) ContatoDao *contatoDao;

//Armazenamento da variavel contato para uso na propria classe
@property (strong) Contato *contato;

@end

