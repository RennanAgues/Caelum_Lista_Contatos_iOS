//
//  ContatoDao.m
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao

//Inicializacao da variavel de acesso ao Dao
static ContatoDao *defaultDao = nil;

//Metodo de inicializacao da classe
-(id)init{
    self = [super init];
    if(self){
        _listaContatos = [NSMutableArray new];
        [self inserirDados];
        [self carregaContatos];
    }
    return self;
}

//Metodo de recuperacao da instancia para acesso ao Dao
+(id)contatoDaoInstance{
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

//Metodo para adicao de um novo contato a lista de contatos
-(void) adicionaContato:(Contato *)contato{
    [self.listaContatos addObject:contato];
    
    NSLog(@"Contatos : %@", self.listaContatos);
}

//Metodo para remover um novo contato da lista de contatos
-(void) removeContato:(NSInteger)posicao{
    [self.listaContatos removeObjectAtIndex:posicao];
    
    NSLog(@"Contatos : %@", self.listaContatos);
}

-(Contato *) novoContato{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
}

//Busca contato a partir da posicao indicada
-(Contato *) buscaContatoDaPosicao:(NSInteger) posicao{
    return self.listaContatos[posicao];
}

//Busca posicao do contato a partir do contato
-(NSInteger) buscaPosicaoDoContato:(Contato *) contato{
    return [self.listaContatos indexOfObject:contato];
}

-(void) carregaContatos{
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    buscaContatos.sortDescriptors = @[ordenarPorNome];
    NSArray *contatosMutavies = [self.managedObjectContext executeFetchRequest:buscaContatos error:nil];
    _listaContatos = [contatosMutavies mutableCopy];
}

-(void) removeContatoDaPosicao:(NSInteger)posicao{
    Contato * c = [self buscaContatoDaPosicao:posicao];
    [self.managedObjectContext deleteObject:c];
    [self.listaContatos removeObjectAtIndex:posicao];
    [self saveContext];
}

-(void) inserirDados{
    NSUserDefaults * configuracoes = [NSUserDefaults standardUserDefaults];
    
    BOOL dadosInseridos = [configuracoes boolForKey:@"dados_inseridos"];
    
    if(!dadosInseridos){
        Contato * contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.managedObjectContext];
        
        contato.nome = @"Caelum unidade Sao Paulo";
        contato.email = @"contato@caelum.com";
        contato.endereco = @"Sao Paulo, SR, Rua Vergueiro, 3185";
        contato.telefone = @"01155712751";
        contato.site = @"http://www.caelum.com.br";
        contato.latitude = [NSNumber numberWithDouble:-23.5883034];
        contato.longitude =[NSNumber numberWithDouble:-46.632369];
        
        [self saveContext];
        [configuracoes setBool:YES forKey:@"dados_inseridos"];
        [configuracoes synchronize];
        
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "br.com.caelum.ContatoIP67" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ContatoIP67" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ContatoIP67.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
