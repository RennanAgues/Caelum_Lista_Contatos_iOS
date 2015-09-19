//
//  ContatosNoMapaViewController.h
//  ContatoIP67
//
//  Created by ios5436 on 19/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface ContatosNoMapaViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (strong) CLLocationManager *manager;

@end
