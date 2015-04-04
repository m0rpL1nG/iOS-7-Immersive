//
//  DirectionsViewController.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 31/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "DirectionsViewController.h"
#import "DirectionsListViewController.h"

@interface DirectionsViewController ()

@end

@implementation DirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.directionsMap.delegate = self;

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DirectionsListViewController class]]) {
        DirectionsListViewController *directionsListVC = segue.destinationViewController;
        directionsListVC.steps = self.steps;
    }
}

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"DirectionsToListSegue" sender:nil];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];

    self.directionsMap.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000);
    [self.directionsMap setRegion:[self.directionsMap regionThatFits:region] animated:YES];

    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];

    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];

    [self getDirections:destinationMapItem];
}

#pragma mark - Helper methods

- (void)getDirections:(MKMapItem *)destination
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = YES;

    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            // Do something with error.
            NSLog(@"%@", error);
        } else {
            [self showRoute:response];
        }
    }];
}

- (void)showRoute:(MKDirectionsResponse *)response
{
    self.steps = response.routes;

    for (MKRoute *route in self.steps) {
//        for (MKRouteStep *step in route.steps) {
//            NSLog(@"%@", step.instructions);
//        }
        [self.directionsMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 3.0;

    return renderer;
}

@end
