//
//  FavoriteVenuesViewController.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 06/04/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "FavoriteVenuesViewController.h"
#import "AppDelegate.h"
#import "Venue.h"
#import <CoreData+MagicalRecord.h>

@interface FavoriteVenuesViewController ()

@property (strong, nonatomic) NSMutableArray *favorites;

@end

@implementation FavoriteVenuesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    if (!self.favorites) {
        self.favorites = [[NSMutableArray alloc] init];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSPredicate *predicateForFavorites = [NSPredicate predicateWithFormat:@"favorite == %@", [NSNumber numberWithBool:YES]];
    self.favorites = [[Venue MR_findAllWithPredicate:predicateForFavorites] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [[self drawerControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favorites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.favorites[indexPath.row];
    cell.textLabel.text = venue.name;
}

#pragma mark - DrawerController Helper

- (MMDrawerController *)drawerControllerFromAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    return appDelegate.drawerController;
}

@end
