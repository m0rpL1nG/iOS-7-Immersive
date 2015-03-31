//
//  MapViewController.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue *venue;

@end
