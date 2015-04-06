//
//  MenuViewController.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 04/04/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "MenuViewController.h"
#import "ListViewController.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UINavigationController *listNavigationController;
@property (strong, nonatomic) UINavigationController *favoriteVenuesNavigationController;
@property (strong, nonatomic) UINavigationController *addVenueNavigationController;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    if (!self.viewControllers) {
        self.viewControllers = [[NSMutableArray alloc] initWithCapacity:3];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    if (!self.listNavigationController) {
        MMDrawerController *drawerController = [self drawerControllerFromAppDelegate];
        self.listNavigationController = (UINavigationController *)drawerController.centerViewController;
        [self.viewControllers addObject:self.listNavigationController];
    }
    if (!self.favoriteVenuesNavigationController) {
        self.favoriteVenuesNavigationController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"FavoriteVenuesViewControllerID"];
        [self.viewControllers addObject:self.favoriteVenuesNavigationController];
    }
    if (!self.addVenueNavigationController) {
        self.addVenueNavigationController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"AddVenueViewControllerID"];
        [self.viewControllers addObject:self.addVenueNavigationController];
    }

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Home";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Favorites";
    } else {
        cell.textLabel.text = @"Add venue";
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMDrawerController *drawerController = [self drawerControllerFromAppDelegate];
    [drawerController setCenterViewController:self.viewControllers[indexPath.row] withCloseAnimation:YES completion:nil];
}

#pragma mark - DrawerController Helper

- (MMDrawerController *)drawerControllerFromAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    return appDelegate.drawerController;
}

@end
