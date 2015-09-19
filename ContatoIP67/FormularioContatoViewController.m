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
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];
        
        if(self.contato.foto){
            [self.botaoFoto setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
            [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
        }
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
    
    if([self.botaoFoto backgroundImageForState:UIControlStateNormal]){
        self.contato.foto = [self.botaoFoto backgroundImageForState:UIControlStateNormal];
    }
    
    self.contato.nome       = self.nome.text;
    self.contato.telefone   = self.telefone.text;
    self.contato.email      = self.email.text;
    self.contato.endereco   = self.endereco.text;
    self.contato.site       = self.site.text;
    self.contato.latitude   = [NSNumber numberWithFloat:[self.latitude.text floatValue]];
    self.contato.longitude   = [NSNumber numberWithFloat:[self.longitude.text floatValue]];
}

-(void) atualizaContato{
    [self pegaDadosFormulario];

    if(self.delegate){
        [self.delegate contatoAtualizado:contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar Foto",@"Escolher da biblioteca", nil];
        [sheet showInView:self.view];
    }else{
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)buscarCoordenadas:(id)sender {
    CLGeocoder * geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.endereco.text completionHandler:^(NSArray *resultados, NSError *error) {
        if(error == nil && [resultados count] > 0){
            CLPlacemark * resultado = resultados[0];
            CLLocationCoordinate2D coordenada = resultado.location.coordinate;
            self.latitude.text = [NSString stringWithFormat:@"%f",coordenada.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f",coordenada.longitude];
            
        }
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
    [self.botaoFoto setBackgroundImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            return;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}



@end
