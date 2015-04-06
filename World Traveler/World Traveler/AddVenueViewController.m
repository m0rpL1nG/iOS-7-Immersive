//
//  AddVenueViewController.m
//  World Traveler
//
//  Created by Pierre-Yves LEBECQ on 06/04/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "AddVenueViewController.h"
#import "AppDelegate.h"
#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"
#import <CoreData+MagicalRecord.h>

@interface AddVenueViewController ()

@end

@implementation AddVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButtonPressed:(UIButton *)sender
{
    if ([self.nameTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Blank field" message:@"Please enter a venue name" delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles:nil] show];
    } else {
        Venue *venue = [Venue MR_createEntity];
        venue.name = self.nameTextField.text;
        Contact *contact = [Contact MR_createEntity];
        contact.phone = self.phoneNumberTextField.text;
        venue.contact = contact;
        FSCategory *category = [FSCategory MR_createEntity];
        category.name = self.typeOfFoodTextField.text;
        venue.categories = category;
        venue.favorite = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    }
}

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [[self drawerControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - DrawerController Helper

- (MMDrawerController *)drawerControllerFromAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    return appDelegate.drawerController;
}

@end
