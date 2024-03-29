//
//  PYLOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by Pierre-Yves LEBECQ on 16/03/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "PYLSpaceObject.h"
#import "PYLSpaceImageViewController.h"
#import "PYLSpaceDataViewController.h"

@interface PYLOuterSpaceTableViewController ()

@end

@implementation PYLOuterSpaceTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instanciations of properties

- (NSMutableArray *)planets
{
    if (!_planets) {
        _planets = [[NSMutableArray alloc] init];
    }

    return _planets;
}

- (NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects) {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }

    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]) {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        PYLSpaceObject *planet = [[PYLSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }

    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists) {
        PYLSpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:spaceObject];
    }

//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
//    NSString *firstColor = @"red";
//    [dictionary setObject:firstColor forKey:@"firetruck color"];
//    [dictionary setObject:@"blue" forKey:@"ocean color"];
//    [dictionary setObject:@"yellow" forKey:@"star color"];
//    NSLog(@"%@", dictionary);
//
//    NSString *blueString = [dictionary objectForKey:@"ocean color"];
//    NSLog(@"%@", blueString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PYLAddSpaceObjectViewControllerDelegate methods

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addSpaceObject:(PYLSpaceObject *)spaceObject
{
    [self.addedSpaceObjects addObject:spaceObject];

    // Save to NSUserDefaults
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if (!spaceObjectsAsPropertyLists) {
        spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    }
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectsAsAPropertyList:spaceObject]];
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // Dismiss the modal view controller.
    [self dismissViewControllerAnimated:YES completion:nil];

    // Make the tableview reload the data to update itself.
    [self.tableView reloadData];
}

#pragma mark - Helper methods

- (NSDictionary *)spaceObjectsAsAPropertyList:(PYLSpaceObject *)spaceObject
{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.image);
    NSDictionary *dictionary = @{PLANET_NAME: spaceObject.name, PLANET_GRAVITY: @(spaceObject.gravitationalForce), PLANET_DIAMETER: @(spaceObject.diameter), PLANET_YEAR_LENGTH: @(spaceObject.yearLength), PLANET_DAY_LENGTH: @(spaceObject.dayLength), PLANET_TEMPERATURE: @(spaceObject.temperature), PLANET_NUMBER_OF_MOONS: @(spaceObject.numberOfMoons), PLANET_NICKNAME: spaceObject.nickname, PLANET_INTERESTING_FACT: spaceObject.interestingFact, PLANET_IMAGE: imageData};

    return dictionary;
}

- (PYLSpaceObject *)spaceObjectForDictionary:(NSDictionary *)dictionary
{
    NSData *dataForImage = dictionary[PLANET_IMAGE];
    UIImage *spaceObjectImage = [UIImage imageWithData:dataForImage];
    PYLSpaceObject *spaceObject = [[PYLSpaceObject alloc] initWithData:dictionary andImage:spaceObjectImage];

    return spaceObject;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.addedSpaceObjects count]) {
        return 2;
    }

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return [self.addedSpaceObjects count];
    }

    return [self.planets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    if (indexPath.section == 1) {
        PYLSpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.image;
    } else {
        PYLSpaceObject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.image;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }

    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newSavedSpaceObjectData = [[NSMutableArray alloc] init];
        for (PYLSpaceObject *spaceObject in self.addedSpaceObjects) {
            [newSavedSpaceObjectData addObject:[self spaceObjectsAsAPropertyList:spaceObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        if ([segue.destinationViewController isKindOfClass:[PYLSpaceImageViewController class]]) {
            PYLSpaceImageViewController *nextController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            PYLSpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            } else if (path.section == 1) {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            nextController.spaceObject = selectedObject;
        }
    }

    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[PYLSpaceDataViewController class]]) {
            PYLSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            PYLSpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            } else if (path.section == 1) {
                selectedObject = self.addedSpaceObjects[path.row];
            }

            targetViewController.spaceObject = selectedObject;
        }
    }

    if ([segue.destinationViewController isKindOfClass:[PYLAddSpaceObjectViewController class]]) {
        PYLAddSpaceObjectViewController *addSpaceObjectViewController = segue.destinationViewController;
        addSpaceObjectViewController.delegate = self;
    }
}

@end
