//
//  ViewController.m
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

Contato * contato;

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.contatoDao = [ContatoDao contatoDaoInstance];
        self.navigationItem.title = @"Cadastro";
        
        UIBarButtonItem * botaoAdicionaContato = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaNovoContato)];
        
        self.navigationItem.rightBarButtonItem = botaoAdicionaContato;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)criaNovoContato {
    [self pegaDadosFormulario];
    [self.contatoDao AdicionaContato:self.contato];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pegaDadosFormulario{
    
    self.contato = [Contato new];
    
    self.contato.nome     = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email    = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site     = self.site.text;
}

@end
