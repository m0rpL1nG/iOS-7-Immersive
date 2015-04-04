//
//  DirectionsViewController.h
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 31/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"

@interface DirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *directionsMap;

@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *steps;

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
