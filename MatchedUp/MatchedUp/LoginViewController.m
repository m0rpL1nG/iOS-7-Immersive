//
//  LoginViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 14/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "LoginViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoginViewController

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

#pragma mark - IBActions

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    [self.activityIndicator startAnimating];

    NSArray *permissionsArray = @[@"user_about_me", @"user_interests", @"user_relationships", @"user_birthday", @"user_location", @"user_relationship_details"];

    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [self.activityIndicator stopAnimating];

        if (!user) {
            if (!error) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"The Facebook login was canceled" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }

            return;
        }

        [self updateUserInformation];
        [self performSegueWithIdentifier:@"loginToTabBarSegue" sender:self];
    }];
}

#pragma mark - Helper methods

- (void)updateUserInformation
{
    FBRequest *request = [FBRequest requestForMe];

    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userDictionary = (NSDictionary *)result;
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
            if (userDictionary[@"name"]) {
                userProfile[@"name"] = userDictionary[@"name"];
            }
            if (userDictionary[@"first_name"]) {
                userProfile[@"first_name"] = userDictionary[@"first_name"];
            }
            if (userDictionary[@"location"][@"name"]) {
                userProfile[@"location"] = userDictionary[@"location"][@"name"];
            }
            if (userDictionary[@"gender"]) {
                userProfile[@"gender"] = userDictionary[@"gender"];
            }
            if (userDictionary[@"birthday"]) {
                userProfile[@"birthday"] = userDictionary[@"birthday"];
            }
            if (userDictionary[@"interested_in"]) {
                userProfile[@"interested_in"] = userDictionary[@"interested_in"];
            }

            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
        } else {
            NSLog(@"Error in FBRequest : %@", error);
        }
    }];
}

@end
