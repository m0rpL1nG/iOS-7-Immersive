//
//  PYLAlbumTableViewController.m
//  Thousand Words
//
//  Created by Pierre-Yves LEBECQ on 09/06/2014.
//  Copyright (c) 2014 Pierre-Yves LEBECQ. All rights reserved.
//

#import "PYLAlbumTableViewController.h"
#import "Album.h"
#import "PYLCoreDataHelper.h"
#import "PYLPhotosCollectionViewController.h"

@interface PYLAlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation PYLAlbumTableViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];

    NSError *error = nil;

    NSArray *fetchedAlbums = [[PYLCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.albums = [fetchedAlbums mutableCopy];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    Album *album = [self.albums objectAtIndex:indexPath.row];
    cell.textLabel.text = album.name;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Album Chosen"]) {
        if ([segue.destinationViewController isKindOfClass:[PYLPhotosCollectionViewController class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            PYLPhotosCollectionViewController *photosCollectionViewController = segue.destinationViewController;
            photosCollectionViewController.album = self.albums[indexPath.row];
        }
    }
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.albums addObject:[self albumWithName:[alertView textFieldAtIndex:0].text]];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:([self.albums count] - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Actions

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender
{
    UIAlertView *newAlbumAlertView = [[UIAlertView alloc] initWithTitle:@"Enter new album name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [newAlbumAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [newAlbumAlertView show];
}

#pragma mark - Helper Methods

- (Album *)albumWithName:(NSString *)name
{
    NSManagedObjectContext *context = [PYLCoreDataHelper managedObjectContext];

    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];

    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@", error);
    }

    return album;
}

#pragma mark - Getters & Setters

// Lazy Instanciation
- (NSMutableArray *)albums
{
    if (!_albums) {
        _albums = [[NSMutableArray alloc] init];
    }

    return _albums;
}

@end
