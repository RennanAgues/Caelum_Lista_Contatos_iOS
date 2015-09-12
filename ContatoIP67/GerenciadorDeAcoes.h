//
//  GerenciadorDeAcoes.h
//  ContatoIP67
//
//  Created by ios5436 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Contato.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface GerenciadorDeAcoes : NSObject<UIActionSheetDelegate,MFMailComposeViewControllerDelegate>

@property Contato * contato;
@property UIViewController * controller;

-(id) initWithContato:(Contato*) contato;
-(void) acoesDoController:(UIViewController*) controller;

@end
