//
//  Contato.h
//  ContatoIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject <MKAnnotation>

//Nome do Contato
@property (strong) NSString * nome;

//Telefone do Contato
@property (strong) NSString * telefone;

//E-mail do Contato
@property (strong) NSString * email;

//Endereco do Contato
@property (strong) NSString * endereco;

//Endereco de Site do Contato
@property (strong) NSString * site;

//Foto do contato
@property (strong) UIImage * foto;

//
@property (strong) NSNumber * latitude;

//
@property (strong) NSNumber * longitude;

@end
