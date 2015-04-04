//
//  ViewController.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 30/03/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "ListViewController.h"
#import <CoreData+MagicalRecord.h>
#import "FoursquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Location.h"
#import "Venue.h"
#import "MapViewController.h"

static NSString * const kClientId = @"CWISRYMJK3KRHUPICYARH1YDXB403Y1MQFQA02YWH4AM2US3";
static NSString * const kClientSecret = @"YGFHTQ0IFNXHOZ2RDO045YAGEWY1HD51F4KSUYLQ2HW2TKHX";

#define latitudeOffset 0.01
#define longitudeOffset 0.01

@interface ListViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    [self.locationManager requestWhenInUseAuthorization];

    FoursquareSessionManager *sessionManager = [FoursquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    AFMMRecordResponseSerializer *serializer = nil;
    serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:responseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    MapViewController *mapVC = segue.destinationViewController;
    mapVC.venue = venue;
}

#pragma mark - IBActions

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.locationManager startUpdatingLocation];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;

    return cell;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [self.locationManager stopUpdatingLocation];

    FoursquareSessionManager *sharedClient = [FoursquareSessionManager sharedClient];
    [sharedClient GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f", location.coordinate.latitude + latitudeOffset, location.coordinate.longitude + longitudeOffset] parameters:@{@"client_id": kClientId, @"client_secret": kClientSecret, @"v": @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *venues = responseObject;
        self.venues = venues;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ListToMapSegue" sender:indexPath];
}

@end
