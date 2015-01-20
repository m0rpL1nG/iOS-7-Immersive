//
//  LoginViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 14/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "Constants.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSMutableData *imageData;

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

            NSString *facebookId = userDictionary[@"id"];
            NSURL *pictureUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookId]];

            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
            if (userDictionary[@"name"]) {
                userProfile[kUserProfileNameKey] = userDictionary[@"name"];
            }
            if (userDictionary[@"first_name"]) {
                userProfile[kUserProfileFirstNameKey] = userDictionary[@"first_name"];
            }
            if (userDictionary[@"location"][@"name"]) {
                userProfile[kUserProfileLocationKey] = userDictionary[@"location"][@"name"];
            }
            if (userDictionary[@"gender"]) {
                userProfile[kUserProfileGenderKey] = userDictionary[@"gender"];
            }
            if (userDictionary[@"birthday"]) {
                userProfile[kUserProfileBirthdayKey] = userDictionary[@"birthday"];
            }
            if (userDictionary[@"interested_in"]) {
                userProfile[kUserProfileInterestedInKey] = userDictionary[@"interested_in"];
            }
            if ([pictureUrl absoluteString]) {
                userProfile[kUserProfilePictureURLKey] = [pictureUrl absoluteString];
            }

            [[PFUser currentUser] setObject:userProfile forKey:kUserProfileKey];
            [[PFUser currentUser] saveInBackground];

            [self requestImage];
        } else {
            NSLog(@"Error in FBRequest : %@", error);
        }
    }];
}

- (void)uploadPFFileToParse:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);

    if (!imageData) {
        NSLog(@"imageData was not found.");
        return;
    }

    PFFile *photoFile = [PFFile fileWithData:imageData];
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            PFObject *photo = [PFObject objectWithClassName:kPhotoClassKey];
            [photo setObject:[PFUser currentUser] forKey:kPhotoUserKey];
            [photo setObject:photoFile forKey:kPhotoPictureKey];
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"Photo saved successfuly");
            }];
        }
    }];
}

- (void)requestImage
{
    PFQuery *query = [PFQuery queryWithClassName:kPhotoClassKey];
    [query whereKey:kPhotoUserKey equalTo:[PFUser currentUser]];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!number) {
            PFUser *user = [PFUser currentUser];
            self.imageData = [[NSMutableData alloc] init];

            NSURL *profilePictureUrl = [NSURL URLWithString:user[kUserProfileKey][kUserProfilePictureURLKey]];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilePictureUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            if (!urlConnection) {
                NSLog(@"Failed to download picture.");
            }
        }
    }];
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *profileImage = [UIImage imageWithData:self.imageData];
    [self uploadPFFileToParse:profileImage];
}

@end
