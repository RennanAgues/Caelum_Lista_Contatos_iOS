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

- (IBAction)pegaDadosFormulario:(UIButton *)sender {
    
    contato = [Contato new];
    
    contato.nome     = self.nome.text;
    contato.telefone = self.telefone.text;
    contato.email    = self.email.text;
    contato.endereco = self.endereco.text;
    contato.site     = self.site.text;
    
    [self.contatoDao AdicionaContato:contato];

}

@end
