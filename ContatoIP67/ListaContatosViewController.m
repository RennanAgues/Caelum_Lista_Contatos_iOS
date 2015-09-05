//
//  ListaContatosViewController.m
//  ContatoIP67
//
//  Created by ios5436 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController

-(id)init{
    self = [super init];
    if(self){
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem * botaoExibeFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
        
        self.navigationItem.rightBarButtonItem = botaoExibeFormulario;
        
    }
    return self;
}

-(void) exibeFormulario{
//Alert
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Titulo" message:@"Mensagem" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *form = [storyBoard instantiateViewControllerWithIdentifier:@"Form-Contato"];
    
    [self.navigationController pushViewController:form animated:YES];
    
    
}

@end
