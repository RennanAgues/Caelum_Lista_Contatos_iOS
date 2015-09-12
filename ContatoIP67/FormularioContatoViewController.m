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

//Metodo de inicializacao da classe quando ela é ligada a interface visual
-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        //resgate da instacia para acesso ao Dao
        self.contatoDao = [ContatoDao contatoDaoInstance];
        
        //Titulo da View a partir do navigation
        self.navigationItem.title = @"Cadastro";
        
        //Criacao de botao para adicao de um novo contato
        UIBarButtonItem * botaoAdicionaContato = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaNovoContato)];
        
        //inclusao de botao ao navigation
        self.navigationItem.rightBarButtonItem = botaoAdicionaContato;
    }
    return self;
}

- (void)viewDidLoad {
    
    //Carregar Contato no formulário caso o objeto esteja populado
    if(self.contato){
        self.navigationItem.title = @"Alterar";
        
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        
        self.navigationItem.rightBarButtonItem = confirmar;
        
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Criacao de um novo contato
- (void)criaNovoContato {
    [self pegaDadosFormulario];
    [self.contatoDao adicionaContato:self.contato];
    
    if(self.delegate){
        [self.delegate contatoAdicionado:contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//Resgata dados do formulario para insercao a lista
- (void)pegaDadosFormulario{
    
    if(!self.contato){
        self.contato = [Contato new];   
    }
    
    self.contato.nome     = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email    = self.email.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site     = self.site.text;
}

-(void) atualizaContato{
    [self pegaDadosFormulario];

    if(self.delegate){
        [self.delegate contatoAtualizado:contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
