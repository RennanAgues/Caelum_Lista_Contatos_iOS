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
        //Nome para titulo da Tela
        self.navigationItem.title = @"Contatos";
        
        //Botao de adicao de um novo contato
        UIBarButtonItem * botaoExibeFormulario = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(exibeFormulario)];
        
        //Adiciona botao da direita ao navigation
        self.navigationItem.rightBarButtonItem = botaoExibeFormulario;

        //Adiciona botao da esquerda ao navigation
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        //Recupera instancia do dao
        self.dao = [ContatoDao contatoDaoInstance];
        
        self.linhaDestacada = -1;
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void) viewDidAppear:(BOOL)animated{
    if(self.linhaDestacada >= 0){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.linhaDestacada inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        self.linhaDestacada = -1;


    }
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibirMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:longPress];
}

//Metodo que aciona a tela de formulario do contato
-(void) exibeFormulario{
    // Criacao de um alert
    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Titulo" message:@"Mensagem" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    // [alert show];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *form = [storyBoard instantiateViewControllerWithIdentifier:@"Form-Contato"];
    
    form.delegate = self;
    
    if(self.contatoSelecionado){
        form.contato = self.contatoSelecionado;
    }
    
    //Redireciona para a Controller indicada
    [self.navigationController pushViewController:form animated:YES];
}

//Retorna o numero de sessoes que a tableView tera
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//Retorna numero de linhas que a sessao tera
-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dao.listaContatos count];
}

//Adiciona o Contato para a celula
-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Contato * contato = [self.dao buscaContatoDaPosicao:indexPath.row];
    cell.textLabel.text = contato.nome;
    
    return cell;
}

//Sobrescrita do metodo de edicao
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.dao removeContato:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.contatoSelecionado = [self.dao buscaContatoDaPosicao:indexPath.row];
    
    [self exibeFormulario];
    self.contatoSelecionado = nil;
}

-(void) contatoAdicionado:(Contato *)contato{
    self.linhaDestacada = [self.dao buscaPosicaoDoContato:contato];
}

-(void) contatoAtualizado:(Contato *)contato{
    self.linhaDestacada = [self.dao buscaPosicaoDoContato:contato];
}

-(void) exibirMaisAcoes:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesture locationInView:self.tableView];
        
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        
        if(index){
        
        self.contatoSelecionado = [self.dao buscaContatoDaPosicao:index.row];
            
            _gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:self.contatoSelecionado];
            [self.gerenciador acoesDoController:self];
        }
        
    }
}


@end
